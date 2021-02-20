Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory
  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # ���[���[
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => true,
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => 'gmail.com',
    :user_name => ENV['MAILER_USER_NAME'], #gmail�A�h���X
    :password => ENV['MAILER_PASSWORD'], #gmail�p�X���[�h
    :authentication => 'plain',
  }
  config.action_mailer.delivery_method = :letter_opener_web

  config.after_initialize do
    
    Bullet.enable = true   # bullet ��L���ɂ���
    
    # �ȉ���N+1���𔭌��������̃��[�U�[�ւ̒ʒm���@
    Bullet.alert         = true # �u���E�U��JavaScript�A���[�g
    Bullet.bullet_logger = true # Rails.root/log/bullet.log
    Bullet.console       = true # �u���E�U�� console.log �̏o�͐�
    Bullet.rails_logger  = true # Rails�̃��O
    #Bullet.bugsnag      = true # �����f�o�b�K�c�[��bugsnag
    #Bullet.airbrake     = true # Airbrake
    #Bullet.raise        = true # Exception�𔭐�
    Bullet.add_footer    = true # ��ʂ̉����ɕ\��
   
    # �z���C�g���X�g���w�肷��Ƃ��̗�
    #Bullet.add_whitelist type: :n_plus_one_query, class_name: 'User', association: :prefecture
    #Bullet.add_whitelist type: :unused_eager_loading, class_name: 'User', association: :prefecture
    #Bullet.add_whitelist type: :counter_cache, class_name: 'User', association: :comments
    
  end
  
end
