Gem::Specification.new do |s|
  s.name        = 'sos'
  s.version     = '0.2.6'
  s.date        = '2013-12-04'
  s.summary     = "Service for OpenStack is a services and logs tool for Red Hat OS"
  s.description = "Easy manipulation of OpenStack services and view corresponding log files for a specific host. Allows grouping part or all services at once."
  s.authors     = ["Gilles Dubreuil"]
  s.email       = ['gilles@redhat.com']
  s.files       = ['lib/sos.rb', 'lib/sos/services.rb', 'lib/sos/openstack.rb']
  s.homepage    = 'https://github.com/gildub/sos'
  s.license     = 'GNU GPLv3'
  s.executables << 'sos'
end
