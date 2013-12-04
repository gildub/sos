class Service
  attr_reader :name, :state, :logs

  def initialize(name, state, logs)
    @name      = name
     if state =~ /on/i
      @state = true
    else
      @state = false
    end
    @logs = logs
  end

  def has?(filter)
    true if @name =~ /#{filter}/
  end

  def to_s
    @name + ':' + @state
  end
end

class Services
  def initialize(filter, run_level, logs)
    @services = []

    list = %x{chkconfig --list | awk '#{filter} {print $1":"$#{run_level+2}}'}
    list.each  { |line|
      line_tab = line.chop.split(':')
      name = line_tab[0]
      state = line_tab[2]
      @services << Service.new(name, state, logs[name])
    }
  end

  def get_by_name(filters)
    list = []
    filters.each { |filter|
      @services.each { |service|
        list << service.name if @service.has?(filter)
      }
    }
    list
  end

  def get_by_name_all
    list = []
    @services.each { |service|
      list << service.name
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
