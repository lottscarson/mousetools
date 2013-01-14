require "cgevent"
include CGEvent

class Mousetools
  
  attr_accessor :current_coordinates
  
  def left_mouse_down(x = nil, y = nil, modifier_key_1 = nil, modifier_key_2 = nil)
    post_mouse_event(x, y, :kCGEventLeftMouseDown, :kCGMouseButtonLeft, modifier_key_1, modifier_key_2)
  end
  
  def left_mouse_up(x = nil, y = nil)
    post_mouse_event(x, y, :kCGEventLeftMouseUp, :kCGMouseButtonLeft)
  end
  
  def right_mouse_down(x = nil, y = nil, modifier_key_1 = nil, modifier_key_2 = nil)
    post_mouse_event(x, y, :kCGEventRightMouseDown, :kCGMouseButtonRight, modifier_key_1, modifier_key_2)
  end
  
  def right_mouse_up(x = nil, y = nil)
    post_mouse_event(x, y, :kCGEventRightMouseUp, :kCGMouseButtonRight)
  end
  
  def move_cursor(x, y)
    post_mouse_event(x, y, :kCGEventMouseMoved, :kCGMouseButtonLeft)
  end

  def left_mouse_drag(x, y, modifier_key_1 = nil, modifier_key_2 = nil)
    post_mouse_event(x, y, :kCGEventLeftMouseDragged, :kCGMouseButtonLeft, modifier_key_1, modifier_key_2)
  end
  
  def right_mouse_drag(x, y, modifier_key_1 = nil, modifier_key_2 = nil)
    post_mouse_event(x, y, :kCGEventRightMouseDragged, :kCGMouseButtonRight, modifier_key_1, modifier_key_2)
  end
  
  def key_down(virtual_key, modifier_key_1 = nil, modifier_key_2 = nil)
    if (modifier_key_1.nil? && modifier_key_2.nil?)
      post_keyboard_event(virtual_key, true)
    elsif (!modifier_key_1.nil? && modifier_key_2.nil?)
      post_keyboard_event(virtual_key, true, modifier_key_1)
    else
      post_keyboard_event(virtual_key, true, modifier_key_1, modifier_key_2)
    end
  end
  
  def key_up(virtual_key)
    post_keyboard_event(virtual_key, false)
  end
  
  # Private Methods
  private
    def set_current_coordinates(x, y)
      @current_coordinates = CGPoint.new if @current_coordinates.nil?
      @current_coordinates[:x] = x
      @current_coordinates[:y] = y
    end
  
    def post_mouse_event(x, y, event_type, mouse_button, modifier_key_1 = nil, modifier_key_2 = nil)
      raise "Must provide inital x and y coordinates" if (x.nil? || y.nil?) && @current_coordinates.nil?
      # Create the event
      set_current_coordinates(x, y) unless x.nil? || y.nil?
      event = CGEventCreateMouseEvent(nil, event_type, @current_coordinates, mouse_button)
      CGEventSetFlags(event, modifier_key_1) if (modifier_key_1)
      CGEventSetFlags(event, modifier_key_2) if (modifier_key_2)
      # Post the event
      CGEventPost(:kCGHIDEventTap, event)
      # Release the event ref
      CFRelease(event)
    end
  
    def post_keyboard_event(virtual_key, position, modifier_key_1 = nil, modifier_key_2 = nil)
      event = CGEventCreateKeyboardEvent(nil, virtual_key, position)
      CGEventSetFlags(event, modifier_key_1) if (modifier_key_1)
      CGEventSetFlags(event, modifier_key_2) if (modifier_key_2)
      CGEventPost(:kCGHIDEventTap, event)
      CFRelease(event)
    end
    
end