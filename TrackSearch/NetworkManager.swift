//
//  NetworkManager.swift
//  TrackSearch
//
//  Created by John Doe on 13/08/2022.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                print("noData")
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }

//    func fetchRequest(urlString: String,completion:  @escaping (Result<Reply, Error> ) -> Void) {
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            DispatchQueue.main.async {
//                if let error = error  {
//                    print("Error")
//                    completion(.failure(error))
//                    return
//                }
//                guard let data = data else { return }
//                do {
//                    let tracks = try JSONDecoder().decode(Reply.self, from: data)
//                    completion(.success(tracks))
//                } catch let jsonError {
//                    print("Failed to decode JSON ", jsonError)
//                    completion(.failure(jsonError))
//                }
//            }
//        }.resume()
//    }
}
