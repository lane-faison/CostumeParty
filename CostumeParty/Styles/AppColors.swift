import UIKit

extension UIColor {
    
    public func darkerColor() -> UIColor {
        var h = CGFloat()
        var s = CGFloat()
        var b = CGFloat()
        var a = CGFloat()
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * 0.8, alpha: a)
    }
    
    public func lighterColor() -> UIColor {
        var h = CGFloat()
        var s = CGFloat()
        var b = CGFloat()
        var a = CGFloat()
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * 1.6, alpha: a)
    }
    
    static let primaryColor = UIColor(red: 0.27, green: 0.35, blue: 0.39, alpha: 1.0)
    static let primaryLightColor = UIColor(red: 0.44, green: 0.53, blue: 0.57, alpha: 1.0)
    static let primaryDarkColor = UIColor(red: 0.11, green: 0.19, blue: 0.23, alpha: 1.0)
    static let primaryTextColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0)
    static let secondaryColor = UIColor(red: 0.00, green: 0.90, blue: 0.46, alpha: 1.0)
    static let secondaryLightColor = UIColor(red: 0.40, green: 1.00, blue: 0.65, alpha: 1.0)
    static let secondaryDarkColor = UIColor(red: 0.00, green: 0.70, blue: 0.28, alpha: 1.0)
    static let secondaryTextColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)
}
