require 'rubygems'
require 'active_record'

class MigrationGenerator < RubiGen::Base

  attr_reader :name,:class_name,:file_name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path('.')
    @name             = args.shift
    @file_name        = @name.pluralize.underscore
    @class_name       = @name.singularize.classify
  end

  def manifest
    record do |m|
      m.migration_template 'migration.rb', "test/app_root/db/migrate"
    end
  end
end
