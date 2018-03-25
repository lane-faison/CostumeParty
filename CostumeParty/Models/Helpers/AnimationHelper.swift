import UIKit

struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransform(for containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
    
    static func animateGreenSuccessView(_ view: UIView, completion: (() -> Void)?) {
        let greenView = UIView(frame: view.bounds)
        greenView.backgroundColor = UIColor.affirmativeColor
        greenView.alpha = 0.5
        greenView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        greenView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greenView)
        
        let successLabel = UILabel()
        successLabel.text = "Success!"
        successLabel.font = UIFont.h2
        successLabel.textColor = .white
        successLabel.alpha = 0.0
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successLabel)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            greenView.alpha = 1.0
            greenView.transform = .identity
        }) { (success) in
            if success {
                successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                successLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                
                UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                    successLabel.alpha = 1.0
                }, completion: { (success) in
                    if success {
                        completion?()
                    }
                })
            }
        }
    }
}
