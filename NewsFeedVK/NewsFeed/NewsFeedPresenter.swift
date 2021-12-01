//
//  NewsFeedPresenter.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 11.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellCalcilatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormater: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(feed: let feed):
            
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
            }
            
            
            
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem,
                               profiles: [Profile],
                               groups: [Group] ) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId,
                                      profiles: profiles,
                                      groups: groups)
        
        let photoAttachement = self.photoAttachement(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormater.string(from: date)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttechment: photoAttachement)
        
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachement: photoAttachement,
                                       sizes: sizes)
    }
    
    private func profile(for sourseId: Int,
                         profiles: [Profile],
                         groups: [Group]) -> ProfileRepresenatable {
        let profilesOrGroup: [ProfileRepresenatable] = sourseId >= 0 ? profiles : groups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresenatable = profilesOrGroup.first { (myprofileRepresenatable) -> Bool in
            myprofileRepresenatable.id == normalSourseId
        }
        return profileRepresenatable!
    }
    
    private func photoAttachement(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachement? {
        guard let photo = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photo.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: firstPhoto.srcBIG,
                                                           width: firstPhoto.width,
                                                           height: firstPhoto.height)
    }
    
}
