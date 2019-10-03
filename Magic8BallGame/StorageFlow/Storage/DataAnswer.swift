//
//  DataAnswer.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

protocol DataAnswerProtocol {
    func toAnswer() -> ModelAnswer
}

struct DataAnswer: DataAnswerProtocol {
    var text = ""

    let hard = [
        L10n.justDoIt,
        L10n.changeYourMind,
        L10n.keepOn,
        L10n.notNow,
        L10n.wait,
        L10n.letSDoIt
    ]
}

extension DataAnswer {
    func toAnswer() -> ModelAnswer {
        return ModelAnswer(text: text)
    }
}
