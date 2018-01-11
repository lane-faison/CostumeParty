import UIKit

extension UIView {
    
    func applyPrimaryBackgroundGradient() {
        setGradientBackground(color1: UIColor.primaryDarkColor.darkerColor(), color2: .primaryColor)
    }
    
    func applySecondaryBackgroundGradient() {
        setGradientBackground(color1: UIColor.secondaryDarkColor.darkerColor(), color2: .secondaryColor)
    }
    
    private func setGradientBackground(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
