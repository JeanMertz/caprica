# nginx

Install and manage your nginx server.

## nginx:install - install nginx on remote server

configuration variables:

```
nginx_install_role            # default: web
nginx_sites_available_path    # default: /var/nginx/sites-available
nginx_sites_enable_path       # default: /var/nginx/sites-enabled
```

## nginx:reload - reload nginx configuration

The `nginx:reload` command reloads the nginx configuration without
actually restarting the server. This allows active sites to continue
functioning correctly, while you can start and stop specific sites using
`nginx:sites:enable` and `nginx:sites:disable`.

Note that this command is automatically run after the above two tasks.

configuration variables:

```
nginx_reload_role             # default: web
```


## nginx:config - upload global configuration file

configuration variables:

```
nginx_config_role             # default: web
nginx_config_source           # default: asks for path/url
nginx_config_path             # default: /etc/nginx/nginx.conf
```

## nginx:sites:available - upload site configuration file

configuration variables:

```
nginx_sites_available_role    # default: web
nginx_sites_available_source  # default: asks for path/url
```

## nginx:sites:enable - enable site configuration file

configuration variables:

```
nginx_sites_enable_role       # default: web
nginx_sites_enable_source     # default: asks for path/url
```

## nginx:sites:disable - disable site configuration file

configuration variables:

```
nginx_sites_disable_role       # default: web
```
