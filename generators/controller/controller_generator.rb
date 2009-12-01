class ControllerGenerator < RubiGen::Base

  attr_reader :name,:class_name,:file_name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path('.')
    @name = args.shift

    @file_name     = @name.pluralize.underscore
    @class_name    = @name.singularize.classify
  end

  def manifest
    record do |m|
      m.directory "test/app_root/app/controllers"
      m.template "controller.rb","test/app_root/app/controllers/#{file_name}_controller.rb"
    end
  end
end
