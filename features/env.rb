
require File.dirname(__FILE__) + "/../vendor/gutkumber/lib/gutkumber"

Dir[File.dirname(__FILE__) + "/lib/*.rb"].each {|fn| require fn}

After do
  RepoFixtures.rm_git_fixture
end

require File.dirname(__FILE__) + "/../lib/repo"
