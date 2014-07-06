name              'astaroth'
maintainer        'bathtimefish'
maintainer_email  'muraoka@bathtimefish.com'
license           'Apache 2.0'
description       'Configuration files which makes astaroth server.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '4.0.2'
recipe            'astaroth', 'setting astaroth server'

%w{ amazon ubuntu }.each do |os|
  supports os
end

# supports 'mac_os_x', '>= 10.6.0'

%w{ git }.each do |cookbook|
  depends cookbook
end

