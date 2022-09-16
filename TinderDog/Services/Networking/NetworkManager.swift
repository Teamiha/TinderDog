//
//  NetworkManager.swift
//  TinderDog
//
//  Created by Михаил Светлов on 05.09.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    
    private init() {}
    
    func fetchImage(completion: @escaping(Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let image = try JSONDecoder().decode(Picture.self, from: data)
                let result = image.message
                print(result)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch  {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchFavoriteBreedImage(breed: String, completion: @escaping(Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breed/\(breed)/images/random") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let image = try JSONDecoder().decode(Picture.self, from: data)
                let test = image.message
                print(test)
                DispatchQueue.main.async {
                    completion(.success(test))
                }
                
            } catch  {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchFavoriteImage(URL: URL?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL else {return}

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let result = data
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch  {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}
