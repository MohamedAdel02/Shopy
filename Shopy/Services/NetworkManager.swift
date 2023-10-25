//
//  NetworkManager.swift
//  Shopy
//
//  Created by Mohamed Adel on 19/10/2023.
//

import Foundation
import Combine


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func data<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                
                guard let urlResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(urlResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
            
        }
    }
    
    
}
