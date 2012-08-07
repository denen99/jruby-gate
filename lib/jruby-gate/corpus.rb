class JrubyGate

  class GateCorpus < JrubyGate

    attr_accessor :corpus, :document, :content
    
    def initialize
      @corpus = self.Factory.createResource("gate.corpora.CorpusImpl")
    end

    def add_document(input,controller,type='file')
      raise("Can not add document until you create a corpus!") unless @corpus
      
      if type == 'file' 
       f = File.open(input)
       @content = f.read
       f.close
       @document = self.Factory.newDocument(@content)
       @corpus.add(@document)
       controller.set_corpus(@corpus)
      else
       @content = input
       @document = self.Factory.newDocument(input)
       @corpus.add(@document)
       controller.set_corpus(@corpus)
      end
    end


  end

end