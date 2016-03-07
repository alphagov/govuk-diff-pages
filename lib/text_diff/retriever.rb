module TextDiff
  class Retriever
    def call(url)
      `curl -s #{url}`
    end
  end
end
