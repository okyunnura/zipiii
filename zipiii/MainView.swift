import Cocoa
import Foundation

class MainView: NSView {

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.register(forDraggedTypes: [NSFilenamesPboardType])
	}

	override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
		return NSDragOperation.copy
	}

	override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
		var pboard: NSPasteboard! = sender.draggingPasteboard()
		if pboard != nil {
			pboard = sender.draggingPasteboard()

			let elements = pboard.types
			if (elements?.contains((NSFilenamesPboardType as NSString) as String))! {
				let files: [String] = pboard.propertyList(forType: NSFilenamesPboardType) as! [String]
				for file in files {
					NSLog("%@", file);
				}
				NSLog("--------------------------------------");
			}

			return true
		}
		return false
	}
}
