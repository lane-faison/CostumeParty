import UIKit

extension UIView {
    
    func applyPrimaryBackgroundGradient() {
        setGradientBackground(color1: UIColor.lightTextColor.darkerColor(), color2: .lightTextColor)
    }
    
    func applySecondaryBackgroundGradient() {
        setGradientBackground(color1: UIColor.lightTextColor.darkerColor(), color2: .lightTextColor)
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
