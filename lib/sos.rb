=begin rdoc
   * Name: sos
   * Description: OpenStack services and logs tool for Red Hat OSes familly
   * URL: https://github.com/gildub/sos
   * Date: 29 Nov 2013
   * Author: Gilles Dubreuil <gilles@redhat.com>
   * License: GNU GPLv3
=end

require 'sos/services'
require 'sos/openstack'

SYNTAX =
  %s{Usage:
  sos [-sr] list
  sos [-sr] logs    [<SERVICE>] ... [<SERVICE>]
  sos [-sr] restart [<SERVICE>] ... [<SERVICE>]
  sos [-sr] start   [<SERVICE>] ... [<SERVICE>]
  sos [-sr] satus   [<SERVICE>] ... [<SERVICE>]
  sos [-sr] stop    [<SERVICE>] ... [<SERVICE>]
  sos help

Options:
  -r, --runlevel <RUNLEVEL> 
    Change run-level. Default is level 3.
  -s, --selector <STRING>, ... ,<STRING>
    Assign selector. Default is "openstack,neutron".
  -h, --help
    This help

Commands:
  list      List available OpenStack services
  logs      Runs "tail -f"
  restart   Runs "service restart"
  start     Runs "service start"
  status    Runs "service status"
  stop      Runs "service stop"

<SERVICE>   Service name
}

class Syntax
  def initialize(line)
    @command   = nil
    @options   = {
      :runlevel => 3,
      :selector => 'openstack,neutron',
      :all      => false }
    @arguments = []

    until line.empty?
      case line[0]
      when '-a', '--all'
        @options[:all] = true
      when '-s', '--selector'
        line.shift
        @options[:selector] = line[0].gsub(/\s*/,'')
      when '-r', '--run_level'
        line.shift
        @options[:runlevel] = line[0].to_i
      when /status/i, /start/i, /stop/i, /restart/i, /logs/i, /list/i, 'test'
        @command = line[0]
        line.shift
        @arguments = line
        break
      else
        self.usage
      end
      line.shift
    end
    self.usage unless @command
  end

  def run

    services_list = Services.build_list(@options[:selector], @options[:runlevel], @arguments, OpenStack::LOGS)
    services = Services.new(services_list)

    case @command
    when /status/i, /start/i, /stop/i, /restart/i
      services.enabled.each { |service|
        system("service #{service.name} #{@command}")
      }
    when /logs/i
      logs = ''
      services.enabled.each { |service|
        logs << service.logs.join(' ') + ' '
      }
      exec("tail -f #{logs}") if logs
    when /list/i
      services.enabled.each { |service|
        puts service.name
      }
    when 'test'
      p self
    end
  end

  def usage
    puts SYNTAX
    exit
  end
end
