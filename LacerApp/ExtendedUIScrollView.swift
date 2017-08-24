//
//  ExtendedUIScrollView.swift
//  LacerApp
//
//  Created by Joan Angb on 24/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func setText(
        text : String,
        fontSize : CGFloat? = 16,
        textColor : UIColor? = .darkGray
        ){
        let estimatedFrame = FrameEstimator.estimateTextFrame(text: text, textFontSize: fontSize!, desiredWidth: 9999, arbitraryHeight: 9999)
        
        let frame = CGRect (x : 0, y : 0, width : estimatedFrame.width+16, height : estimatedFrame.height+16)
        
        let textView = UITextView(frame: frame)
        
        textView.isEditable = false
        textView.isScrollEnabled = false//let textView becomes unscrollable
        textView.text = text
        textView.textColor = textColor
        
        contentSize = CGSize(width : estimatedFrame.width, height : estimatedFrame.height)
        addSubview(textView)
        
    }
    
}
