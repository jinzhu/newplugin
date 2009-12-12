require 'rubygems'
require 'active_record'

class ScaffoldGenerator < RubiGen::Base

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
