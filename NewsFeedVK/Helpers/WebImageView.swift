//
//  WebImageView.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 25.11.2021.
//

import UIKit

class  WebImageView: UIImageView {
    
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        if let cachedResponce = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponce.data)
            print("from cache")
            return
        }
        print("from internet")
        let dataTask = URLSession.shared.dataTask(with: url) {
            [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
    
}
