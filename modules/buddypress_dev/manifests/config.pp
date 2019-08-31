# Add a symlink so we can use the plugin
class buddypress_dev::config {
	file { '/vagrant/content/plugins/buddypress':
		ensure  => 'link',
		target  => '/vagrant/buddypress-develop/src/',
		require => [ Class['buddypress_dev::repository'], File['/vagrant/content/plugins'] ],
		force   => true,
	}

	file { '/vagrant/content/plugins':
		ensure => 'directory',
	}
}
