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
    private let ballView = BallBlackView()

    private let ballViewModel: BallViewModel!

    var startDate: Date?
    var countShaker = [TimeInterval]()
    
    init(ballViewModel: BallViewModel) {
        self.ballViewModel = ballViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ballView)

        setCenterForBlackBallViewInMainView()
        setDynamicWithCollisionForView()
        createGyroscopeTimer()
        setupCustomNavigationController()
        startTheTimer()

        ballViewModel.stateHandler = { [weak self] response in
            self?.useAnswer(answer: response.text)
            self?.ballView.shake()
            self?.resetTimer()
        }
    }

    // MARK: - Get Answer from Ball View Model

    private func useAnswer(answer: String) {
        self.ballView.answerLabel.text = answer
    }

    // MARK: - Motion and Gyroscope

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            ballViewModel.viewDidShaked()
        }
    }

    @objc private func cgeckDeviceMotion() {
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

    private func createGyroscopeTimer() {
        gyroTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(cgeckDeviceMotion), userInfo: nil, repeats: true)
    }

    // MARK: - Timer

    private func resetTimer() {
        timer.invalidate()
        startTheTimer()
    }

    private func startTheTimer() {
        timer = Timer.scheduledTimer(timeInterval: 9.0, target: self, selector: #selector(setDefaultStatusForAnswerBar), userInfo: nil, repeats: true)
    }

    @objc private func setDefaultStatusForAnswerBar() {
        self.ballView.answerLabel.text = L10n.shakeForAnswer
    }

    // MARK: - Setup Views

    private func setCenterForBlackBallViewInMainView() {
        ballView.translatesAutoresizingMaskIntoConstraints = false
        ballView.center = view.center
    }

    private func setDynamicWithCollisionForView() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let collisionBehavior = UICollisionBehavior(items: [ballView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
    }

    private func setupCustomNavigationController() {
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

    @objc private func action(sender: UIBarButtonItem) {
        let optionsVC = BallOptionsViewController(ballOptionsViewModel: BallOptionsViewModel(model: BallOptionsModel(
            hardAnswersStorage: DataAnswer())))
        self.navigationController?.pushViewController(optionsVC, animated: true)
    }
}
