//
//  FrameEstimator.swift
//  LacerApp
//
//  Created by Joan Angb on 24/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class FrameEstimator {
    
    static func estimateTextFrame(
        text : String,
        textFontSize : CGFloat,
        desiredWidth : CGFloat, /*width we want for the messageTextView rect*/
        arbitraryHeight : CGFloat? = 1000,/*arbitrary height to have enougth space for the text in the rect (for making estimations of the real height needed)*/
        context : NSStringDrawingContext? = nil
        ) -> CGRect {
        
        return NSString(
            string: text
            ).boundingRect(
                with: CGSize(
                    width: desiredWidth,
                    height: arbitraryHeight!
                ),
                options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: textFontSize)],
                context: context
        )
        
    }
    
}
