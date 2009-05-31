
module RepoFixtures
  def self.unpack_git_fixture
    FileUtils.cd(File.dirname(__FILE__) + "/../fixtures/") do
      %x{tar xzvf repo-store.tar.gz}
    end
  end
  
  def self.rm_git_fixture
    FileUtils.rm_rf(File.dirname(__FILE__) + "/../fixtures/repo-store")
  end
end
