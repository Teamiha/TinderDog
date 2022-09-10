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
    
//case .success(let pictures):
//    self?.favoritePicture = pictures.map { pictureModel in
//        Picture(
//            message: pictureModel.imageURL!,
//            status: "Ok"
//        )
//    }
    
    
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
        
        return favoriteBreed?.key
    }
    
    private func addBreedToFavorite(string: String) {
        let breed = FavoriteBreeds(context: viewContext)
        breed.breed = string.components(separatedBy: "/")[4]
        favoriteBreedArray.append(breed.breed!)
        
        print("-----------------")
        print(favoriteBreedArray)
        print("-----------------")
        
        
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

