//
//  AuthViewController.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 09.11.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
    }
    
    @IBAction func singinTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}
