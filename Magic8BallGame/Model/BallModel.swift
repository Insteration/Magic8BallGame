//
//  BallModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/16/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//


// MARK: - MagicBall
struct MagicBall: Codable {
    let magic: Magic
}

// MARK: - Magic
struct Magic: Codable {
    let question, answer, type: String
}
