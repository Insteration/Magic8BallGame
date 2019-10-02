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

    private lazy var animator = UIDynamicAnimator()
    private var timer = Timer()
    private var gyroTimer = Timer()
    private var motion = CMMotionManager()
    private var gravity = UIGravityBehavior()
    private let ballView = BallView()
    private let options = Options()

    private lazy var ballViewModel: BallViewModel = {
        let viewModel = BallViewModel(model: APIModel())
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(ballView)

        getCenterForBallView()
        getDynamicWithCollisionForView()
        createGyroDirection()
        createCustomNavigationController()
        startTimer()
    }

    private func useAnswer(answer: String) {
        self.ballView.answerLabel.text = answer
    }

    // MARK: - Motion check

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {

            ballViewModel.viewDidShaked { [weak self] (answer: String) in
                self?.useAnswer(answer: answer)
                self?.ballView.shake()
            }
            resetTimer()
        }
    }

    @objc func cgeckDeviceMotion() {

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

    private func createGyroDirection() {
        gyroTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(cgeckDeviceMotion), userInfo: nil, repeats: true)
    }

    // MARK: - Timer

    private func resetTimer() {
        timer.invalidate()
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 9.0, target: self, selector: #selector(getDefaultStatusForAnswerBar), userInfo: nil, repeats: true)
    }

    @objc func getDefaultStatusForAnswerBar() {
        self.ballView.answerLabel.text = L10n.shakeForAnswer
    }

    // MARK: - Setup Views etc

    private func getCenterForBallView() {
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: L10n.wait,
                                                                      style: .done,
                                                                      target: self,
                                                                      action: #selector(self.action(sender:)))
    }

    @objc func action(sender: UIBarButtonItem) {
        let optionsVC = BallOptionsViewController()
        self.navigationController?.pushViewController(optionsVC, animated: true)
    }
}
