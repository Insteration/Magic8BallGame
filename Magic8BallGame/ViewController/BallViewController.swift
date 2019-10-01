//
//  ViewController.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/15/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit
import CoreMotion

class BallViewController: UIViewController {

    lazy var animator = UIDynamicAnimator()
    private var timer = Timer()
    private var gyroTimer = Timer()
    private var motion = CMMotionManager()
    private var gravity = UIGravityBehavior()
    private let ballView = BallView()
    private let options = Options()
    private let ballViewModel = BallViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.becomeFirstResponder()
        self.view.addSubview(ballView)

        getConstrainsForBallView()
        getDynamicWithCollisionForView()
        createGyroDirection()
        createCustomNavigationController()
        startTimer()
        self.ballViewModel.sendData()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {

            if Reachability.isConnectedToNetwork() {
                self.ballViewModel.sendData()
                self.ballView.myLabel.text = Options.answer
                ballView.shake()
            } else {
                if  Options.userStatus == -1 {
                    self.ballView.myLabel.text = options.answers.randomElement()
                    ballView.shake()
                } else {
                    self.ballView.myLabel.text = options.answers[Options.userStatus]
                    ballView.shake()
                }
            }
            resetTimer()
        }
    }

    @objc func clear() {
        self.ballView.myLabel.text = L10n.shakeForAnswer
    }

    @objc func giro() {

        var horizontalCoordinateLine = 0.0

        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 0.01
            motion.startAccelerometerUpdates(to: .main) { (data, error) in
                guard let data = data, error == nil else { return }
                horizontalCoordinateLine = data.acceleration.x
            }
        }

        if horizontalCoordinateLine > 0.5 {
            gravity.angle = 0
            horizontalCoordinateLine = 1
        }
    }

    private func resetTimer() {
        timer.invalidate()
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 9.0, target: self, selector: #selector(clear), userInfo: nil, repeats: true)
    }

    private func createGyroDirection() {
        gyroTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(giro), userInfo: nil, repeats: true)
    }

    private func getConstrainsForBallView() {
        ballView.translatesAutoresizingMaskIntoConstraints = false
        ballView.center = view.center
    }

    private func getDynamicWithCollisionForView() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let collisionBehavior = UICollisionBehavior(items: [ballView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
    }

    private func createCustomNavigationController() {
        let nav = self.navigationController?.navigationBar

        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit

        let image = Asset._8.image
        imageView.image = image

        navigationItem.titleView = imageView
    }
}
