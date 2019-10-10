//
//  OptionsViewController.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 9/3/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class BallOptionsViewController: UIViewController {
    
    private var optionsTableView: UITableView!
    private var ballOptionsViewModel: BallOptionsViewModel!
    private var hardAnswers = [String]()
    
    init(ballOptionsViewModel: BallOptionsViewModel) {
        self.ballOptionsViewModel = ballOptionsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableViewWithConstraints() {
        optionsTableView = UITableView()
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        view.addSubview(optionsTableView)
        
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        optionsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        optionsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        optionsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        optionsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableViewWithConstraints()
        
        ballOptionsViewModel.getNumberOfHardAnswers { (answers) in
            for answer in answers {
                self.hardAnswers.append(answer)
            }
        }
    }
}

extension BallOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.chooseAnswer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = optionsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = hardAnswers[indexPath.row]
        return cell
    }
}
