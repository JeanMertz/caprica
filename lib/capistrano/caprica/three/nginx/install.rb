# encoding: utf-8
require 'open-uri'
# Set OpenURI buffer to 0, always create FileIO instead of StringIO
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

Capistrano::Configuration.instance.load do
  default_run_options[:pty] = true

  namespace :nginx do
    desc 'Install nginx'
    task :install, role: -> { fetch :nginx_install_role, :web_root } do
      transaction do
        # break if already installed
        break skip('nginx already installed') if remote_file_exists? '/etc/init.d/nginx'

        # set rollback instructions
        on_rollback do
          error
          run "rm -rf /etc/apt/sources.list.d/nginx"
          run 'apt-get -y purge nginx'
          run "rm -rf #{fetch :nginx_sites_available_path, '/var/nginx/sites-available'}"
          run "rm -rf #{fetch :nginx_sites_enable_path, '/var/nginx/sites-enabled'}"
          run %Q{apt-key remove `apt-key list | grep 'nginx' -b1 | grep -Eo '[0-9A-Z]{6,}'`}
        end

        # add nginx package repository signed key to apt-key
        notify 'downloading nginx package signed key'
        run 'curl http://nginx.org/packages/keys/nginx_signing.key | apt-key add -'
        #run "curl http://nginx.org/packages/keys/nginx_signing.key | #{try_sudo} apt-key add -"

        # set-up official package repository sources
        sources = "deb http://nginx.org/packages/debian/ squeeze nginx\n
          deb-src http://nginx.org/packages/debian/ squeeze nginx"
        notify 'adding official nginx repository to apt sources'
        put sources, '/etc/apt/sources.list.d/nginx'

        # update sources content
        notify 'updating apt sources content'
        run 'apt-get -y update'

        # install latest nginx release
        notify 'installing nginx from apt-get'
        run 'apt-get install nginx'

        # create sites-available and sites-enabled
        notify 'creating sites-available and sites-enabled'
        run "mkdir -p #{fetch :nginx_sites_available_path, '/var/nginx/sites-available'}"
        run "mkdir -p #{fetch :nginx_sites_enable_path, '/var/nginx/sites-enabled'}"
      end
    end
  end
end
