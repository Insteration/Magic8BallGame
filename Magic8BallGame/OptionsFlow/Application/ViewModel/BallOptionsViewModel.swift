//
//  BallOptionsViewModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

class BallOptionsViewModel {

    private let model: BallOptionsModel

    init(model: BallOptionsModel) {
        self.model = model
    }

    func getNumberOfHardAnswers(completion: @escaping (_ answers: [String]) -> Void) {
        model.getHardAnswers { hardAnswers in

            completion(hardAnswers)
        }
    }
}
