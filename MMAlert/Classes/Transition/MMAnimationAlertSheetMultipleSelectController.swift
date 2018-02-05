//
//  AnimationFromControllerToAlertController.swift
//  Artiscovery
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

public class AnimationFromControllerToAlertController: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let animationDuration = 0.5
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return AnimationFromControllerToAlertController.animationDuration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to) as! MMAlertSheetMultipleSelectViewController
        let containerView = transitionContext.containerView
        
        //calculate frame for toview controller
        let lastFrameForToVC = (fromVC?.view.frame)!
        
        let hideFrameForToVC = CGRect(x: lastFrameForToVC.origin.x, y: lastFrameForToVC.size.height, width: lastFrameForToVC.size.width, height: lastFrameForToVC.size.height)
        toVC.view.frame = hideFrameForToVC
        
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
        dimView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: toVC,
                                                action: #selector(MMAlertSheetViewController.dismissView(_:)))
        dimView.addGestureRecognizer(tapGesture)
        containerView.addSubview(dimView)
        
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.layoutSubviews()
        
        //animation block
        UIView.animate(withDuration: TimeInterval(AnimationFromControllerToAlertController.animationDuration),
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.9,
                       options: .curveEaseInOut,
                       animations: {

                        dimView.alpha = 1.0
                        toVC.view.frame = lastFrameForToVC

        }) { (finished: Bool) in
            transitionContext.completeTransition(true)
        }
    }
}

//MARK: -
//MARK: - Dismiss Dialog
public class AnimationFromAlertControllerToController: NSObject,UIViewControllerAnimatedTransitioning
{
    
    static let animationDuration = 0.5
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return AnimationFromAlertControllerToController.animationDuration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromVC = transitionContext.viewController(forKey: .from) as! MMAlertSheetViewController
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        toVC?.view.alpha = 0.0
        containerView.addSubview((toVC?.view)!)
        
        let frameBoxViewOnAlertController = fromVC.boxView.frame
        
        let hideFrameForBoxViewOnAlertConstroller = CGRect(x: frameBoxViewOnAlertController.origin.x, y: fromVC.view.frame.size.height, width: frameBoxViewOnAlertController.size.width, height: frameBoxViewOnAlertController.size.height)
        
        var dimView = UIView()
        for subview in containerView.subviews {
            
            if subview.restorationIdentifier == "dimView" {
                
                dimView = subview
                
            }
        }
        
        UIView.animate(withDuration: TimeInterval(AnimationFromControllerToAlertController.animationDuration),
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.9,
                       options: .curveEaseInOut,
                       animations: {
                        
                        fromVC.boxView.frame = hideFrameForBoxViewOnAlertConstroller
                        dimView.alpha = 0.0
                        
        }) { (finished: Bool) in
            toVC?.view.alpha = 1.0
            dimView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
