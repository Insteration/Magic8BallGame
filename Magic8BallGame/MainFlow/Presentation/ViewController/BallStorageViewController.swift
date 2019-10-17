//
//  BallStorageTableViewController.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 17.10.2019.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class BallStorageViewController: UIViewController {

    private var answersTableView: UITableView!
    private let ballViewModel: BallViewModel
    private var refreshControl = UIRefreshControl()
    private var answersList = [ModelAnswer]()

    init(ballViewModel: BallViewModel) {
        self.ballViewModel = ballViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userStorageAnswers()
        answersTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupConstraintsForTableView()
        createRefreshControl()
        userStorageAnswers()
    }
    
    // MARK: - Load answers

    private func userStorageAnswers() {
        answersList = ballViewModel.fetchData()
    }

    // MARK: - Setup Table View

    private func setupTableView() {
        answersTableView = UITableView()
        answersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        answersTableView.dataSource = self
        answersTableView.delegate = self
        view.addSubview(answersTableView)
    }

    private func setupConstraintsForTableView() {
        answersTableView.translatesAutoresizingMaskIntoConstraints = false
        answersTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        answersTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        answersTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        answersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func createRefreshControl() {
       refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
       answersTableView.addSubview(refreshControl)
    }
}

extension BallStorageViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table View Configure

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.keepOn
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = answersTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = answersList[indexPath.row].text
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = .lightGray
        }
        return cell
    }
}

extension BallStorageViewController {

    @objc
    private func refresh(sender: AnyObject) {
        userStorageAnswers()
        answersTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}
