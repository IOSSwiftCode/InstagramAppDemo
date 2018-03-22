//
//  UIEXtension.swift
//  InstagramApp
//
//  Created by chanthem on 3/21/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func cornerRadius() {
        self.layer.cornerRadius = self.bounds.height/2
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
}

extension UIScrollView {
    
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
    
}
