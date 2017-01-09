import Cocoa
import Foundation
import Zip
import XCGLogger

class MainView: NSView {
	private let log = XCGLogger.default

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
				if (files.isEmpty) {
					log.info("files is empty");
					return false;
				}

				var filePaths: [URL] = [];
				for file in files {
					log.info(file);
					let filePath = URL(fileURLWithPath: file)
					filePaths.append(filePath)
				}

				do {
					try Zip.zipFiles(paths: filePaths, zipFilePath: URL(fileURLWithPath: NSHomeDirectory() + "/Desktop/sample.zip"), password: nil, progress: { (progress) -> () in
						self.log.info(progress);
					});
				} catch {
					log.info("Something went wrong")
				}
				log.info("--------------------------------------");
			}

			return true
		}
		return false
	}
}
