$LOAD_PATH << '/Users/adamd/dev/projects/jruby-gate/lib'

require 'jruby-gate'

 a = JrubyGate.new
 a.add_plugin_dirs('ANNIE')
 corp = a.create_corpus
 ctrl = a.create_controller
 ctrl.add_resource('gate.creole.tokeniser.DefaultTokeniser')
 corp.add_document("This is a string about Barack Obama",ctrl.controller,'string')
 ctrl.execute

 #corp.document.getAnnotations.get(a.entity_types).each { |ann|
 corp.document.getAnnotations.get.each { |ann|
    next if ann.type == 'SpaceToken'
 #   next unless a.type == 'NounChunk'
    puts "Found annotation type: " + ann.type + ' s:' + ann.startNode.offset.to_s + ' e:' + ann.endNode.offset.to_s + \
      ' -->' +  corp.content.slice(ann.startNode.offset,ann.endNode.offset - ann.startNode.offset + 1)
  #  puts a.toString
  }
