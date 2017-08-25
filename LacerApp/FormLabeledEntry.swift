//
//  FormLabeledEntry.swift
//  LacerApp
//
//  Created by Joan Angb on 25/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class FormLabeledEntry {
    
    static func composeEntry(
        containerView : UIView,
        view : UIView,
        text :  String? = "",
        label : UILabel? = nil,
        labelHeight : CGFloat? = 16,
        viewHeight : CGFloat? = 30,
        leftMargin : CGFloat? = 24,
        rightMargin : CGFloat? = 24,
        debug : Bool? = false
        ) ->UIView{
        
        
        let label: UILabel = label == nil ?  {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 16)
            return label
            }() : label!
        
        
        containerView.addSubview(label)
        containerView.addSubview(view)
        
        containerView.addConstraintsWithFormat("H:|-\(leftMargin!)-[v0]-\(rightMargin!)-|", views: label)
        
        containerView.addConstraintsWithFormat("H:|-\(leftMargin!)-[v0]-\(rightMargin!)-|", views: view)
        
        containerView.addConstraintsWithFormat("V:|[v0(\(labelHeight!))][v1(\(viewHeight!))]|", views: label, view)
        
        if debug! {
            label.backgroundColor = .yellow
            view.backgroundColor = .blue
            containerView.backgroundColor = .lightGray
        }
        return containerView
    }
    
    
    static func installEntryIn(
    parent : UIView,
    entry : UIView,
    debug : Bool? = false
    ) ->UIView{
        parent.addSubview(entry)
        parent.addConstraintsWithFormat("H:|[v0]|", views: entry)
        parent.addCenteredXConstraint(about: entry, to: parent)
        
        if debug! {
            parent.backgroundColor = .green
            entry.backgroundColor = .red
        }
        return entry
    }
}
