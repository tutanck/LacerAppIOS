//
//  ExtendedUIView.swift
//  LacerApp
//
//  Created by Joan Angb on 21/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    
    func addCenteredXConstraint(about : Any, to : Any?){
        addConstraint(NSLayoutConstraint(item: about, attribute: .centerX, relatedBy: .equal, toItem: to, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    
    func addCenteredYConstraint(about : Any, to : Any?){
        addConstraint(NSLayoutConstraint(item: about, attribute: .centerY, relatedBy: .equal, toItem: to, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
