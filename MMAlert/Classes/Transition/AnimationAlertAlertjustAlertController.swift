//
//  AnimationAlertjustAlertController.swift
//  Artiscovery
//
//  Created by Moosa Mir on 11/13/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

public class AnimationFromControllerToAlertJustAlertController: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let animationDuration = 0.5
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return AnimationFromControllerToAlertJustAlertController.animationDuration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to) as! MMAlertAlertJustAlertViewController
        let containerView = transitionContext.containerView
        
        toVC.view.frame = (fromVC?.view.frame)!
        
        toVC.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        toVC.view.layoutIfNeeded()
        
        let tmpViewFrom = fromVC?.view
        transitionContext.containerView.addSubview(tmpViewFrom!)
        
        //snapshots
        let tabBarSnapShot = fromVC?.view.snapshotView(afterScreenUpdates: false)
        containerView.addSubview(tabBarSnapShot!)
        containerView.layoutSubviews()
        fromVC?.view.alpha = 0.0
        tabBarSnapShot?.restorationIdentifier = "dialogPresenter"
        
        //overLay
        let dimView = UIView(frame: transitionContext.finalFrame(for: toVC))
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.alpha = 0.0
        dimView.restorationIdentifier = "dimView"
        containerView.addSubview(dimView)
        
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.layoutSubviews()
        
        //animation block
        UIView.animate(withDuration: TimeInterval(AnimationFromControllerToAlertJustAlertController.animationDuration),
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.9,
                       options: .curveEaseInOut,
                       animations: {
                        toVC.containerView.transform = .identity
                        dimView.alpha = 1.0
                        toVC.viewWillLayoutSubviews()
                        
        }) { (finished: Bool) in
            transitionContext.completeTransition(true)
        }
    }
}

//MARK: - Dismiss Dialog
public class AnimationFromAlertJustAlertControllerToFromController: NSObject,UIViewControllerAnimatedTransitioning
{
    
    static let animationDuration = 0.3
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return AnimationFromAlertJustAlertControllerToFromController.animationDuration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromVC = transitionContext.viewController(forKey: .from) as! MMAlertAlertJustAlertViewController
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        toVC?.view.alpha = 0.0
        containerView.addSubview((toVC?.view)!)
        
        var dimView = UIView()
        for subview in containerView.subviews {
            
            if subview.restorationIdentifier == "dimView" {
                
                dimView = subview
                
            }
        }
        
        UIView.animate(withDuration: TimeInterval(AnimationFromAlertJustAlertControllerToFromController.animationDuration),
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.9,
                       options: .curveEaseInOut,
                       animations: {
                        fromVC.containerView.alpha = 0.0
                        dimView.alpha = 0.0
                        
        }) { (finished: Bool) in
            toVC?.view.alpha = 1.0
            dimView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

