import UIKit
import Foundation

enum SmartResidentImageType: String {
    case backgroung_login
}
extension UIImage {
    convenience init?(imageType: SmartResidentImageType) {
        self.init(named: imageType.rawValue)
    }
}
