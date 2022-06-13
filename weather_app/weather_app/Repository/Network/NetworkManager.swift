//
//  NetworkManager.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import Foundation


class NetworkManager {

    func loadWeather(city: String, completion: @escaping (Result<TestDTO, NetworkError>) -> Void) {

        let url = EndPoint.weather(for: city).url

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

            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(TestDTO.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(.decodingError(error)))
            }

        }.resume()
    }

}
