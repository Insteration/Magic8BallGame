//
//  Engine.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/15/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

struct BallEngine {
    
    let api = "https://8ball.delegator.com/magic/JSON/"
    let endpoint = "request"
    let session = URLSession(configuration: .default)
    
    func getRequest(complitionHandler: @escaping ((MagicBall) -> Void)) {
        guard let url = URL(string: api + endpoint) else { return }
        print(url)
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let httpsResponse = response as? HTTPURLResponse else {
                print("Response cast failed")
                return
            }
            
            guard httpsResponse.statusCode == 200 else {
                print("Unexpected status code")
                return
            }
            
            guard let data = data else {
                print("Nod data presetn")
                return
            }
            
            do {
                let parsedData = try JSONDecoder().decode(MagicBall.self, from: data)
                DispatchQueue.main.async {
                    complitionHandler(parsedData)
                    print(parsedData)
                }
            } catch {
                print("Decoding failed")
            }
            
            }
            .resume()
    }
    
}
