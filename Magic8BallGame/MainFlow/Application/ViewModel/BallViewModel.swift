//
//  BallViewModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/1/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

class BallViewModel {

    private let model: BallModel
    var stateHandler: ((PresentableAnswer) -> Void)?

    init(model: BallModel) {
        self.model = model
    }

    func viewDidShaked() {
        model.fetchData { answer in
            self.stateHandler?(answer.toPresentableAnswer())
        }
    }
}
