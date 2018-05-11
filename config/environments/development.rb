Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker


  # メーラー
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => true,
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => 'smtp.gmail.com',
    :user_name => ENV['MAILER_USER_NAME'], #gmailアドレス
    :password => ENV['MAILER_PASSWORD'], #gmailパスワード
    :authentication => 'login',
  }

  config.after_initialize do
    
    Bullet.enable = true   # bullet を有効にする
    
    # 以下はN+1問題を発見した時のユーザーへの通知方法
    Bullet.alert         = true # ブラウザのJavaScriptアラート
    Bullet.bullet_logger = true # Rails.root/log/bullet.log
    Bullet.console       = true # ブラウザの console.log の出力先
    Bullet.rails_logger  = true # Railsのログ
    #Bullet.bugsnag      = true # 総合デバッガツールbugsnag
    #Bullet.airbrake     = true # Airbrake
    #Bullet.raise        = true # Exceptionを発生
    Bullet.add_footer    = true # 画面の下部に表示
   
    # ホワイトリストを指定するときの例
    #Bullet.add_whitelist type: :n_plus_one_query, class_name: 'User', association: :prefecture
    #Bullet.add_whitelist type: :unused_eager_loading, class_name: 'User', association: :prefecture
    #Bullet.add_whitelist type: :counter_cache, class_name: 'User', association: :comments
    
  end
  
end
