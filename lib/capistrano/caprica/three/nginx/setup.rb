Capistrano::Configuration.instance.load do
  default_run_options[:pty] = true

  namespace :nginx do
    task :setup, role: -> { fetch :nginx_setup_role, :web } do
      transaction do
        top.nginx.install
        top.nginx.config
        top.nginx.sites.available
        top.nginx.sites.enable
      end
    end
  end
end
