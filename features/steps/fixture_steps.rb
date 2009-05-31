
Given /I open an empty Repo store/ do
  RepoFixtures.unpack_git_fixture
  Repo.store_path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/repo-store")
  Repo.start
end
