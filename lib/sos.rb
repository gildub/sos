=begin header
   * Name: os
   * Description: OpenStack services and logs tool for Red Hat OSes familly
   * URL: https://github.com/gildub/os
   * Date: 29 Nov 2013
   * Author: Gilles Dubreuil <gilles@redhat.com>
   * License: Copyright 2011, 2013 Gilles Dubreuil
=end

=begin rdoc
=end

require 'sos/services'
require 'sos/openstack'

SYNTAX =
  %s{Usage:
  os [-fr] list
  os [-fr] logs    [<SERVICE>] ... [<SERVICE>]
  os [-fr] restart [<SERVICE>] ... [<SERVICE>]
  os [-fr] start   [<SERVICE>] ... [<SERVICE>]
  os [-fr] satus   [<SERVICE>] ... [<SERVICE>]
  os [-fr] stop    [<SERVICE>] ... [<SERVICE>]
  os help

Options:
  -r, --runlevel <RUNLEVEL>  Change run-level. Default is level 3.
  -h, --help     This help

Commands:
  list      List available OpenStack services
  logs      Runs "tail -f"
  restart   Runs "service restart"
  start     Runs "service start"
  status    Runs "service status"
  stop      Runs "service stop"

<SERVICE>   Openstack service
}

class Syntax
  def initialize(line)
    @command   = ""
    @options   = {
      :runlevel => 3,
      :filter   => '/neutron|openstack/',
      :all      => false }
    @arguments = []

    until line.empty?
      case line[0]
      when '-a', '--all'
        @options[:all] = true
      when '-f', '--filter'
        line.shift
        @options[:filter] = line[0]
      when '-r', '--run_level'
        line.shift
        @options[:runlevel] = line[0].to_i
      when /status/i, /start/i, /stop/i, /restart/i, /logs/i, /list/i, 'test'
        @command << line[0]
        line.shift
        @arguments = line
        break
      else
        self.usage
      end
      line.shift
    end
  end

  def run
    @services = Services.new(@options[:filter], @options[:runlevel], OpenStack::LOGS)

    case @command
    when /status/i, /start/i, /stop/i, /restart/i
      @services.enabled.each do |service|
        system("service #{service.name} #{@command}")
      end
    when /logs/i
      logs = ''
      @services.enabled.each do |service|
        logs << service.logs.join(' ') + ' '
      end
      exec("tail -f #{logs}") if logs
    when /list/i
      @services.enabled.each do |service|
        puts service.name
      end
    when 'test'
      p self
    end
  end

  def usage
    puts SYNTAX
    exit
  end
end
