# Creats an array of themes from the app/views/portfolios/themes
class Themes
  def self.array
    @array ||= Dir['app/views/portfolios/themes/*']
               .map { |file| file.rpartition('/').last.partition('.').first[1..-1] }
  end
end
