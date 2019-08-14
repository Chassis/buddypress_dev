include vcsrepo

# Class to prepare the Chassis box for BuddyPress core development.
class buddypress_dev::repository (
	$config
) {
	# Ensure SVN is installed.
	package { 'subversion':
		ensure => 'present',
	}

	# Ignore buddypress-develop folder within the parent Chassis checkout.
	if $::parent_repository_exclude_file == 'present' {
		file_line { 'ignore buddypress-develop directory':
			path => '/vagrant/.git/info/exclude',
			line => 'buddypress-develop',
		}
		file_line { 'ignore src/ symlink':
			path => '/vagrant/.git/info/exclude',
			line => 'src',
		}
		file_line { 'ignore build/ symlink':
			path => '/vagrant/.git/info/exclude',
			line => 'build',
		}
	}

	# vcsrepo task may fail unless GitHub is listed in known_hosts.
	exec { 'Add github to known_hosts':
		command => '/usr/bin/ssh-keyscan -t rsa github.com >> /home/vagrant/.ssh/known_hosts',
		unless  => '/bin/grep -Fq "github.com" /home/vagrant/.ssh/known_hosts',
	}

	# A repository may exist in the Chassis root, or a repository directory
	# elsewhere on the host system may be mapped into the buddypress-develop
	# directory using synced_folders. Once a repository is present, we cannot
	# make as many assumptions about how the user wishes to manage that repo;
	# They may be using SVN, or have defined their own remotes, etcetera.
	# We therefore only try to clone and setup a repository if there is not
	# already a checkout of any sort in `/vagrant/buddypress-develop`.
	unless $::buddypress_dev_repository == present {
		# Permit a develop repo mirror remote to be specified in config.local.yaml.
		if ( !empty($config['buddypress_dev']) and !empty($config['buddypress_dev']['mirror']) ) {
			$repository_remotes = {
				'origin' => 'git://develop.git.wordpress.org/',
				'mirror' => $config['buddypress_dev']['mirror']
			}
		} else {
			$repository_remotes = { 'origin' => 'https://github.com/buddypress/BuddyPress.git' }
		}

		vcsrepo { '/vagrant/buddypress-develop':
			ensure   => present,
			provider => git,
			remote   => 'origin',
			source   => $repository_remotes,
			user     => 'vagrant',
		}
	}
}
