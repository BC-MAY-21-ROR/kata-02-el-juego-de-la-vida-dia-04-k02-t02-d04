require 'rubycritic_small_badge'
require 'rubycritic/rake_task'

# config for src
RubyCriticSmallBadge.configure do |config|
  config.minimum_score = ENV.fetch('RUBYCRITICLIMIT', 75.0)
  config.output_path = ENV.fetch('RUBYCRITPATH', 'badges/lib')
end

RubyCritic::RakeTask.new(:src) do |task|
  task.options = %(--custom-format RubyCriticSmallBadge::Report
--minimum-score #{RubyCriticSmallBadge.config.minimum_score}
--format html --format console)
  task.paths = FileList['src/**/*.rb']
end

# config for test
RubyCriticSmallBadge.configure do |config|
  config.minimum_score = ENV.fetch('RUBYCRITICLIMIT', 65.0)
  config.output_path = ENV.fetch('RUBYCRITPATH', 'badges/spec')
end

RubyCritic::RakeTask.new(:test) do |task|
  task.options = %(--custom-format RubyCriticSmallBadge::Report
  --minimum-score #{RubyCriticSmallBadge.config.minimum_score}
  --format html --format console)
  task.paths = FileList['spec/**/*.rb']
end

task default: %w[src test]