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
    var bottonViewFrame: CGRect
    var totalHeight: CGFloat
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0,
                                         left: 8,
                                         bottom: 12,
                                         right: 8)
    static let topViewHeight: CGFloat =  36
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8,
                                              left: 8,
                                              bottom: 8,
                                              right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottonViewHeight: CGFloat = 44
}

final class FeedCellLayoutCalculator: FeedCellCalcilatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width,
                                    UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?,
               photoAttechment: FeddCellPhotoAttachementViewModel?) -> FeedCellSizes {
        let cardViewWidht = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: - Работа с postLabelFrame
        
        var postLabelFrame = CGRect(
            origin: CGPoint(x: Constants.postLabelInsets.left,
                            y: Constants.postLabelInsets.top),
            size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidht - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(widht: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: - Работа с attachmentFram
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFram = CGRect(
            origin: CGPoint(x: 0,
                            y: attachmentTop),
            size: CGSize.zero)
        
        if let attachment = photoAttechment {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            attachmentFram.size = CGSize(width: cardViewWidht, height: cardViewWidht * ratio)
        }
        
        // MARK: - Работа с bottonViewFrame
        
        let bottonViewTop = max(postLabelFrame.maxY, attachmentFram.maxY)
        
        let bottonViewFrame = CGRect(
            origin: CGPoint(x: 0,
                            y: bottonViewTop),
            size: CGSize(width: cardViewWidht,
                         height: Constants.bottonViewHeight))
        
        // MARK: - Работа с totalHeight
        
        let totalHeight = bottonViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelText: postLabelFrame,
                     attachmentFram: attachmentFram,
                     bottonViewFrame: bottonViewFrame,
                     totalHeight: totalHeight)
    }
    
    
}
