
module Repo
  class Window < Gtk::Window
    def initialize
      super("Repo - #{Repo.store_path}")
      connect_signals
    end
    
    def connect_signals
      signal_connect("destroy") { Gtk.main_quit }
    end
  end
end
