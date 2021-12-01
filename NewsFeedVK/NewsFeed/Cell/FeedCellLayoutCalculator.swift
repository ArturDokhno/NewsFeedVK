//
//  NewsfeedCellLayoutCalculator.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 01.12.2021.
//

import UIKit

protocol FeedCellCalcilatorProtocol {
    func sizes(postText: String?,
               photoAttechment: FeddCellPhotoAttachementViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelText: CGRect
    var attachmentFram: CGRect
}

final class FeedCellLayoutCalculator: FeedCellCalcilatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width,
                                    UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?,
               photoAttechment: FeddCellPhotoAttachementViewModel?) -> FeedCellSizes {
        return Sizes(postLabelText: CGRect.zero, attachmentFram: CGRect.zero)
    }
    
    
}
