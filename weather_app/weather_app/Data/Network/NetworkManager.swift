//
//  NetworkManager.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import Foundation

struct NetworkManager {

    static func request<T: Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {

        guard let url = endPoint.url else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }

            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            if T.self == Data.self {
                completion(.success(data as! T))
            } else {
                do {
                    let decoder = JSONDecoder()

                    let value = try decoder.decode(T.self, from: data)

                    completion(.success(value))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }

        }.resume()
    }

}
