//
//  String + Height.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 06.12.2021.
//

import UIKit

extension String {
    func height(widht: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: widht, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
