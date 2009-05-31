require 'monitor'

module Gtk
 	GTK_PENDING_BLOCKS = []
  GTK_PENDING_BLOCKS_LOCK = Monitor.new
  
  class << self
    attr_reader :thread
  end
  
  def Gtk.queue(&block)
    if Thread.current == Gtk.thread
      block.call
    else
      GTK_PENDING_BLOCKS_LOCK.synchronize do
        GTK_PENDING_BLOCKS << block
      end
    end
  end
  
  def self.execute_pending_blocks
    GTK_PENDING_BLOCKS_LOCK.synchronize do
      GTK_PENDING_BLOCKS.each do |block|
        block.call
      end
      GTK_PENDING_BLOCKS.clear
    end
  end
  
 	def Gtk.main_with_queue(timeout)
   @thread = Thread.current
  Gtk.timeout_add timeout do
    execute_pending_blocks
    true
  end
  Gtk.main
end
end
