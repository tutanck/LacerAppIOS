//
//  ScrollViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 28/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        return scroll
    }()
    
    let containerView : UIView = {
        let mainView = UIView()
        return mainView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x:0, y:0,width: scrollView.contentSize.width, height :scrollView.contentSize.height)
    }
    

}
