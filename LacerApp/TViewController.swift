//
//  TViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 28/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class TViewController: UIViewController , UIScrollViewDelegate {
    
    
    var scrollView: UIScrollView!
    var containerView : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonOne = UIView() //UIButton()
        
        buttonOne.frame = CGRect(x : 10, y: 50, width: 50, height: 50)
        
        
        
        
        buttonOne.backgroundColor = .green
        //buttonOne.setTitle("test", for: UIControlState.normal)
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width:view.bounds.size.width,height: 1000)
        
        containerView = UIView()
        
        
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        
        containerView.addSubview(buttonOne)
        containerView.addConstraintsWithFormat("H:|[v0]|", views: buttonOne)
        containerView.addConstraintsWithFormat("V:|[v0(56)]", views: buttonOne)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x:0, y:0,width: scrollView.contentSize.width, height :scrollView.contentSize.height)
    }
}
