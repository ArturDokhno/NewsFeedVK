//
//  NewsFeedModels.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 11.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getFeed
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewsFeed
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewsfeed
            }
        }
    }
    
}