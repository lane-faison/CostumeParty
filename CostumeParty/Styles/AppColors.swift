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
    static let secondaryButtonColor: UIColor = #colorLiteral(red: 0.3019607843, green: 0.6509803922, blue: 0.3058823529, alpha: 1) //#4DA64E
    static let primaryTextColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) //#41464D
    static let darkerGrey: UIColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1) //#424242
    static let lighterGrey: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) //#CDCDCD
    static let orange: UIColor = #colorLiteral(red: 0.9764705882, green: 0.5960784314, blue: 0, alpha: 1) //#F99800
    static let yellow: UIColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.6980392157, alpha: 1) //#FFE0B2
    static let primaryColor: UIColor = #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1) //#3F51B5
    static let accentColor: UIColor =  #colorLiteral(red: 0, green: 0.3058823529, blue: 0.5725490196, alpha: 1) //#004E92
    static let darkPrimary: UIColor =  #colorLiteral(red: 0, green: 0.01568627451, blue: 0.1568627451, alpha: 1) //#000428
}
