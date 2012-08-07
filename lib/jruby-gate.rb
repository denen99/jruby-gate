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
require 'jruby-gate/jrgate'


class JrubyGate
 
 import "java.util"
 import "java.net"

 include Logger
 include Config
 include XMLParse


   attr_accessor :debug, :pluginsHome, :corpus, :resources
   attr_accessor :controller, :controllerObject, :corpusObject, :corpus

   def Gate
     JRGate::Gate
   end

   def Factory
     JRGate::Factory
   end
  
   def GateException
     JRGate::GateException
   end

   def initialize(*params)
     @debug = true
     @resources = Array.new
     @@logger = Logger.
     log_msg("About to initialize Gate") 
     startup_gate
     @entity_types =  ["Person", "Location","Organization", "Date",\
         "Money", "Temperature", "Length", "Area",\
         "Volume", "Weight", "Speed", "urlAddress"]
     log_msg("Initialize complete")
   end

   
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
     log_msg("Creating new corpus")
     @corpusObject = JrubyGate::GateCorpus.new
     self.corpus = @corpusObject.corpus
     log_msg("Corpus creation complete")
     @corpusObject
   end

   def entity_types
     self.entity_types
   end

   def entity_types=(e)
     raise("Entity types parameter must be an array!") unless e.is_a?(Array)
     self.entity_types = e
   end

   def create_controller(controller_name="JrubyGateController")
     log_msg("Creating new controller --> " + controller_name)
     @controllerObject = JrubyGate::GateController.new(controller_name)
     self.controller = @controllerObject.controller
     log_msg("Controller creation complete")
     @controllerObject
   end

   def add_resource(name)
     log_msg("Adding new resource " + name )
     ### NEED TO SUPPORT FEATUREMAP OPTIONS !!
     @controller.add(self.Factory.createResource(name,self.Factory.newFeatureMap))
     @resources.push(name)
     log_msg("Resource addition complete")
   end

   def get_annotations
     @corpus.document.getAnnotations.get.each { |ann|

     }
   end

   def execute
     raise("You can not execute without setting a corpus first or adding at least 1 document !!") unless @corpus || @corpus.isEmpty
     #@controller.setCorpus(@corpus)
     @controller.execute
   end

end

require 'jruby-gate/controller'
require 'jruby-gate/corpus'


