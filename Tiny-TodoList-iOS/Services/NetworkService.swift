//
//  NetworkService.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation
//MARK: Code not been use

enum NetworkError: Error, Equatable {
    case badUrl
    case requestFailed
    case decodingError
}

//class NetworkService {
//    
//    static let shared = NetworkService()
//    private let baseUrl = URL(string: "http://localhost:8080/")
//    
//    private init() {}
//    
//    //Generic function
//    func makeRequest<T: Codable>(to endpoint: String,
//                                 method: String,
//                                 body: Data? = nil,
//                                 completion: @escaping (Result<T, NetworkError>) -> Void) {
//        
//        //Build full URL
//        guard let url = baseUrl?.appendingPathComponent(endpoint) else {
//            completion(.failure(.badUrl))
//            return
//        }
//        
//        print("Make \(method) request to \(url)")
//        
//        //Create URLRequest
//        var request = URLRequest(url: url)
//        request.httpMethod = method
//        request.httpBody = body
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        //Execute URLRequest in a URLSession
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { data, response, error in
//            print("Response: \(String(describing: response))")
//            
//            
//            //Error: Network request
//            guard error == nil else {
//                print("Error in request: \(error!.localizedDescription)")
//                completion(.failure(.requestFailed))
//                return
//            }
//            
//            //Validate HTTP response status code
//            guard let data = data else {
//                completion(.failure(.requestFailed))
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                completion(.failure(.requestFailed))
//                return
//            }
//            
//            print("HTTP Status Code: \(httpResponse.statusCode)")
//            
//            //Decode res.data
//            do {
//                let decodedObject = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(decodedObject))
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }
//        task.resume()//Start network task
//    }
//    
//    // Read
//    func fetch<T: Codable>(_ endpoint: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        makeRequest(to: endpoint, method: "GET", completion: completion)
//    }
//    
//    // Create
//    func create<T: Codable>(_ endpoint: String, object: T, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        do {
//            let body = try JSONEncoder().encode(object)
//            makeRequest(to: endpoint, method: "POST", body: body, completion: completion)
//        } catch {
//            completion(.failure(.decodingError))
//        }
//    }
//
//    // Update
//    func update<T: Codable>(_ endpoint: String, object: T, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        do {
//            let body = try JSONEncoder().encode(object)
//            makeRequest(to: endpoint, method: "PUT", body: body, completion: completion)
//        } catch {
//            completion(.failure(.decodingError))
//        }
//    }
//
//    // Delete
//    func delete(_ endpoint: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//        makeRequest(to: endpoint, method: "DELETE", completion: { (result: Result<Data, NetworkError>) in
//            switch result {
//            case .success:
//                completion(.success(true))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//    }
//}
