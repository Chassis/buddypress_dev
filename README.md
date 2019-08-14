## 🚨🚨🚨 This is a Work In Progress! 🚨🚨🚨

# BuddyPress Core Development Extension for Chassis

This extension configures a [Chassis](http://chassis.io) virtual machine for BuddyPress core development.

## Quick Start

Clone Chassis into the directory of your choice with this command:

```bash
# You may change buddypress-dev to the folder name of your choice.
git clone --recursive https://github.com/Chassis/Chassis buddypress-dev
```

Next, create an empty `config.local.yaml` file in the root of the Chassis checkout, and paste in these options:

```yaml
# Specify the .local hostname of your choice.
hosts:
  -  buddypress.local

# Instruct Chassis to use this extension.
extensions:
  - buddypress_dev

# Set a PHPUnit version.
phpunit:
  version: 7.5

composer:
  paths:
    # Run composer install
    - /vagrant/buddypress-develop
  options: --prefer-source
```
(Other [Chassis configuration options](http://docs.chassis.io/en/latest/config/) may be used as normal, so long as the above paths are provided correctly.)

After creating this file, run `vagrant up` to initialize the virtual machine.

Once provisioned, your new BuddyPress development site will be available at [buddypress.local](http://buddypress.local), and you may login at [buddypress.local/wp](http://buddypress.local/wp) with the username `admin` and password `password`. The site will be using the `/src` build of the `buddypress-develop` repository, newly cloned on your host system at `[Chassis root]/buddypress-develop` and available as `/vagrant/buddypress-develop` inside the virtual machine.

To switch the site to use the **`build`** version of the site instead, edit the `wp:` line in your `config.local.yaml` to end in "build" instead of "src" then run `vagrant provision`.

### A Note on the BuddyPress Build Process

**PLEASE NOTE:** The provisioner will run `npm install` and `grunt` for you after cloning the repository, so you can get started right away. However, subsequent `npm` or `grunt` commands are left to you, the developer. If you have made changes to the code and are using the `/src` directory, run `grunt build --dev` to rebuild the project into the `/src` directory if you do not see your changes. If you are using `/build`, run `grunt` or `grunt build`. See the [WordPress core contributor handbook](https://make.wordpress.org/core/handbook/) for more information on building & developing WordPress.

(Commands may be run either within the Chassis VM — _e.g._ `vagrant ssh -c 'cd /vagrant/buddypress-develop && grunt build --dev` — or else you may run `npm install` within your host operating system and run the builds with `grunt` locally on your machine. Builds may be faster on the host system than within the VM, but using the VM's versions of Node and Grunt means you need less tooling installed outside Chassis.)

## Running the Unit Tests

From the host machine, use `vagrant ssh` to run the unit tests inside the virtual machine:

```bash
vagrant ssh -c 'cd /vagrant/buddypress-develop && phpunit'
```

To run a particular suite of tests, for example just the tests defined within the `WP_Test_REST_Posts_Controller` class, provide that class name with `--filter`:

```bash
vagrant ssh -c 'cd /vagrant/buddypress-develop && phpunit --filter WP_Test_REST_Posts_Controller'
```

The best version of PHPUnit to install depends on the version of PHP you are using:

* PHP 5.6: PHPUnit 4.8
* PHP 7.0: PHPUnit 6.5
* PHP 7.1+: PHPUnit 7.5


## Extension Options

Define a `buddypress_dev` key in your `config.local.yaml` to configure this extension.

```yml
# config.local.yaml

buddypress_dev:
    # If the buddypress-develop repo is not already checked out within the
    # Chassis root directory, this extension will clone a fresh copy for
    # you. To add a "mirror" remote pointing to your own fork of the develop
    # repo, specify your fork's address in the `mirror` option.
    mirror: git@github.com:{your GitHub name}/buddypress-develop.git
```
