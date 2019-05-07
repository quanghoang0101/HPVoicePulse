//
//  PulseLayer.swift
//  HPVoicePulseExample
//
//  Created by Hoang on 5/4/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

class PulseLayer: CAReplicatorLayer {
    let pulse = CALayer()
    fileprivate var animationGroup = CAAnimationGroup()

    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0.15
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Int = 0

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(numberOfPulses: Int = 4, repeatCount: Float = Float.infinity, radius: CGFloat, position: CGPoint) {
        super.init()
        backgroundColor = UIColor(red: 0, green: 0.455, blue: 0.756, alpha: 0.45).cgColor

        pulse.backgroundColor = UIColor.black.cgColor
        pulse.contentsScale = UIScreen.main.scale
        pulse.opacity = 0

        self.radius = radius
        self.numberOfPulses = numberOfPulses

        self.position = position
        self.repeatCount = repeatCount
        self.instanceCount = self.numberOfPulses
        self.instanceDelay = (animationDuration + nextPulseAfter) / Double(self.numberOfPulses)

        pulse.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        pulse.cornerRadius = radius

        addSublayer(pulse)

        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.pulse.add(self.animationGroup, forKey: "pulse")
            }
        }
    }

    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }

    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        return opacityAnimation
    }

    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = self.repeatCount
        let defaultCurse = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        self.animationGroup.timingFunction = defaultCurse
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
}
