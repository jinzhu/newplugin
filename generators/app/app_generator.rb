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
      %w(lib tasks test test/app_root test/unit).each { |path| m.directory path }
      m.template_copy_each %w(MIT-LICENSE README Rakefile init.rb install.rb uninstall.rb)
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
