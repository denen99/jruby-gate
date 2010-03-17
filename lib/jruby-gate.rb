require 'java'
require 'rubygems'
require 'hpricot'


#***************************
# Load the Jars
#***************************
ENV['GATE_HOME'] = '/Users/adamd/dev/gatehome'
ENV['GATE_HOME'] ? '' : raise("You must set GATE_HOME before continuing")

Dir[ENV['GATE_HOME'] + "/lib/*.jar"].each { |jar| 
   require  jar 
} 
require ENV['GATE_HOME'] + '/bin/gate.jar'


#***************************
#Grab the modules 
#***************************
require 'jruby-gate/config'
require 'jruby-gate/xmlparse'
require 'jruby-gate/log'
require 'jruby-gate/javaio'

 module JRGate
  include_package "gate"
  include_package "gate.creole"
  include_package "gate.util"
 end


class JrubyGate
 
 import "java.util"
 import "java.net"

 include Logger
 include Config
 include XMLParse


   attr_accessor :debug, :pluginsHome, :corpus, :resources, :controller

   def Gate
     JRGate::Gate
   end

   def Factory
     JRGate::Factory
   end

   def initialize(*params)
     @debug = true
     @resources = Array.new
     log_msg("About to initialize Gate") 
     startup_gate
     log_msg("Initialize complete")
   end

   #def controller
     #JrubyGate::GateController.controller
   #  @controller.controller
   #end

   
   def startup_gate
     log_msg("Calling Gate.init")
     self.Gate.init
     @gateHome = self.Gate.gateHome
     @pluginsHome = JavaIO::File.new(@gateHome,"plugins")
     log_msg("Gate.init complete")
   end

   def add_plugin_dirs(*dirs)
     dirs.each { |d| 
       log_msg("Adding new plugin " + d) 
       self.Gate.creoleRegister.registerDirectories(JavaIO::File.new(@pluginsHome,d).toURL)
     }
   end

   def create_corpus
     self.corpus = JrubyGate::GateCorpus.new
   end

   def create_controller(controller_name="JrubyGateController")
     self.controller = JrubyGate::GateController.new(controller_name)
   end

   def add_resource(name)
     ### NEED TO SUPPORT FEATUREMAP OPTIONS !!
     self.controller.add(self.Factory.createResource(name,self.Factory.newFeatureMap))
     @resources.push(name)
   end


   def add_document(d)
     @document = Factory.newDocument(d)
     @corpus.add(@document)
   end

   def execute
     raise("You can not execute without setting a corpus first or adding at least 1 document !!") unless @corpus || @corpus.isEmpty
     @controller.setCorpus(@corpus)
     @controller.execute
   end

end

require 'jruby-gate/controller'
require 'jruby-gate/corpus'


