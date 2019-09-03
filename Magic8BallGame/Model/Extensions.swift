//
//  Extensions.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/16/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 30, y: 50)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
