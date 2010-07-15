class ScaffoldGenerator < NewPlugin
  def self.source_root
    @_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.destination_root
    @_destination_root ||= File.expand_path(".")
  end

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    RubiGen::Scripts::Generate.new.run(args.clone, :generator => 'model')
    RubiGen::Scripts::Generate.new.run(args[0].pluralize.to_a, :generator => 'controller')
  end

  def manifest
    record do |m|
    end
  end

  protected
    def banner
      <<-EOS
USAGE: #{File.basename($0)} #{spec.name} ModelName [field:type, field:type]

EOS
    end
end
