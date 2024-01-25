//
//  UIView.swift
//  SearchFMWipro
//
//  Created by AG on 09/12/23.
//  Copyright © 2023 AG. All rights reserved.
//

import UIKit

extension UIView
{
    private static let kRotationAnimationKey = "rotationanimationkey"

    func startRotating(duration: Double = 1) {
        let timeInterval: CFTimeInterval = duration
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = timeInterval
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func rotate( degree : CGFloat ) {
        self.transform = CGAffineTransform(rotationAngle: degree)
        //self.transform = CGAffineTransformRotate(self.transform, degree)
    }

}

extension UIView
{
    
    func removeAllSubViews()
    {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    

    @objc var viewController : UIViewController?
    {
        var responder : UIResponder? = self
        repeat
        {
            if responder!.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
            else {
                responder = responder?.next
            }
        }
        while responder != nil
        return nil
    }
}
