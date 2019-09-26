//
//  Engine.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/15/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation
import Alamofire

struct RequestAnswersAPI {

    let api = "https://8ball.delegator.com/magic/JSON/"
    let endpoint = "request"
    let session = URLSession(configuration: .default)

    func getAnswerRequestFromApi(complitionHandler: @escaping ((MagicBall) -> Void)) {
        AF.request(api + endpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in

                switch response.result {

                case .success(let json):
                    print(json)
                    DispatchQueue.main.async {

                        do {
                            let parsedData = try JSONDecoder().decode(MagicBall.self, from: response.data!)
                            DispatchQueue.main.async {
                                complitionHandler(parsedData)
                                print(parsedData)
                            }
                        } catch {
                            print("Decoding failed")
                        }

                    }
                case .failure(let error):
                    print(error)
                }
        }
    }

}
