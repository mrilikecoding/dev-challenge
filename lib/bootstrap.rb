class Bootstrap
    def self.config
      $data_directory = Dir["./data/*.*"]
      $database_file = "./lib/db.csv"
    end
end
