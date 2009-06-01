
$:.push(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'git_store'
require 'gtk2'
require File.dirname(__FILE__) + '/../vendor/glitter'

require 'repo/gtk'

module Repo
  class << self
    attr_accessor :store_path
  end
  
  def self.store
    return @store if @store
    @store = GitStore.new(store_path)
    @store.handler['json'] = Repo::JSONHandler
    puts "All keys: #{all_keys.inspect}"
    puts "All top keys: #{top_keys.join(" ")}"
    @store
  end
  
  def self.all_keys
    @store.map {|key, document| key}
  end
  
  def self.keys(fuzzy_path)
    bits = fuzzy_path.split("/")
  end
  
  def self.top_keys
    @store["/"].map {|k, d| k.split("/").first}.uniq
  end
  
  def self.start
    show_all
    start_gui
  end
  
  def self.start_gui
    unless $gutkumber
      Gtk.main_with_queue(100)
    end
  end
  
  def self.show_all
    win = Window.new
    win.show_all
  end
  
  def self.new_note
    dialog = NewNoteDialog.new
    dialog.show_all
    dialog.run do |response|
      p :dialog_over
    end
  end
  
  def self.create_note(path)
    p [:create_note, path]
    NewNoteWindow.new(path)
  end
end

require 'repo/json_handler'
require 'repo/window'
require 'repo/new_note_dialog'
require 'repo/new_note_window'
