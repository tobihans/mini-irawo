srand(2048)

if ENV["RAILS_ENV"] == "production" && !ENV.key?("SEED_PROD")
  STDERR.puts "SEED_PROD is not set. Skipping seeding."
  exit!
end

CATEGORIES = %w[EdTech Marketing OnlineCourses DigitalMarketing E-Learning ContentCreation SocialMediaMarketing]

CATEGORIES.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

DEFAULT_PASSWORD = "password"

if ENV.key?("DEFAULT_CLIENT_EMAIL")
  User.create_with(is_staff: false, password: ENV.fetch("DEFAULT_CLIENT_PASSWORD ", DEFAULT_PASSWORD))
    .find_or_create_by!(email_address: ENV["DEFAULT_CLIENT_EMAIL"])
end

if ENV.key?("DEFAULT_ADMIN_EMAIL")
  User.create_with(is_staff: true, password: ENV.fetch("DEFAULT_CLIENT_PASSWORD ", DEFAULT_PASSWORD))
    .find_or_create_by!(email_address: ENV["DEFAULT_ADMIN_EMAIL"])
end

RESOURCES_COUNT = 25
LOREM = File.read(Rails.root.join("seed-files/lorem.txt"))
CLIENT = User.where(email_address: ENV["DEFAULT_CLIENT_EMAIL"]).first

RESOURCES_COUNT.times do |i|
  kind = Resource::VALID_KINDS.sample
  name = 4.times.map { (0...(rand(10))).map { ("a".."z").to_a[rand(26)] }.join }.join(" ").titleize
  price = [ 0, rand(100) ].sample
  resource = Resource.new(
    description: LOREM,
    kind: kind,
    name: name,
    price: price,
    category: Category.where(name: CATEGORIES.sample).first,
  )
  resource.image.attach(
    io: File.open(Rails.root.join("seed-files/image.png")),
    filename: "image-#{rand}.png",
  )

  if kind == "url"
    resource.url = "https://tobihans.space"
  else
    resource.file.attach(
      io: File.open(Rails.root.join("seed-files/blank.pdf")),
      filename: "attachment-#{rand}.pdf",
    )
  end
  unless resource.save
    STDERR.puts resource.errors.full_messages.join("\n")
    STDERR.puts "Failed to create resource #{i}"
  end

  if rand > 0.5
    order = Order.new(user: CLIENT, resource: resource)
    unless order.save
      STDERR.puts resource.errors.full_messages.join("\n")
      STDERR.puts "Failed to create order for resource #{i}"
    end
  end
end
