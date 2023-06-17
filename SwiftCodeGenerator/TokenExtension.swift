import UIKit

extension UIFont {
    static var title: UIFont {
      UIFont(name: "OpenSans Bold", size: 22) ?? .systemFont(ofSize: 22)
    }
    static var caption: UIFont {
      UIFont(name: "OpenSans Regular", size: 12) ?? .systemFont(ofSize: 12)
    }
    static var body: UIFont {
      UIFont(name: "OpenSans Medium", size: 14) ?? .systemFont(ofSize: 14)
    }
}

extension UIColor {
    static var blueLight: UIColor {
      UIColor.hexColor("#ADD8E6") ?? .black
    }
    static var blueDark: UIColor {
      UIColor.hexColor("#00008B") ?? .black
    }
    static var blueRegular: UIColor {
      UIColor.hexColor("#89CFF0") ?? .black
    }
    static var greenLight: UIColor {
      UIColor.hexColor("#90EE90") ?? .black
    }
    static var greenDark: UIColor {
      UIColor.hexColor("#013220") ?? .black
    }
    static var greenRegular: UIColor {
      UIColor.hexColor("#32CD32") ?? .black
    }
    static var redLight: UIColor {
      UIColor.hexColor("#FFCCCB") ?? .black
    }
    static var redDark: UIColor {
      UIColor.hexColor("#8b0000") ?? .black
    }
    static var redRegular: UIColor {
      UIColor.hexColor("#880808") ?? .black
    }
}
