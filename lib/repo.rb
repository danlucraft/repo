
require 'rubygems'
require 'git_store'

module Repo
  def self.store
    return @store if @store
    @store = GitStore.new(ARGV[0])
    @store.handler['json'] = Repo::JSONHandler
    @store
  end
end

require 'repo/json_handler'
