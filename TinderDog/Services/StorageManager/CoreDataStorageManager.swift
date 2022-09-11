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
    
    // MARK: - Storage Core
    
    func fetchFavoriteImageData(completion: (Result<[FavoritePictures], Error>) -> Void) {
        let fetchRequest = FavoritePictures.fetchRequest()
        do {
            let item = try self.viewContext.fetch(fetchRequest)
            completion(.success(item))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func fetchFavoriteBreedsData(completion: (Result<[FavoriteBreeds], Error>) -> Void) {
        let fetchRequest = FavoriteBreeds.fetchRequest()
        do {
            let item = try self.viewContext.fetch(fetchRequest)
            completion(.success(item))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private var favoriteItemArray: [FavoritePictures] = []
    private var favoriteBreedArray: [String] = []
    
    private func loadFavoritePictureData() {
        StorageManager.shared.fetchFavoriteImageData { result in
            switch result {
            case .success(let items):
                self.favoriteItemArray = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadFavoriteBreedsData() {
        StorageManager.shared.fetchFavoriteBreedsData { [weak self] result in
            switch result {
            case .success(let items):
                self?.favoriteBreedArray = items.map{ i in
                    String(i.breed!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func initFavoriteStorage() {
        loadFavoritePictureData()
        loadFavoriteBreedsData()
    }
    
    // MARK: - FavoritePicture
    
    func addPictureToFavorites(string: String) {
        if favoriteItemArray.contains(where: { $0.imageURL == string}) {
        } else {
            let item = FavoritePictures(context: viewContext)
            item.imageURL = string
            favoriteItemArray.append(item)
            addBreedToFavorite(string: string)
            
            saveContext()
        }
    }
    
    // MARK: - FavoriteBreed
    
    func calculateFavoriteBreed() -> String? {
        var counts: [String: Int] = [:]
        for breed in favoriteBreedArray {
            counts[breed, default: 0] += 1
        }
        
        let favoriteBreed = counts.max{ a, b in a.value < b.value }
        if favoriteBreed?.value ?? 0 > 0 {
            return favoriteBreed?.key
        } else {
            return "Error"
        }
        
    }
    
    private func addBreedToFavorite(string: String) {
        let breed = FavoriteBreeds(context: viewContext)
        breed.breed = formateUrlToBreedName(string: string)
        favoriteBreedArray.append(breed.breed!)
        
        saveContext()
    }
    
    private func formateUrlToBreedName(string: String) -> String {
        var breed = string.components(separatedBy: "/")[4]
        if breed.contains("-"){
            breed = breed.replacingOccurrences(of: "-", with: "/", options: .literal, range: nil)
            return(breed)
        } else {
            return(breed)
        }
    }
    
    func clearBreedData() {
        favoriteBreedArray = []
        let fetchRequest = FavoriteBreeds.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
            }
        } catch let error {
            print(error)
        }
        
        saveContext()
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

