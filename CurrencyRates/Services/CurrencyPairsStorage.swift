//
//  CurrencyPairsStorage.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import CoreData

protocol CurrencyPairsStorage {
    func fetchExistingCurrencyPairs() throws -> [CurrencyPair]
    func saveNew(_ currencyPair: CurrencyPair)
    func delete(_ currencyPair: CurrencyPair)
}

final class CurrencyPairsStorageImp: CurrencyPairsStorage {
    
    private lazy var persistentContainer: NSPersistentContainer = makePersistentContainer()
    
    // MARK: - Public
    func fetchExistingCurrencyPairs() throws -> [CurrencyPair] {
        let pairObjects = try fetchExistingPairObjects()
        return pairObjects.compactMap { CurrencyPair(from: $0) }
    }
    
    func saveNew(_ currencyPair: CurrencyPair) {
        let pairObject = CurrencyPairObject(entity: CurrencyPairObject.entity(), insertInto: context)
        pairObject.rawValue = currencyPair.rawValue
        pairObject.dateAdded = Date() as NSDate
        saveContext()
    }
    
    func delete(_ currencyPair: CurrencyPair) {
        guard let objectToDelete = try? fetchExistingPairObjects(with: currencyPair.rawValue) else { return }
        objectToDelete.forEach { context.delete($0) }
        saveContext()
    }
    
    // MARK: - Private
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func fetchExistingPairObjects(with rawValue: String? = nil) throws -> [CurrencyPairObject] {
        let request: NSFetchRequest<CurrencyPairObject> = CurrencyPairObject.fetchRequest()
        let dateSorting = NSSortDescriptor(key: #keyPath(CurrencyPairObject.dateAdded), ascending: false)
        if let rawValue = rawValue {
            request.predicate = NSPredicate(format: "rawValue = %@", rawValue)
        }
        request.sortDescriptors = [dateSorting]
        return try context.fetch(request)
    }
    
    private func saveContext() {
        guard context.hasChanges else { return }
        try? context.save()
    }
    
    private func makePersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: App.storageName)
        container.loadPersistentStores() { (_, error) in
            if let error = error as NSError? {
                fatalError("Error creating persistent container. \nDomain: \(error.domain), \nUserInfo: \(error.userInfo)")
            }
        }
        return container
    }
    
}
