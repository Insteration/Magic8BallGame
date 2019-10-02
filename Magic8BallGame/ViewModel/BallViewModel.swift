//
//  BallViewModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/1/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

class BallViewModel {

    private let model: APIModel
    private let options = Options()

    init(model: APIModel) {
        self.model = model
    }

    func viewDidShaked(completion: @escaping (_ answer: String) -> Void) {
        if Reachability.isConnectedToNetwork() {
        model.fetchData { answer in
            completion(answer)
            }
         } else {
            completion(options.answers.randomElement() ?? options.answers[Options.userStatus])
        }
    }
}
