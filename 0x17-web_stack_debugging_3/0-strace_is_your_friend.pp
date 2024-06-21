# This Puppet manifest ensures the wp-settings.php file exists, contains default content if it doesn't, and has correct permissions to fix the Apache 500 error.

file { '/var/www/html/wp-settings.php':
  ensure  => file,
  content => "This is a placeholder for wp-settings.php.\n", # Replace with actual default content as necessary
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

exec { 'fix-wordpress':
  command => 'sed -i \'s/phpp/php/g\' /var/www/html/wp-settings.php',
  path    => ['/usr/local/bin', '/bin', '/usr/bin'],
  onlyif  => 'grep -q phpp /var/www/html/wp-settings.php',
  require => File['/var/www/html/wp-settings.php'],
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => File['/var/www/html/wp-settings.php'],
}

