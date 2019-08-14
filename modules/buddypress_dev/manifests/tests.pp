include vcsrepo

# Set the WordPress database test constants.
class buddypress_dev::tests (
	$database = 'buddypress_tests',
	$database_user = 'wordpress',
	$database_password = 'vagrantpassword',
	$database_host = 'localhost',
	$database_prefix = 'bptests_',

	$tests_domain = 'example.org',
	$tests_email = 'admin@example.org',
	$tests_title = 'Test Blog',
) {
	mysql::db { $database:
		user     => $database_user,
		password => $database_password,
		host     => $database_host,
		grant    => ['all'],
	}

	file { '/vagrant/buddypress-develop/wp-tests-config.php':
		content => template('buddypress_dev/wp-tests-config.php.erb'),
		require => Class['buddypress_dev::repository'],
	}
}
