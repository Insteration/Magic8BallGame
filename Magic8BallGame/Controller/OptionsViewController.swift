//
//  OptionsViewController.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 9/3/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    @IBOutlet weak var optionsTableView: UITableView!
    
    private var options = Options()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        optionsTableView.dataSource = self
        optionsTableView.delegate = self
    }
}

extension OptionsViewController: UITableViewDataSource, UITableViewDelegate {
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
        Options.user = indexPath.row
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}