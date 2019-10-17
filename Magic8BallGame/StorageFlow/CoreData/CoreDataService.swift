import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var context: NSManagedObjectContext { get set }
    func save(answer: ModelAnswer) throws
    func answers() throws -> [ModelAnswer]?
}

enum RepositoryError: Error {
    case general
    case unexpectedData
}

class CoreDataService: CoreDataServiceProtocol {

    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var context: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print(fatalError)
            }
        }
        return container
    }()

    func saveContext() throws {
        do {
            try context.save()
        } catch {
            throw RepositoryError.general
        }
    }

    func saveContextIfNeeded() throws {
        if context.hasChanges {
            try saveContext()
        }
    }

    func save(answer: ModelAnswer) throws {
        let managedObject = try answerManagedObject(text: answer.text) ?? createAnswerManagedObject(text: answer.text)
        fill(managedObject: managedObject, withAnswer: answer)

        try saveContextIfNeeded()
    }

    func save(answers: [ModelAnswer]) throws {
        let existingManagedObjects = try answerManagedObjects(texts: answers.map { $0.text })
        for answer in answers {
            let managedObject = existingManagedObjects?.filter({ $0.text == answer.text }).first ?? createAnswerManagedObject(text: answer.text)
            fill(managedObject: managedObject, withAnswer: answer)
        }

        try saveContextIfNeeded()
    }

    // MARK: Read
    func answers() throws -> [ModelAnswer]? {
        return try answers(withPredicate: nil)
    }

    // MARK: Helpers Database Access

    private func answers(withPredicate predicate: NSPredicate?) throws -> [ModelAnswer]? {
        let managedObjects = try answerManagedObjects(predicate: predicate)
        let answers = managedObjects?.map {
            try? answer(fromManagedObject: $0)
        }

        return answers?.compactMap { $0 }
    }

    private func answerManagedObjects(texts: [String]) throws -> [AnswerManagedObject]? {
        let predicate = NSPredicate(format: "text IN %@", texts)

        return try answerManagedObjects(predicate: predicate)
    }

    private func answerManagedObjects(predicate: NSPredicate?) throws -> [AnswerManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: AnswerManagedObject.self))
        fetchRequest.predicate = predicate

        do {
            return try context.fetch(fetchRequest) as? [AnswerManagedObject]
        } catch {
            throw RepositoryError.general
        }
    }

    private func answerManagedObject(text: String) throws -> AnswerManagedObject? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: AnswerManagedObject.self))
        fetchRequest.predicate = NSPredicate(format: "text == %@", text)
        fetchRequest.fetchLimit = 1

        do {
            return try context.fetch(fetchRequest).first as? AnswerManagedObject
        } catch {
            throw RepositoryError.general
        }
    }

    private func createAnswerManagedObject(text: String) -> AnswerManagedObject {
        let answerObject = NSEntityDescription.insertNewObject(forEntityName: String(describing: AnswerManagedObject.self),
                                                               into: context) as? AnswerManagedObject
        answerObject?.text = text

        return answerObject!
    }

    // MARK: Helpers Mappers
    private func fill(managedObject: AnswerManagedObject, withAnswer answer: ModelAnswer) {
        managedObject.text = answer.text
    }

    private func answer(fromManagedObject managedObject: AnswerManagedObject) throws -> ModelAnswer {
        guard let text = managedObject.text else {
                throw RepositoryError.unexpectedData
        }
        return ModelAnswer(text: text)
    }
}
