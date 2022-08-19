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
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in    // в dataRequest находится ответ от сервера
                switch dataRequest.result {
                case .success(let data):   // в дата находиться изображение
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
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
    //MARK: - PostRequests
    func sendPostRequest(to url: String, with data: Track, completion: @escaping(Result<Track, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: Track.self) { dataResponse in
                switch dataResponse.result {
                case .success(let track):
                    completion( .success(track))
                case .failure(let error):
                    completion( .failure(error))
                }
                
                
            }
        
    }
}

