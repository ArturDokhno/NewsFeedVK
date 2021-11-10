//
//  FeedViewController.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 09.11.2021.
//


import UIKit

class FeedViewController: UIViewController {
    
    private var networkService: Netroking = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        let parapms = ["filters": "post, photo"]
        networkService.request(path: API.newsFeed, params: parapms) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json: \(json)")
        }
    }
    
}
