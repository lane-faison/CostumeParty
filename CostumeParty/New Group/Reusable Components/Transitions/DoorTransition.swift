import UIKit

class DoorTransition: NSObject {
    
    var duration: TimeInterval = 0.5
    
    enum DoorTransitionMode: Int {
        case present
    }
    
    var transitionMode: DoorTransitionMode = .present
}

extension DoorTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let currentView = transitionContext.view(forKey: .from),
            let presentView = transitionContext.view(forKey: .to) else { return }
        
        switch transitionMode {
        case .present:
            presentView.transform = CGAffineTransform(scaleX: 0.001, y: 1.0)
            presentView.alpha = 0.0
            
            containerView.addSubview(currentView)
            containerView.addSubview(presentView)
            
            // View animations
            UIView.animate(withDuration: duration, animations: {
                currentView.transform = CGAffineTransform(scaleX: 0.001, y: 1.0)
                currentView.alpha = 0.0
            })
            UIView.animate(withDuration: duration, delay: duration, options: .curveEaseOut, animations: {
                presentView.transform = .identity
                presentView.alpha = 1.0
            }, completion: { (success: Bool) in
                transitionContext.completeTransition(success)
            })
        }
    }
    
    
}
