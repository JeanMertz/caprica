# Caprica

Extend your Capistrano tasks with frakkin' awesomeness.

There are currently three known models on Caprica. They each have their
own functionality.

## Models

### One

'One' extends the core tasks that come with Capistrano, and adds
notifications while running `Cap`.

It changes this

```bash
 $ be cap deploy:check

    triggering load callbacks
  * 2013-01-09 13:37:01 executing `staging'
    triggering start callbacks for `deploy:check'
  * 2013-01-09 13:37:02 executing `multistage:ensure'
  * 2013-01-09 13:37:03 executing `deploy:check'
  * executing "test -d /var/www/caprica/releases"
    servers: ["127.0.0.1"]
    [root@127.0.0.1] executing command
    command finished in 90ms
  * executing "test -w /var/www/caprica"
    servers: ["127.0.0.1"]
    [root@127.0.0.1] executing command
    command finished in 74ms
  * executing "test -w /var/www/caprica/releases"
    servers: ["127.0.0.1"]
    [root@127.0.0.1] executing command
    command finished in 68ms
  * executing "which git"
    servers: ["127.0.0.1"]
    [root@127.0.0.1] executing command
    command finished in 74ms
  * executing "which rsync"
    servers: ["127.0.0.1"]
    [root@127.0.0.1] executing command
    command finished in 68ms
  * executing "test -w /var/www/caprica/shared"
    servers: ["127.0.0.1"]
    [root@127.0.0.1] executing command
    command finished in 74ms
The following dependencies failed. Please check them and try again:
--> `/var/www/caprica/releases' does not exist. Please run `cap deploy:setup'. (root@127.0.0.1)
--> You do not have permissions to write to `/var/www/caprica'. (root@127.0.0.1)
--> You do not have permissions to write to `/var/www/caprica/releases'. (root@127.0.0.1)
--> `/var/www/caprica/shared' is not writable (root@127.0.0.1)
```

into this:

```bash
 $ be cap deploy:check -vv

➞   Set the target stage to `staging'. .................. ✓
➞   [internal] Ensure that a stage has been selected. ... ✓
➞   Test deployment dependencies.
    executing "test -d /var/www/caprica/releases"
    executing "test -w /var/www/caprica"
    executing "test -w /var/www/caprica/releases"
    executing "which git"
    executing "which rsync"
➞   Test deployment dependencies. ....................... ✘ failed dependencies
➞   `/var/www/caprica/releases' does not exist. Please run `cap deploy:setup'. (root@127.0.0.1)
➞   You do not have permissions to write to `/var/www/caprica'. (root@127.0.0.1)
➞   You do not have permissions to write to `/var/www/caprica/releases'. (root@127.0.0.1)
➞   `/var/www/caprica/shared' is not writable (root@127.0.0.1)
```

or this:

```bash
$ cap nginx:install

➞   Set the target stage to `staging'. .... ✓
➞   Test deployment dependencies. ......... ⣾ executing "test -d /var/www/caprica/releases"
➞   Test deployment dependencies. ......... ⣽ executing "test -w /var/www/caprica"
➞   Test deployment dependencies. ......... ⣻ executing "test -w /var/www/caprica/releases"
➞   Test deployment dependencies. ......... ⣻ executing "which git"
➞   Test deployment dependencies. ......... ⢿ executing "which rsync"
➞   Test deployment dependencies. ......... ✘ failed dependencies
➞   `/var/www/graduation/releases' does not exist. Please run `cap deploy:setup'. (root@178.79.130.64)
➞   You do not have permissions to write to `/var/www/graduation'. (root@178.79.130.64)
➞   You do not have permissions to write to `/var/www/graduation/releases'. (root@178.79.130.64)
➞   `/var/www/graduation/shared' is not writable (root@178.79.130.64)
```

*The 'Install nginx' lines will actually replace previous line after each
step. resulting in a two line final output:*

```bash
➞   Set the target stage to `staging'. .... ✓
➞   Test deployment dependencies. ......... ✘ failed dependencies
➞   `/var/www/graduation/releases' does not exist. Please run `cap deploy:setup'. (root@178.79.130.64)
➞   You do not have permissions to write to `/var/www/graduation'. (root@178.79.130.64)
➞   You do not have permissions to write to `/var/www/graduation/releases'. (root@178.79.130.64)
➞   `/var/www/graduation/shared' is not writable (root@178.79.130.64)
```

### Three

'Three' adds custom tasks to your Capistrano files, these tasks take full
advantage of the styling provided by 'Six'.

Here is a list of the currently supported tasks:

```
nginx:setup
nginx:install
nginx:reload
nginx:config
nginx:sites:available
nginx:sites:enable
nginx:sites:disable
```

For all tasks and their descriptions, see the README in `lib/caprica/three`.

### Six

Prettify Capistrano output.

## Installation

Add this line to your application's Gemfile:

    gem 'caprica', group: :development

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install caprica

## Usage

Add this line to your Capfile:

    require 'capistrano/caprica'

If you want to specify which parts you want to load, you can do so:

    require 'capistrano/caprica/one'   # extends core Capistrano tasks with 'six'
    require 'capistrano/caprica/three' # add custom tasks which work with 'six'
    require 'capistrano/caprica/six'   # beatifies Capistrano output

While 'three' gives you a lot of custom tasks, you might want to narrow
down the ones that are loaded:

    require 'capistrano/caprica/three/nginx'
    require 'capistrano/caprica/three/postgresql'
    require 'capistrano/caprica/three/sidekiq'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012-2013 Jean Mertz

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
