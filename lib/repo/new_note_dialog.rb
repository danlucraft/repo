
module Repo
  class NewNoteDialog < Gtk::Dialog
    MAX_ENTRIES = 30
    attr_accessor :entry, :treeview, :list
    
    def initialize
      super("New Note", nil,
        Gtk::Dialog::MODAL)
      set_size_request(500, 300)
      @entry = Gtk::Entry.new
      @list = Gtk::ListStore.new(String, String)
      renderer = Gtk::CellRendererText.new
      column = Gtk::TreeViewColumn.new("", renderer, :text => 0)
      column.visible = true
      @treeview = Gtk::TreeView.new(@list)
      @treeview.append_column(column)
      @treeview.show
      vbox.pack_start(@entry, false)
      vbox.pack_start(@treeview)
      signal_connect('response') { self.destroy }
      
      connect_signals
    end
    
    def connect_signals
      @entry.signal_connect("key-press-event") do |_, gdk_eventkey|
        entry_key_press(gdk_eventkey)
      end
      
      @entry.signal_connect("changed") do 
        @entry_changed_time = Time.now
        unless @entry_changed
          @entry_changed = true
          Gtk.idle_add_priority(GLib::PRIORITY_LOW) do
            if @entry.destroyed?
              false
            else
              if Time.now > @entry_changed_time + 0.2
                @entry_changed = false
                entry_changed
                false
              else
                true
              end
            end
          end
        end
        false
      end
    end
    
    def entry_key_press(gdk_eventkey)
      kv = gdk_eventkey.keyval
      ks = gdk_eventkey.state - Gdk::Window::MOD2_MASK
      ks = ks - Gdk::Window::MOD4_MASK
      key = Gtk::Accelerator.get_label(kv, ks)
      if key == "Down"
        treeview_select_down
        true
      elsif key == "Up"
        treeview_select_up
        true
      elsif key == "Return"
        treeview_activated
        true
      else
        false
      end
    end
    
    def entry_changed
      @list.clear
      if @entry.text.length > 2
        i = 0
        Repo.top_keys.each do |key|
          if i < MAX_ENTRIES
            iter = @list.append
            iter[0] = key + "/"
#            iter[1] = fn
          end
          i += 1
        end
      end
      # if the user hit enter before this, open the top file
      if @activated_by_user
        treeview_activated
        @activated_by_user = false
      end
    end
    
    def treeview_select_down
      if sel = @treeview.selection.selected
        ni = sel.path
        if ni.next! and iter = @treeview.model.get_iter(ni)
          @treeview.selection.select_iter(iter)
          @treeview.scroll_to_cell(ni, nil, false, 0.0, 0.0)
        end
      else
        if iter = @treeview.model.iter_first
          @treeview.selection.select_iter(@treeview.model.iter_first)
        end
      end
    end
    
    def treeview_select_up
      if sel = @treeview.selection.selected
        pi = sel.path
        if pi.prev! and iter = @treeview.model.get_iter(pi)
          @treeview.selection.select_iter(iter)
          @treeview.scroll_to_cell(pi, nil, false, 0.0, 0.0)
        end
      end
    end
    
    # opens the selected file
    def treeview_activated
      if si = @treeview.selection.selected
        @entry.text = si[0]
        @entry.position = -1
      else
        # create a new note
        @activated_by_user = true
        text = @entry.text
        self.destroy
        Repo.create_note(text)
      end
    end
  end
end
  
