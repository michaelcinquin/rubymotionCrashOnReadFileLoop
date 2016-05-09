# coding: utf-8


class Scan_binary
  def readBigBinaryFile(file)
#   PURE RUBY WOULD BE
#   source=File.open(file,'r')
    source =NSFileHandle.fileHandleForReadingAtPath(file)
    buffer_size=4096
    offset=0
    size=File.size(file)
    while ( offset + buffer_size ) <= size
      abuffer=nil #useless, but inspired from http://stackoverflow.com/questions/16288936/how-do-i-prevent-memory-leak-when-i-load-large-pickle-files-in-a-for-loop
      dataPointer=nil #useless
      #      PURE RUBY WOULD BE
#      source.seek(offset) 
#      abuffer = source.read( buffer_size )
#      abuffer=abuffer.to_s

      source.seekToFileOffset(offset)
      abuffer = source.readDataOfLength(buffer_size)
      offset+=buffer_size
      dataPointer = Pointer.new(:uchar,4) 
      abuffer.getBytes(dataPointer, length: 4)
      # memory leaks very rapidly in GBs if we don't release the buffer…
      # but this relase action will make the application crash once the doSomething lookp is finished
#      abuffer.release
    end
    source.closeFile
    return false
  end
end


class AppDelegate

  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
                                                     styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
                                                     backing: NSBackingStoreBuffered,
                                                     defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
    doSomething
  end

  def doSomething
    x=0
    while x < 10000
      my_scan_binary_instance=Scan_binary.new()
      result=my_scan_binary_instance.readBigBinaryFile(NSBundle.mainBundle.pathForResource("samplefile", ofType:"img"))
      puts result.to_s
      x+=1
    end
    puts "if we have used 'abuffer.release', we are going to crash now"
  end

end


