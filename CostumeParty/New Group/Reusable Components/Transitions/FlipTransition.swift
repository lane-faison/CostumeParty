import UIKit

class FlipTransition: NSObject {
    
    var duration: TimeInterval = 2.0
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
}

extension FlipTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true) else { return }
        
        let containerView = transitionContext.containerView
        let finalframe = transitionContext.finalFrame(for: toVC)
        
        snapshot.frame = originFrame
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransform(for: containerView)
        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                snapshot.layer.transform = AnimationHelper.yRotation(0.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                snapshot.frame = finalframe
            })
        }) { _ in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            fromVC.view.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
