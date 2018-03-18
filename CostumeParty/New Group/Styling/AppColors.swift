import UIKit

extension UIColor {
    static let destructiveColor = UIColor(red:0.93, green:0.30, blue:0.24, alpha:1.0) // Red
    static let linkColor = UIColor(red:0.18, green:0.49, blue:0.96, alpha:1.0) // Blue
    static let affirmativeColor = UIColor(red:0.47, green:0.84, blue:0.45, alpha:1.0) // Green
    static let inactiveColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1.0) // Light Grey
    static let primaryColor = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
    static let darkTextColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    static let lightTextColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
    
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
}
