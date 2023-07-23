//
//  Apis.swift
//  PlumInterview
//
//  Created by kashee on 22/07/23.
//

import Foundation


final class Apis: ApiProtocol {
    
    static let shared = Apis()
    private init() {}
    
    func getData<T>(url: String, completion: @escaping (Result<T, PlumError>) -> ()) where T : Decodable {
        
        guard let urlStr = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: urlStr) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                 let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
               }
            } catch (let err) {
                print("Some thing went wrong", err)
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
               }

            }
        }.resume()
        
//        AF.request(urlStr, method: .get, encoding: JSONEncoding.default)
//                .response { response in
//                    guard let data = response.data else { return }
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
//                         let result = try decoder.decode(T.self, from: data)
//                        DispatchQueue.main.async {
//                            completion(.success(result))
//                       }
//                    } catch (let err) {
//                        print("Some thing went wrong", err)
//                        DispatchQueue.main.async {
//                            completion(.failure(.apiError))
//                       }
//
//                    }
//            }
        
    }
    
  
  
    
    
}
