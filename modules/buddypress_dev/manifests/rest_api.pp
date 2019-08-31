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
}
