require 'ffi'

module CGEvent
  extend FFI::Library
  ffi_lib '/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/CoreGraphics.framework/Versions/A/CoreGraphics'
  
  class CGPoint < FFI::Struct
    layout :x, :double,
           :y, :double
  end
  
  # Mouse/Keyboard events
  enum :CGEventType, [ :kCGEventNull,               0,		# Null Event 
                       :kCGEventLeftMouseDown,      1,		# left mouse-down event
                       :kCGEventLeftMouseUp,        2,		# left mouse-up event
                       :kCGEventRightMouseDown,     3,		# right mouse-down event
                       :kCGEventRightMouseUp,       4,		# right mouse-up event
                       :kCGEventMouseMoved,         5,		# mouse-moved event
                       :kCGEventLeftMouseDragged,   6,    # left mouse-dragged event
                       :kCGEventRightMouseDragged,  7,    # right mouse-dragged event
                       :kCGEventScrollWheel,        22,   # mouse scrolled event
                       :kCGEventOtherMouseDown,     25,   # other mouse-down event
                       :kCGEventOtherMouseUp,       26,   # other mouse-up event
                       :kCGEventOtherMouseDragged,  27,   # other mouse-dragged event
                       :kCGEventKeyDown,            10,   # key-down event
                       :kCGEventKeyUp,              11 ]  # key-up down
  
  # Mouse buttons
  enum :CGMouseButton, [ :kCGMouseButtonLeft, 0,
                         :kCGMouseButtonRight,
                         :kCGMouseButtonCenter ]
  
  # Virtual Key Codes
  enum :CGKeyCode, [ :A,              0x00,
                     :S,              0x01,
                     :D,              0x02,
                     :F,              0x03,
                     :H,              0x04,
                     :G,              0x05,
                     :Z,              0x06,
                     :X,              0x07,
                     :C,              0x08,
                     :V,              0x09,
                     :B,              0x0B,
                     :Q,              0x0C,
                     :W,              0x0D,
                     :E,              0x0E,
                     :R,              0x0F,
                     :Y,              0x10,
                     :T,              0x11,
                     :Num1,           0x12,
                     :Num2,           0x13,
                     :Num3,           0x14,
                     :Num4,           0x15,
                     :Num6,           0x16,
                     :Num5,           0x17,
                     :Equal,          0x18,
                     :Num9,           0x19,
                     :Num7,           0x1A,
                     :Minus,          0x1B,
                     :Num8,           0x1C,
                     :Num0,           0x1D,
                     :RightBracket,   0x1E,
                     :O,              0x1F,
                     :U,              0x20,
                     :LeftBracket,    0x21,
                     :I,              0x22,
                     :P,              0x23,
                     :L,              0x25,
                     :J,              0x26,
                     :Quote,          0x27,
                     :K,              0x28,
                     :Semicolon,      0x29,
                     :Backslash,      0x2A,
                     :Comma,          0x2B,
                     :Slash,          0x2C,
                     :N,              0x2D,
                     :M,              0x2E,
                     :Period,         0x2F,
                     :Grave,          0x32,
                     :KeypadDecimal,  0x41,
                     :KeypadMultiply, 0x43,
                     :KeypadPlus,     0x45,
                     :KeypadClear,    0x47,
                     :KeypadDivide,   0x4B,
                     :KeypadEnter,    0x4C,
                     :KeypadMinus,    0x4E,
                     :KeypadEquals,   0x51,
                     :Keypad0,        0x52,
                     :Keypad1,        0x53,
                     :Keypad2,        0x54,
                     :Keypad3,        0x55,
                     :Keypad4,        0x56,
                     :Keypad5,        0x57,
                     :Keypad6,        0x58,
                     :Keypad7,        0x59,
                     :Keypad8,        0x5B,
                     :Keypad9,        0x5C,
                     :return,         0x24,
                     :tab,            0x30,
                     :space,          0x31,
                     :delete,         0x33,
                     :escape,         0x35,
                     :function,       0x3F,
                     :home,           0x73,
                     :end,            0x77,                    
                     :page_up,        0x74,
                     :page_down,      0x79,
                     :forward_delete, 0x75,
                     :left_arrow,     0x7B,
                     :right_arrow,    0x7C,
                     :down_arrow,     0x7D,
                     :up_arrow,       0x7E ]

  enum :CGEventFlags, [ :alphashift,  0x00010000,
                        :shift,       0x00020000,
                        :control,     0x00040000,
                        :alt,         0x00080000,
                        :command,     0x00100000,
                        :help,        0x00400000,
                        :secondaryfn, 0x00800000 ]
  
  # CGEventTapLocation
  enum :CGEventTapLocation, [ :kCGHIDEventTap, 0,
                              :kCGSessionEventTap,
                              :kCGAnnotatedSessionEventTap ]                    
  
  # Attach to the CGEventCreateMouseEvent function
  attach_function :CGEventCreateMouseEvent, [ :pointer, :CGEventType, CGPoint.by_value, :CGMouseButton ], :pointer
  attach_function :CGEventCreateKeyboardEvent, [:pointer, :CGKeyCode, :bool ], :pointer
  attach_function :CGEventSetFlags, [:pointer, :CGEventFlags], :void
  attach_function :CGEventSetType, [:pointer, :CGEventType], :void
  attach_function :CGEventPost, [ :CGEventTapLocation, :pointer], :void
  attach_function :CFRelease, [:pointer], :void

end
