# rubocop:disable Style/FormatStringToken
plugin "git"
plugin "env"
plugin "bundler"
plugin "rails"
plugin "nodenv"
plugin "puma"
plugin "rbenv"
plugin "./plugins/mini-irawo.rb"

host ENV["TOMO_HOST"]

set application: "mini-irawo"
set deploy_to: "/var/www/%{application}"
set rbenv_ruby_version: "3.3.5"
set nodenv_node_version: "23.1.0"
set nodenv_install_yarn: true
set git_url: "https://github.com/tobihans/mini-irawo.git"
set git_branch: "main"
set git_exclusions: %w[
      .tomo/
      spec/
      test/
    ]
set env_vars: {
  RAILS_ENV: "production",
  RUBY_YJIT_ENABLE: "1",
  BOOTSNAP_CACHE_DIR: "tmp/bootsnap-cache",
  RAILS_MASTER_KEY: ENV["TOMO_RAILS_MASTER_KEY"],
  SEED_PROD: "yes"
}
set linked_dirs: %w[
      .yarn/cache
      log
      node_modules
      public/assets
      public/packs
      public/vite
      tmp/cache
      tmp/pids
      tmp/sockets
    ]

setup do
  run "env:setup"
  run "core:setup_directories"
  run "git:config"
  run "git:clone"
  run "git:create_release"
  run "core:symlink_shared"
  run "nodenv:install"
  run "rbenv:install"
  run "bundler:upgrade_bundler"
  run "bundler:config"
  run "bundler:install"
  run "rails:db_create"
  run "rails:db_schema_load"
  run "rails:db_seed"
  run "puma:setup_systemd"
end

deploy do
  run "env:update"
  run "git:create_release"
  run "core:symlink_shared"
  run "core:write_release_json"
  run "bundler:install"
  run "rails:db_migrate"
  run "rails:db_seed"
  run "rails:assets_precompile"
  run "core:symlink_current"
  run "puma:restart"
  run "puma:check_active"
  run "core:clean_releases"
  run "bundler:clean"
  run "core:log_revision"
end
# rubocop:enable Style/FormatStringToken
