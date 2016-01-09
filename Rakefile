require 'rake/task'

lib = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'power_plant_game'

task default: :run

desc "Run rthe game"
task :run do 
	PowerPlantGame.run
end