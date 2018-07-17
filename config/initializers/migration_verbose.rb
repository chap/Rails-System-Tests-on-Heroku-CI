if ( File.basename($0) == 'rake' || File.basename($0) == 'rails')
   Rails.logger.level = :debug
end
