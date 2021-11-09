//
//  FeedViewController.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 09.11.2021.
//


import UIKit

class FeedViewController: UIViewController {
    
    private var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        networkService.getFeed()
    }
    
}
