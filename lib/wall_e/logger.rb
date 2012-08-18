module WallE
  module Logger
    def info(message)
      log("\033[34m#{message}\033\[0m")
    end

    def error(message)
      log("\033[31m#{message}\033\[0m")
    end

    def log(message)
      puts message
    end
  end
end