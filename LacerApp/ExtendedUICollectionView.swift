//
//  ExtendedUICollectionView.swift
//  LacerApp
//
//  Created by Joan Angb on 24/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func scrollToLastItem(atIts:UICollectionViewScrollPosition, animated: Bool) {
        self.layoutIfNeeded()
        
        for sectionIndex in (0..<self.numberOfSections).reversed() {
            if self.numberOfItems(inSection: sectionIndex) > 0 {
                self.scrollToItem(at: IndexPath(item: self.numberOfItems(inSection: sectionIndex)-1, section: sectionIndex), at: atIts, animated: animated)
                break
            }
        }
    }
    
}
