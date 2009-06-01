
module Repo
  class NewNoteWindow < Gtk::Window
    def initialize(path)
      @path = path
      super(path.split("/").last)
      connect_signals
      show_all
    end
    
    def connect_signals
      signal_connect("destroy") do 
        save
      end
    end
    
    def save
      Repo.store[@path] = "note #{rand(10000)}"
      Repo.store.commit "Created new note: #{@path}"
    end
  end
end
