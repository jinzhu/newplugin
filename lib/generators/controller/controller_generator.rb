class ControllerGenerator < RubiGen::Base

  attr_reader :name,:class_name,:file_name,:actions

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path('.')
    @name             = args.shift
    @actions          = args

    @file_name  = @name.underscore
    @class_name = @name.pluralize == @name ? @name.classify.pluralize : @name.classify
  end

  def manifest
    record do |m|
      m.directory File.dirname("test/app_root/app/controllers/#{file_name}")
      m.template "controller.rb","test/app_root/app/controllers/#{file_name}_controller.rb"
    end
  end

  protected
    def banner
      <<-EOS
USAGE: #{File.basename($0)} #{spec.name} ControllerName [action] [action] [options]

EOS
    end
end
