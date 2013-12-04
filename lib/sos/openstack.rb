module OpenStack
  VarLog = '/var/log/'

  LOGS = {
   'neutron-dhcp-agent'             => ["#{VarLog}/neutron/dhcp-agent.log"],
   'neutron-l3-agent'               => ["#{VarLog}/neutron/l3-agent.log"],
   'neutron-lbaas-agent'            => ["#{VarLog}/neutron/lbaas-agent"],
   'neutron-metadata-agent'         => ["#{VarLog}/neutron/metadata-agent"],
   'neutron-openvswitch-agent'      => ["#{VarLog}/neutron/openvswitch-agent"],
   'neutron-ovs-cleanup'            => [""],
   'neutron-server'                 => ["#{VarLog}/neutron/server.log"],
   'openstack-ceilometer-api'       => ["#{VarLog}/ceilometer/api.log"],
   'openstack-ceilometer-central'   => ["#{VarLog}/ceilometer/central.log"],
   'openstack-ceilometer-collector' => ["#{VarLog}/ceilometer/collector.log"],
   'openstack-ceilometer-compute'   => ["#{VarLog}/ceilometer/compute.log"],
   'openstack-cinder-api'           => ["#{VarLog}/cinder/api.log"],
   'openstack-cinder-scheduler'     => ["#{VarLog}/cinder/api.log"],
   'openstack-cinder-volume'        => ["#{VarLog}/cinder/api.log"],
   'openstack-glance-api'           => ["#{VarLog}/glance/api.log"],
   'openstack-glance-registry'      => ["#{VarLog}/glance/registry.log"],
   'openstack-heat-api'             => ["#{VarLog}/heat/heat-api.log"],
   'openstack-heat-engine'          => ["#{VarLog}/heat/heat-engine.log"],
   'openstack-heat-manage'          => ["#{VarLog}/heat/heat-manage.log"],
   'openstack-keystone'             => ["#{VarLog}/keystone/keystone.log"],
   'openstack-nova-api'             => ["#{VarLog}/nova/api.log"],
   'openstack-nova-cert'            => ["#{VarLog}/nova/cert.log"],
   'openstack-nova-compute'         => ["#{VarLog}/nova/compute.log"],
   'openstack-nova-conductor'       => ["#{VarLog}/nova/conductor.log"],
   'openstack-nova-console'         => ["#{VarLog}/nova/console.log"],
   'openstack-nova-consoleauth'     => ["#{VarLog}/nova/consoleauth.log"],
   'openstack-nova-metadata-api'    => ["#{VarLog}/nova/metadata-api.log"],
   'openstack-nova-novncproxy'      => [""],
   'openstack-nova-scheduler'       => ["#{VarLog}/nova/scheduler.log"],
 }
end
