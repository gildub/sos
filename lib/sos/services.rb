class Service
  attr_reader :name, :state, :logs

  def initialize(name, state, logs)
    @name      = name
    @state = state =~ /on|enabled/i ? true : false
    @logs = logs
  end

  def has?(filter)
    @name =~ /#{filter}/ ? true : false
  end

  def to_s
    @name + ':' + @state
  end
end

class Services
  def self.build_list(selectors, run_level, filters)
    # Returns each service on a line with
    # name:state

    selector = selectors.split(',').join('|')

    list=''
    os = %x{facter | grep -e operatingsystem}
    case os
    when /RedHat/
      majrelease = %x{facter | grep -e operatingsystemmajrelease}
      if majrelease =~ /6/
        list = %x{ chkconfig --list | awk '/#{selector}/ {print $1":"$#{run_level+2}}'}
        list.gsub!(/:\d:/,':')
      end
    when /Fedora/
      list = %x{ systemctl list-unit-files | awk '#{selector} {print}'}
      list.gsub!(/\.service[\s]*/,':')
    end

    if filters != []
      filtered = ''
      list.each_line { |line|
        filters.each { |filter| filtered << line if line =~ /#{filter}/ }
      }
      list = filtered
    end
    list
  end

  def initialize(service_list, services_logs)
    @services = []
    service_list.each_line  { |line|
      name, state = line.chop.split(':')
      log = services_logs[name] ? services_logs[name] : ''
      @services << Service.new(name, state, log)
    }
  end

  def get_by_name(filters)
    return @services
    list = []
    filters.each { |filter|
      @services.each { |service|
        list << service if @service.has?(filter)
      }
    }
    list
  end

  def enabled
    list = []
    @services.each { |service|
      list << service if service.state
    }
    list
  end
end
