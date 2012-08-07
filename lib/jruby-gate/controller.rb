class JrubyGate

  class GateController < JrubyGate

    #attr_accessor :controller

   def initialize(name)
     @controller = self.Factory.createResource("gate.creole.SerialAnalyserController",\
         self.Factory.newFeatureMap,self.Factory.newFeatureMap,name)
   end

   def add_resource(name)
     log_msg("Adding resource " + name )
     @controller.add(self.Factory.createResource(name,\
           self.Factory.newFeatureMap))
   end

   def set_corpus(c)
     log_msg("Setting corpus")
     @controller.setCorpus(c)
   end

   def clear_corpus(c)
     log_msg("Clearing out the corpus")
     c.clear
   end

   def execute
    begin
     @controller.execute
    rescue => e 
    end
   end
   
   
  end

end
