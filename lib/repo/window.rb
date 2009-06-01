
module Repo
  class Window < Gtk::Window
    def initialize
      super("Repo - #{Repo.store_path}")
      set_size_request(800, 600)
      connect_signals
      button = Gtk::Button.new("New Note")
      button.signal_connect("clicked") { p :act; Repo.new_note }
      add(button)
    end
    
    def connect_signals
      signal_connect("destroy") { Gtk.main_quit }
    end
  end
end
