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
    private var options = Options()

    private func createTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        optionsTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        self.view.addSubview(optionsTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTableView()
    }
}

extension BallOptionsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.chooseAnswer
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = optionsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options.answers[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        Options.userStatus = indexPath.row
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }

}
