
$:.push(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'git_store'
require 'gtk2'
require 'repo/gtk'

module Repo
  class << self
    attr_accessor :store_path
  end
  
  def self.store
    return @store if @store
    @store = GitStore.new(store_path)
    @store.handler['json'] = Repo::JSONHandler
    @store
  end
  
  def self.start
    win = Window.new
    win.show_all
    start_gui
  end
  
  def self.start_gui
    unless $gutkumber
      Gtk.main_with_queue(100)
    end
  end
end

require 'repo/json_handler'
require 'repo/window'
