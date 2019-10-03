//
//  BallOptionsModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/3/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

class BallOptionsModel {

    private let hardAnswersStorage: DataAnswer

    init(hardAnswersStorage: DataAnswer) {
        self.hardAnswersStorage = hardAnswersStorage
    }

    func getHardAnswers(completion: @escaping (_ answers: [String]) -> Void) {
        completion(hardAnswersStorage.hard)
    }

}
