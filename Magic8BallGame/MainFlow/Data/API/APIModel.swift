//
//  Engine.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/15/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Alamofire

protocol APIModelProtocol {
    func fetchData(completion: @escaping (_ answer: DataAnswer) -> Void)
}

class APIModel: APIModelProtocol {

    private let api = "https://8ball.delegator.com/magic/JSON/request"

    func fetchData(completion: @escaping (DataAnswer) -> Void) {
             loadData { response in
                switch response {
                case .success(let response):
                    completion(DataAnswer(text: response.magic.answer))
                case .failure:
                    completion(DataAnswer(text: DataAnswer().hard.randomElement()!))
                }
             }
     }

    private func loadData(completion: @escaping (Result<MagicBall, Error>) -> Void) {

        guard let apiUrl = URL(string: api) else { return }

        AF.request(apiUrl, method: .get).responseJSON { response in

            switch response.result {
            case .success:

                guard let data = response.data else { return }

                do {
                    let myResponse = try JSONDecoder().decode(MagicBall.self, from: data)
                    completion(Result.success(myResponse))
                } catch {
                    completion(Result.failure(error))
                }

            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
