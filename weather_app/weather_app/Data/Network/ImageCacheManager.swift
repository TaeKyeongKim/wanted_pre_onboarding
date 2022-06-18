//
//  ImanageManager.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/18.
//

import Foundation

final class ImageCacheManager {

    static let shared = ImageCacheManager()

    private init() {}

    private var cache = NSCache<NSString, NSData>()

    func fetchIconImage(icon: String?, completion: @escaping (Data) -> Void) {

        guard let icon = icon else {return}

        if let imageData = cache.object(forKey: icon as NSString) {
            completion(imageData as Data)
            return
        }

        let endPoint = EndPoint(urlInformation: .image(name: icon))

        NetworkManager.request(endPoint: endPoint) { [weak self] (response: Result<Data, NetworkError>) in
            switch response {
            case .success(let data):
                self?.cache.setObject(data as NSData, forKey: icon as NSString)
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
