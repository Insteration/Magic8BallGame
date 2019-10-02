//
//  Engine.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/15/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Alamofire

class APIModel {

    private let api = "https://8ball.delegator.com/magic/JSON/"
    private let endpoint = "request"

    func fetchData(completion: @escaping (_ answer: String) -> Void) {
        loadData { doMagic in
            completion(doMagic.magic.answer)
        }
    }

    private func loadData(completed: @escaping (_ posts: MagicBall) -> Void) {

        guard let apiUrl = URL(string: api + endpoint) else { return }

        AF.request(apiUrl, method: .get).responseJSON { response in

            switch response.result {
            case .success:

                guard let data = response.data else { return }

                do {
                     let myResponse = try JSONDecoder().decode(MagicBall.self, from: data)
                    completed(myResponse)
                } catch {}

            case .failure(let error):
                print(error)
            }
        }
    }
}
