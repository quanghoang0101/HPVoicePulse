//
//  ViewController.swift
//  HPVoicePulseExample
//
//  Created by Hoang on 5/4/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var pulse: PulseLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.isUserInteractionEnabled = true
        self.imageView.layer.borderColor = UIColor.clear.cgColor
        self.imageView.layer.cornerRadius = 50.0
        self.imageView.layer.masksToBounds = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.imageView.addGestureRecognizer(tapGesture)
    }


    // MARK: Actions
    @objc private func tap(_ sender: UITapGestureRecognizer) {
        if pulse != nil {
            let fraction = Float.random(in: 1 ..< 3)
            pulse!.transform = CATransform3DMakeScale(CGFloat(fraction), CGFloat(fraction), 1)
            return
        }
        pulse = PulseLayer(radius: 110, position: self.imageView.center)
        pulse!.pulse.backgroundColor = UIColor.blue.cgColor
        self.view.layer.insertSublayer(pulse!, below: self.imageView.layer)

    }

}

