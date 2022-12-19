//
//  AnimationController.swift
//  EMovie
//
//  Created by Aldair Carrillo on 19/12/22.
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// MARK: This solution didn't work well, but the idea is to implement this
/// animations in a global scope. The best solution for that could be with generics
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import UIKit

class AnimationController: NSObject {

    private let animationType: AnimationType
    private var animationDuration: Double = 0.8
    private var duration: TimeInterval {
        return transitionDuration(using: nil)
    }
    
    enum AnimationType {
        case principal
        case secundary
        case intern
        case dismissIntern
    }
    
    // MARK: - Init
    
    init(animationType: AnimationType) {
        self.animationType = animationType
    }
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from),
              let navFromController = fromViewController.navigationController
               else {
                  transitionContext.completeTransition(false)
                  return
              }

        let aView = navFromController.navigationBar.subviews

        transitionContext.containerView.addSubview(toViewController.view)

        switch animationType {
        case .principal:
            presentPrincipalAnimation(with: transitionContext, viewToAnimate: toViewController.view, views: aView)
        case .secundary:
            presentSecundaryAnimation(with: transitionContext, viewToAnimate: toViewController.view, views: aView)
        case .intern:
            presentInternAnimation(with: transitionContext, viewToAnimate: toViewController.view, views: aView)
        case .dismissIntern:
            animationDuration = 1.0
            transitionContext.containerView.addSubview(fromViewController.view)
            dismissInternAnimation(with: transitionContext, viewToAnimate: fromViewController.view, views: aView)
        }
    }
}

extension AnimationController {
    
    func presentPrincipalAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, views: [UIView]) {
        viewToAnimate.clipsToBounds = true
        viewToAnimate.alpha = 0.0

        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.80,
            initialSpringVelocity: 0.1,
            options: .transitionCrossDissolve,
            animations: {
            viewToAnimate.alpha = 1.0
            
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func presentSecundaryAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, views: [UIView]) {
        
        viewToAnimate.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)

        for viewTo in views {
            viewTo.frame.origin = CGPoint(x: 70, y: 100)
        }

        UIView.animate(
            withDuration: self.duration,
            delay: 0,
            options: .transitionCrossDissolve,
            animations: {
                for viewTo in views {
                    viewTo.frame.origin = CGPoint(x: 0, y: 0)
                }
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
            transitionContext.completeTransition(true)
        }

    }
    
    func presentInternAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, views: [UIView]) {
        viewToAnimate.clipsToBounds = true
        viewToAnimate.frame.origin = CGPoint(x: viewToAnimate.frame.width, y: 0)
        for viewTo in views {
            viewTo.frame.origin = CGPoint(x: viewToAnimate.frame.width, y: 0)
        }
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.70,
            initialSpringVelocity: 0.1,
            options: .transitionCrossDissolve,
            animations: {
            viewToAnimate.frame.origin = CGPoint(x: 0, y: 0)
            for viewTo in views {
                viewTo.frame.origin = CGPoint(x: 0, y: 0)
            }
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissInternAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, views: [UIView]) {
        viewToAnimate.clipsToBounds = true
        viewToAnimate.frame.origin = CGPoint(x: 0, y: 0)
        for viewTo in views {
            viewTo.frame.origin = CGPoint(x: 0, y: 0)
        }
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.70,
            initialSpringVelocity: 0.1,
            options: .transitionCrossDissolve,
            animations: {
            viewToAnimate.frame.origin = CGPoint(x: viewToAnimate.frame.width, y: 0)
            for viewTo in views {
                viewTo.frame.origin = CGPoint(x: viewToAnimate.frame.width, y: 0)
            }
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
}
