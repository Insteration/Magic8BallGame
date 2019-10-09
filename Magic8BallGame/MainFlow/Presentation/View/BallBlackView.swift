//
//  BallView.swift
//  Magic8BallGame

import UIKit

class BallBlackView: UIView {

    var answerLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: 65, width: 100, height: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = L10n.shakeForAnswer
        label.font = label.font.withSize(9.0)
        label.textColor = UIColor.white
        label.layer.cornerRadius = 3.0
        label.clipsToBounds = true
        label.backgroundColor = .clear
        return label
    }()

    var backgroundView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        view.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.0, alpha: 0.8)
        view.layer.cornerRadius = (view.bounds.size.width * view.bounds.size.height).squareRoot() / 2
        view.clipsToBounds = true
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.0
        return view
    }()
    
    fileprivate func setupBallView() {
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        self.layer.cornerRadius = (self.bounds.size.width * self.bounds.size.height).squareRoot() / 2
        self.layer.masksToBounds = true
        self.backgroundColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBallView()
        
        self.addSubview(backgroundView)
        backgroundView.center = self.center
        
        let triangle = BallTriangleView(frame: CGRect(x: 0, y: 0, width: 150, height: 120))
        triangle.backgroundColor = .clear
        
        self.backgroundView.addSubview(triangle)
        triangle.addSubview(answerLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
