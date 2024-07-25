//
//  ApiNetwork.swift
//  ReduxLearning
//
//  Created by Gaurav Sharma on 23/07/24.
//

import Foundation
import Combine

func getProducts() ->  AnyPublisher<[Products]?, Error> {
    let url = URL(string: "https://dummyjson.com/products")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { output in
            
            guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            return output.data
            
        }
    
        .decode(type: ProductsModel.self, decoder:JSONDecoder())
        .map {$0.products ?? []}
        .eraseToAnyPublisher()
    
}
