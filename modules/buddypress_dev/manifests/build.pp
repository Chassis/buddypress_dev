# Class to install dependencies and build WordPress into `/src` and `/build`.
class buddypress_dev::build {
	exec { 'upgrade npm':
		command => '/usr/bin/npm install -g npm',
		user    => 'root',
		require => Class['npm'],
	}

	exec { 'npm install':
		command => '/usr/bin/npm install',
		cwd     => '/vagrant/buddypress-develop',
		user    => 'vagrant',
		require => [
			Exec['upgrade npm'],
			Class['buddypress_dev::repository'],
		],
		creates => '/vagrant/buddypress-develop/node_modules',
	}

	# Run grunt to build the project.
	exec { 'grunt build':
		command => '/usr/bin/grunt build',
		cwd     => '/vagrant/buddypress-develop',
		user    => 'vagrant',
		require => [
			Class['grunt'],
			Exec['npm install'],
			Class['buddypress_dev::repository'],
		],
		creates => '/vagrant/buddypress-develop/src/wp-includes/js',
	}
}
