sos
===
Service for OpenStack, a services and logs facilitator for Red Hat Enterprise"  


Requirements
------------
* RHEL 6.x  

* Rubygems  
  * On RHEL6.x, install rubygems rpm, available from RHEL Server Optional (v. 6 64-bit x86_64) channel: `$ yum install rubygems`  


Install
-------
**From Internet**  
`$ gem install sos`  

or  

**Manually**  
1. Download the latest version from https://rubygems.org/gems/sos  
2. Install the gem manually  
   `$ gem install sos-0.2.6.gem`  


Quickstart
----------
Run sos from the command line to get help  
`$ sos`  


Demo
----
* All installed openstack and neutron services are used.  
  But only enabled ones (chkconfig on) are treated.  
 `$ sos list  
  neutron-openvswitch-agent`  
 `neutron-ovs-cleanup`  
 `openstack-ceilometer-compute`  
 `openstack-nova-api`  
 `openstack-nova-compute`  

* status, start, stop, restart commands can be used  
 `$ sos status`  
 `neutron-openvswitch-agent (pid  2426) is running...`  
 `openstack-ceilometer-compute (pid  2434) is running...`  
 `openstack-nova-api (pid  2442) is running...`  
 `openstack-nova-compute (pid  4197) is running...`  

* Services can be filtered  
 `$ sos status nova`   
 `openstack-nova-api (pid  2442) is running...`  
 `openstack-nova-compute (pid  4197) is running...`  
  
* logs will exec tail -f to services corresponding log files  
  using same filtering principle  
  `$ sos logs agent`  
  `==> /var/log//neutron/dhcp-agent.log <==`
  `2013-12-04 23:51:19.795 28273 INFO neutron.openstack.common.rpc.impl_qpid [-] Connected to AMQP server on 192.168.0.222:5672`  
  
  `==> /var/log//neutron/l3-agent.log <==`  
  `2013-12-04 23:51:19.795 28273 INFO neutron.openstack.common.rpc.impl_qpid [-] Connected to AMQP server on 192.168.0.222:5672`  
  
  `==> /var/log//neutron/metadata-agent.log <==`  
  `2013-12-03 23:59:33.002 28293 INFO neutron.common.config [-] Logging enabled!`  
  
  `==> /var/log//neutron/openvswitch-agent.log <==`  
  `2013-12-05 00:08:24.410 28239 INFO neutron.agent.securitygroups_rpc [-] Security group member updated [u'7039eb2a-d2bc-4703-9639-e704bf4a0d0d']`  
  

* Above examples are on a Neutron network node  
  Logs have been truncated  

Uninstall
---------
`$ gem uninstall sos`  


Sources
-------
https://github.com/gildub/sos  


Licence
-------
GNU GPLV3 - See COPYING file  


Contributors
------------
Gilles Dubreuil - gilles@redhat.com  


