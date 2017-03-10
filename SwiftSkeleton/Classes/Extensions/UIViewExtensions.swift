//
//  UIView+Extensions.swift
//  Pods
//
//  Created by Manuel on 10/28/16.
//
//

import Foundation

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

public extension UIView {
    
    // MARK: Layout Methods

    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
    
    func bindFrameToSuperviewBounds(insets: UIEdgeInsets) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: insets.top))
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: insets.left))
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: insets.bottom))
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: insets.right))
    }
    
    
    // MARK: Frame parameters
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
     var x: CGFloat {
        return self.frame.origin.x
    }
    
      var y: CGFloat {
        return self.frame.origin.y
    }
    
    var centerX: CGFloat {
        return self.center.x
    }
    
    var centerY: CGFloat {
        return self.center.y
    }

    func setWidth(width: CGFloat) {
        self.frame.size.width = width
    }
    
    func setHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    func setX(x: CGFloat) {
        self.frame.origin.x = x
    }
 
    func setY(y: CGFloat) {
        self.frame.origin.y = y
    }

    func setCenterX(x: CGFloat) {
        self.center.x = x
    }
    

    func setCenterY(y: CGFloat) {
        self.center.y = y
    }
    
    
    // MARK: View Transformation
    
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }

    
    // MARK: Gestures
    
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> ())?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    
    // MARK: Basic Animations
    
    public func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    
    public func animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    public func animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    public func pop() {
        setScale(x: 1.1, y: 1.1)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }
    
    public func popBig() {
        setScale(x: 1.25, y: 1.25)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }
    
    public func reversePop() {
        setScale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { [weak self] Void in
            self?.setScale(x: 1, y: 1)
        }) { (bool) in }
    }
    
    public func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100
        
        self.layer.add(anim, forKey: nil)
    }
    
    
    // MARK: Round Cornes

    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    public func roundView() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
    }
    
    
    // MARK: Utils

    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
    
    
}
