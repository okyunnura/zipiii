import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
	func windowWillClose(_ notification: Notification) {
		NSApplication.shared().terminate(0)
	}
}
