require 'java'
require 'rubygems'
require 'hpricot'

require 'jruby-gate/config'
require 'jruby-gate/xmlparse'

class JrubyGate

 import "java.util"
 import "java.net"
 import "gate"
 import "gate.creole"
 import "gate.util"

   def initialize
     JrubyGate::Configuration.new 
   end

end
