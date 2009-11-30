class AppGenerator < RubiGen::Base

  attr_reader :name,:plural_name,:singular_name,:class_name,:file_name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    @plural_name   = @name.pluralize.underscore
    @singular_name = @name.singularize.underscore

    @file_name     = @name.singularize.underscore
    @class_name    = @name.singularize.classify
  end

  def manifest
    record do |m|
      %w(
        lib tasks test test/app_root test/unit test/app_root/app/controllers
      ).each do |path|
        m.directory path
      end

      m.template_copy_each %w(MIT-LICENSE README Rakefile init.rb install.rb uninstall.rb test/test_helper.rb test/app_root/app/controllers/application_controller.rb)
      m.template "lib/module.rb","lib/#{file_name}.rb"
      m.template "tasks/tasks.rake","tasks/#{file_name}_tasks.rake"
    end
  end

  protected
    def banner
      <<-EOS
Creates a new plugin

USAGE: #{spec.name} name
EOS
    end
end
