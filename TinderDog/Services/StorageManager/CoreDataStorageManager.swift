//
//  CoreDataStorageManager.swift
//  TinderDog
//
//  Created by Михаил Светлов on 06.09.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TinderDog")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext

    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    
    func fetchData(completion: (Result<[FavoritePictures], Error>) -> Void) {
        let fetchRequest = FavoritePictures.fetchRequest()
        do {
            let item = try self.viewContext.fetch(fetchRequest)
            completion(.success(item))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private var favoriteItemArray: [FavoritePictures] = []
    
    private func loadFavoriteData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let items):
                self.favoriteItemArray = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func addPictureToFavorites(string: String) {
        if favoriteItemArray.contains(where: { $0.imageURL == string}) {
        } else {
            let item = FavoritePictures(context: viewContext)
            item.imageURL = string
            favoriteItemArray.append(item)
            saveContext()
        }
    }
    
    func initFavoriteStorage() {
        loadFavoriteData()
    }
    


    // MARK: - Core Data Saving support
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

