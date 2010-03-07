require 'thor/group'

module NewPlugin
  class AppGenerator < Thor::Group
    include Thor::Actions

    def self.source_root
      @_source_root ||= File.expand_path("../templates", __FILE__)
    end

    def self.destination_root
      @_destination_root ||= File.expand_path(".")
    end

    def copy_files
      directory ".", "docs"
    end

    attr_reader :name,:plural_name,:singular_name,:class_name,:file_name

    def initialize(runtime_args, runtime_options = {})
      super
      usage if args.empty?
      @destination_root = File.expand_path(args.shift)
      @name             = base_name
      @plural_name      = @name.pluralize.underscore
      @singular_name    = @name.singularize.underscore

      @file_name        = @name.singularize.underscore
      @class_name       = @name.singularize.classify
    end

    def manifest
      record do |m|
        %w(
        lib tasks test test/app_root test/unit test/app_root/app/controllers
        test/app_root/config/environments test/app_root/config/initializers
        ).each do |path|
          m.directory path
        end

        m.template_copy_each %w(MIT-LICENSE README Rakefile init.rb install.rb uninstall.rb test/test_helper.rb test/app_root/app/controllers/application_controller.rb test/app_root/app/controllers/application.rb)
        m.template "lib/module.rb","lib/#{file_name}.rb"
        m.template "tasks/tasks.rake","tasks/#{file_name}_tasks.rake"

        m.file_copy_each %w(
        test/app_root/config/boot.rb
        test/app_root/config/database.yml
        test/app_root/config/environment.rb
        test/app_root/config/environments/in_memory.rb
        test/app_root/config/environments/mysql.rb
        test/app_root/config/environments/postgresql.rb
        test/app_root/config/environments/sqlite.rb
        test/app_root/config/environments/sqlite3.rb
        test/app_root/config/initializers/plugin.rb
        test/app_root/config/routes.rb
        )
      end
    end

    protected
    def banner
      <<-EOS
USAGE: #{File.basename($0)} #{spec.name} PluginName [options]

      EOS
    end
  end
end
