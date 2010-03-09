class JrubyGate

  class Configuration

    ## Load up the necessary jars
    def initialize
     ENV['GATE_HOME'] ? '' : raise("You must set GATE_HOME before continuing")
     Dir[ENV['GATE_HOME'] + "/lib/*.jar"].each { |jar|
       require  jar
     }
     require ENV['GATE_HOME'] + '/bin/gate.jar'
    end
  end

  module JavaIO
   include_package "java.io.File"
   include_package "java.io"
  end

end
