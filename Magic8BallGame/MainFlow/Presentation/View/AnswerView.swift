//
//  BallView.swift
//  Magic8BallGame

import UIKit

class AnswerMainView: UIView {

    // MARK: - UIView's objects

    var answerLabel: UILabel = {
        let label = UILabel()
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

    var viewForTriangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.0, alpha: 0.8)
        view.clipsToBounds = true
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 2.0
        return view
    }()

    private func setupBallView() {
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        layer.masksToBounds = true
        backgroundColor = .black
    }

    private func setupConstraintsForBallView() {
        viewForTriangleView.translatesAutoresizingMaskIntoConstraints = false
        viewForTriangleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        viewForTriangleView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        viewForTriangleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewForTriangleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func setupLabelView() {
        let labelView = UIView()
        self.viewForTriangleView.addSubview(labelView)
        labelView.backgroundColor = .clear
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        labelView.topAnchor.constraint(equalTo: topAnchor, constant: 75).isActive = true
        labelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelView.addSubview(answerLabel)

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBallView()

        self.addSubview(viewForTriangleView)
        setupConstraintsForBallView()

        setupLabelView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
