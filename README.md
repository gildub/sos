sos
===
Service for OpenStack, a services and logs facilitator for Red Hat Enterprise"  


Requirements
------------
* RHEL 6.x  
* Fedora 19+

* Rubygems RPM  
  `$ yum install rubygems`  
  * On RHEL, it's available from RHEL Server Optional (v. 6 64-bit x86_64) channel  
  

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
  
* logs runs `exec tail -f` to corresponding log files  
  using same filtering principle  
  `$ sos logs dhcp l3`  
  `==> /var/log//neutron/dhcp-agent.log <==`
  `2013-12-04 23:51:19.795 28273 INFO neutron.openstack.common.rpc.impl_qpid [-] Connected to AMQP server on 192.168.0.222:5672`  
  
  `==> /var/log//neutron/l3-agent.log <==`  
  `2013-12-04 23:51:19.795 28273 INFO neutron.openstack.common.rpc.impl_qpid [-] Connected to AMQP server on 192.168.0.222:5672`  
  

* Above examples are from a Neutron network node  
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


