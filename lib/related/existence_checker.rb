module Related

  class ExistenceChecker
    def self.exists?(filename)
      filename = filename.to_s
      filename.include?("*") ? Dir.glob(filename).any? : File.exists?(filename)
    end
  end

end

