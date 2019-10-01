//
//  BallViewModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/1/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

protocol BallViewModelProtocol {
    func sendData()
}

class BallViewModel: BallViewModelProtocol {

    private let model = APIModel()

    func sendData() {
         model.fetchData()
    }
}
