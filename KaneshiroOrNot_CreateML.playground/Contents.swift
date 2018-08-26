import CreateMLUI
import UIKit
if #available(OSX 10.14, *) {
    let builder = MLImageClassifierBuilder()
    builder.showInLiveView()
    print(builder)
} else {
    // Fallback on earlier versions
}


//import CreateML
import Foundation
//
//let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "<#/path/to/read/data.json#>"))
//

