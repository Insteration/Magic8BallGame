//
//  TriangleBallView.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/16/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class BallTriangleView: UIView {

        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override func draw(_ rect: CGRect) {

            guard let context = UIGraphicsGetCurrentContext() else { return }

            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
            context.closePath()
            context.setFillColor(red: 0.00, green: 0.00, blue: 0.55, alpha: 1.0)
            context.fillPath()
        }
}
