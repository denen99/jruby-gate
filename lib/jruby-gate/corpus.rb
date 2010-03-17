class JrubyGate

  class GateCorpus < JrubyGate

    attr_accessor :corpus, :document, :content
    
    def initialize
      @corpus = self.Factory.createResource("gate.corpora.CorpusImpl")
    end

    def add_document_file(f)
      raise("Can not add document until you create a corpus!") unless @corpus
      f = File.open(f)
      @content = f.read
      f.close
      @document = self.Factory.newDocument(@content)
      @corpus.add(@document)
    end

    def add_document_string(s)
      @content = s
      @document = self.Factory.newDocument(s)
      @corpus.add(@document)
    end

  end

end