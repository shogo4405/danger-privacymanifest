PrivacyAccessedAPI =
  Struct.new(:category, :api, :help) do
    def self.generate(line)
      data = line.split("\t")
      PrivacyAccessedAPI.new(
        data[0],
        data[1],
        data[2]
      )
    end
  end
