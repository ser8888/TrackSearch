//
//  NetworkManager.swift
//  TrackSearch
//
//  Created by John Doe on 13/08/2022.
//
import Foundation
import Alamofire
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
    func fetchRequest(urlString: String,completion: @escaping (Result<[Track], Error> ) -> Void) {
        AF.request(urlString)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let results = Track.getTracks(from: value)
                    completion(.success(results))
                case .failure(let error):
                    print(error)
                }
            }
    }
}
