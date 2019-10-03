//
//  BallModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

class BallModel {
    private let api: APIModel
    private let answersStorage: DataAnswer

    init(api: APIModel, answersStorage: DataAnswer) {
        self.api = api
        self.answersStorage = answersStorage
    }

    private func getHardAnswers() -> String {
        return answersStorage.hard.randomElement() ?? "Error"
    }

    func fetchData(completion: @escaping (_ answer: ModelAnswer) -> Void) {
        if Reachability.isConnectedToNetwork() {
            api.fetchData { response in
                completion(response.toAnswer())
            }
        } else {
            completion(ModelAnswer(text: getHardAnswers()))
        }
    }
}
