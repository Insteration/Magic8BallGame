//
//  Storage.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation
import CoreData

protocol ModelAnswerProtocol {
    func toPresentableAnswer() -> PresentableAnswer
}

struct ModelAnswer: ModelAnswerProtocol {

    let text: String
    let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
}

extension ModelAnswer {
    func toPresentableAnswer() -> PresentableAnswer {
        saveModelAnswerToCoreDataContainer()
        return PresentableAnswer(text: text.uppercased())
    }

    private func saveModelAnswerToCoreDataContainer() {
        let coreData = CoreDataStack(modelName: "zxczxc")
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = coreData.context
        moc.perform {
           do {
            try coreData.save(answer: ModelAnswer(text: self.text))
            print("SAVE data to CORE DATA with \(self.text)")
           } catch {
               print(error)
           }
        }
    }
}
