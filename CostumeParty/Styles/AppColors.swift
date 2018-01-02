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
    
    static let primaryButtonColor: UIColor = #colorLiteral(red: 0, green: 0.4666666667, blue: 0.7098039216, alpha: 1) //#0077B5
    static let primaryTextColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) //#41464D
    static let darkerGrey: UIColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1) //#424242
    static let lighterGrey: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)//#CDCDCD
}
