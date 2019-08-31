# Class to prepare the Chassis box for BuddyPress core development.
class buddypress_dev (
	$config
) {
	class { 'buddypress_dev::repository':
		config => $config,
	}

	class { 'buddypress_dev::config':
		require => Class['buddypress_dev::repository'],
	}

	class { 'buddypress_dev::tests':
		database          => "${ config[database][name] }_tests",
		database_user     => $config[database][user],
		database_password => $config[database][password],
		database_host     => 'localhost',
		database_prefix   => 'bptests_',
		require           => Class['buddypress_dev::repository'],
	}
}
