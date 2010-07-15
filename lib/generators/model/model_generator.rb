require 'rubygems'
require 'active_record'

class ModelGenerator < NewPlugin
  attr_reader :name,:class_name,:file_name,:class_path,:table_name,:attributes

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path('.')
    @name             = args.shift
		@attributes				= []

		args.map do |x|
			@attributes << {:type => x.split(/:/)[1],:name => x.split(/:/)[0]}
		end

    @file_name  = @name.singularize.underscore
    @class_name = @name.singularize.classify
    @class_path = File.dirname(file_name)
		@table_name = @name.pluralize.underscore.gsub(/\//, '_').pluralize
  end

  def manifest
    record do |m|
      m.directory File.join("test/app_root/app/models",class_path)

      m.template 'model.rb',File.join("test/app_root", 'app/models',"#{file_name}.rb")
      # Migration
      m.migration_template 'migration.rb', "test/app_root/db/migrate", :assigns => {
        :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
      }, :migration_file_name => "create_#{@table_name}"
    end
  end

  protected
    def banner
      <<-EOS
USAGE: #{File.basename($0)} #{spec.name} ModelName [field:type, field:type]

EOS
    end
end
