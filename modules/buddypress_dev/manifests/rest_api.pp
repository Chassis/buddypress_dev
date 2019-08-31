# A class to clone the BuddyPress REST API plugin repository.
class buddypress_dev::rest_api (
	$config
) {
	vcsrepo { '/vagrant/content/plugins/bp-rest':
		ensure   => present,
		provider => git,
		remote   => 'origin',
		source   => 'https://github.com/buddypress/BP-REST.git',
		user     => 'vagrant',
	}
	wp::plugin { 'buddypress':
		ensure   => 'activate',
		location => '/vagrant/wp',
		require  => [ Class['Wp'], Class['buddypress_dev::repository'] ],
	}

	wp::plugin { 'bp-rest':
		ensure   => 'activate',
		location => '/vagrant/wp',
		require  => [ Class['Wp'] ],
	}

	wp::rewrite { '/%post_id%/%postname%/':
		structure => '/%post_id%/%postname%/',
		location  => '/vagrant/wp',
		require   => [ Class['Wp'] ],
	}
}
