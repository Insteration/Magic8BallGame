//
//  BallModel.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 10/2/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//
import CoreData

class BallModel {

    private let api: APIModelProtocol
    private let answersStorage: DataAnswerProtocol
    private let coreData: CoreDataServiceProtocol

    init(api: APIModelProtocol, answersStorage: DataAnswerProtocol, coreData: CoreDataServiceProtocol) {
        self.api = api
        self.answersStorage = answersStorage
        self.coreData = coreData
    }

    private func getHardAnswers() -> String {
        return  answersStorage.getHardAnswer()
    }

    private func saveModelAnswerToCoreDataContainer(modelAnswer: ModelAnswer) {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = coreData.context
        moc.perform {
            do {
                try self.coreData.save(answer: modelAnswer)
            } catch {
                print(error)
            }
        }
    }

    func fetchDataFromStorage() -> [ModelAnswer] {
        var answers = [ModelAnswer]()
        do {
            answers = try (coreData.answers() ?? [ModelAnswer(text: "error")])
        } catch {
            print(error)
        }
        return answers
    }

    func fetchData(completion: @escaping (_ answer: ModelAnswer) -> Void) {
        if Reachability.isConnectedToNetwork() {
            api.fetchData { response in
                completion(response.toModelAnswer())
                self.saveModelAnswerToCoreDataContainer(modelAnswer: response.toModelAnswer())
            }
        } else {
            completion(ModelAnswer(text: getHardAnswers()))
            self.saveModelAnswerToCoreDataContainer(modelAnswer: ModelAnswer(text: getHardAnswers()))
        }
    }
}
