//
//  BallModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

class BallModel {

    private let api: APIModelProtocol
    private let answersStorage: DataAnswerProtocol

    init(api: APIModelProtocol, answersStorage: DataAnswerProtocol) {
        self.api = api
        self.answersStorage = answersStorage
    }

    private func getHardAnswers() -> String {
        return  answersStorage.getHardAnswer()
    }

    func fetchData(completion: @escaping (_ answer: ModelAnswer) -> Void) {
        if Reachability.isConnectedToNetwork() {
            api.fetchData { response in
                completion(response.toModelAnswer())
            }
        } else {
            completion(ModelAnswer(text: getHardAnswers()))
        }
    }
}
