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
  def self.build_service_list(selector, run_level, filters)
    list=''
    os = %x{facter | grep -e operatingsystem}
    case os
    when /RedHat/
      majrelease = %x{facter | grep -e operatingsystemmajrelease}
      if majrelease =~ /6/
        list = %x{ chkconfig --list | awk '#{selector} {print $1":"$#{run_level+2}}'}
      end
    when /Fedora/
      list = %x{ systemctl list-unit-files | awk '#{selector} {print $1}'}
      list.gsub!(/\.service[\s]*/,':')
    end

    if filters != []
      filtered = ''
      list.each { |line|
        filters.each { |filter| filtered << line if line =~ /#{filter}/ }
      }
      list = filtered
    end
    list
  end

  def initialize(selector, run_level, filters, loglist)
    @services = []

    list = Services.build_service_list(selector, run_level, filters)

    list.each  { |line|
      line_tab = line.chop.split(':')
      name = line_tab[0]
      state = line_tab[2]
      log = loglist[name] ? loglist[name] : ''
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
