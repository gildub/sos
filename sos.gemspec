Gem::Specification.new do |s|
  s.name        = 'sos'
  s.version     = '0.6.3'
  s.date        = '2013-12-09'
  s.summary     = "Service for OpenStack, is a facilitator for OpenStack services and logs on Red Hat OSes"
  s.description = "Helps with OpenStack services and their corresponding log files for a specific host. Allows services filtering"
  s.authors     = ["Gilles Dubreuil"]
  s.email       = ['gilles@redhat.com']
  s.files       = ['lib/sos.rb', 'lib/sos/services.rb', 'lib/sos/openstack.rb']
  s.homepage    = 'https://github.com/gildub/sos'
  s.license     = 'GNU GPLv3'
  s.executables << 'sos'
end
