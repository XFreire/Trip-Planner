//
//  WebService.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

public enum WebServiceError: Error {
    case badStatus(Int, Data)
}

final class WebService {
    private var session = URLSession(configuration: .default)
    private let baseURL = URL(string: "https://raw.githubusercontent.com/punty/TUI-test/master")!
    private let decoder = JSONDecoder()
    
    
    func load<T: Decodable>(_ type: T.Type, from endpoint: Endpoint, then completion: @escaping (T) -> Void, catchError: @escaping (Error) -> Void) {
        let decoder = self.decoder
        let request = endpoint.request(with: baseURL)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                catchError(error)
                return
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    fatalError("Unsupported protocol")
                }
                
                if 200 ..< 300 ~= httpResponse.statusCode {
                    if let data = data {
                        if let object = try? decoder.decode(T.self, from: data) {
                            completion(object)
                            return
                        }
                    }
                    
                } else {
                    catchError(WebServiceError.badStatus(httpResponse.statusCode, data ?? Data()))
                }
            }
        }
        task.resume()
    }
}
