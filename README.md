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
  - tester

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

## Running the Unit Tests

From the host machine, use `vagrant ssh` to run the unit tests inside the virtual machine:

```bash
vagrant ssh -c 'cd /vagrant/buddypress-develop && phpunit'
```

To run a particular suite of tests, for example just the tests defined within the `WP_Test_REST_Posts_Controller` class, provide that class name with `--filter`:

```bash
vagrant ssh -c 'cd /vagrant/buddypress-develop && phpunit --filter BP_Tests_Activity_Class'
```

The best version of PHPUnit to install depends on the version of PHP you are using:

* PHP 5.6: PHPUnit 4.8
* PHP 7.0: PHPUnit 6.5
* PHP 7.1+: PHPUnit 7.5

