//
//  Storage.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

protocol ModelAnswerProtocol {
    func toPresentableAnswer() -> PresentableAnswer
}

struct ModelAnswer: ModelAnswerProtocol {
    let text: String
}

extension ModelAnswer {
    func toPresentableAnswer() -> PresentableAnswer {
        return PresentableAnswer(text: text.uppercased())
    }
}
