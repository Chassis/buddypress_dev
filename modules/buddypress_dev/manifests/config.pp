# Add a symlink so we can use the plugin
class buddypress_dev::config {
	file { '/vagrant/buddypress-develop/src/':
		ensure  => 'link',
		target  => '/vagrant/content/plugins/buddypress',
		require => Class['buddypress_dev::repository'],
	}

}
