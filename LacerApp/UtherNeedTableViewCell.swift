//
//  NeedTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 22/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherNeedTableViewCell: BasicTableViewCell {
    
    var context : UIViewController?
    
    var need : UtherNeed?
    
    //userProfileImageView
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "userPhoto")
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToClientProfile))
        singleTap.numberOfTapsRequired = 1;
        imageView.addGestureRecognizer(singleTap)
        return imageView
    }()
    
    fileprivate func setupUserProfileImageView() {
        addSubview(userProfileImageView)
        addConstraintsWithFormat("H:|-6-[v0(68)]", views: userProfileImageView)
        addConstraintsWithFormat("V:|-6-[v0(68)]", views: userProfileImageView)
    }
    
    
    
    
    //userProfileInfosContainerView
    
    var userProfileInfosContainerView : UIView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ChauffeurChauffeurChauffeurChauffeurChauffeurChauffeur"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "MarkZuckerbergMarkZuckerbergMarkZuckerbergMarkZuckerberg"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "ParticulierEntreprise"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    fileprivate func setupUserProfileInfosContainerView() {
        
        let containerView = userProfileInfosContainerView
        
        containerView.backgroundColor = self.backgroundColor //.blue //debug
        addSubview(containerView)
        addConstraintsWithFormat("H:|-80-[v0]-6-|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        addCenteredYConstraint(about: containerView, to: self.userProfileImageView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(typeLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0]|", views: titleLabel)
        
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: titleLabel, usernameLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0][v1(75)]-8-|", views: usernameLabel,typeLabel)
        
        containerView.addConstraintsWithFormat("V:[v0(24)]|", views: typeLabel)
        
    }
    
    
    
    //detailsContainerView
    
    var detailsContainerView : UIView = UIView()
    
    lazy var scrollViewContainer: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "YourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyours"
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        //textView.isSelectable = false
        textView.backgroundColor = self.backgroundColor
        return textView
    }()
    
    
    fileprivate func setupDetailsContainerView() {
        
        let containerView = detailsContainerView
        
        containerView.backgroundColor = self.backgroundColor //.green //debug
        addSubview(containerView)
        addConstraintsWithFormat("H:|-6-[v0]-6-|", views: containerView)
        addCenteredXConstraint(about: containerView, to: self)
        
        //scrollViewContainer.backgroundColor = .yellow //debug
        containerView.addSubview(scrollViewContainer)
        containerView.addSubview(dividerLineView)
        //descriptionTextView.backgroundColor = .red //debug
        containerView.addSubview(descriptionTextView)
        
        containerView.addConstraintsWithFormat("H:|-80-[v0]|", views: scrollViewContainer)
        containerView.addConstraintsWithFormat("H:|-80-[v0]|", views: dividerLineView)
        
        containerView.addConstraintsWithFormat("V:|[v0(24)]-2-[v1(1)]", views: scrollViewContainer,dividerLineView)
        
        containerView.addConstraintsWithFormat("H:|-2-[v0]|", views: descriptionTextView)
        
        containerView.addConstraintsWithFormat("V:[v0]-2-[v1]|", views: dividerLineView,descriptionTextView)
        
    }
    
    
    
    //menuContainerView
    
    //where //when //how many //date de publication -> modal affichage | btn  : forward to friend, go to messenger
    var menuContainerView : UIView = UIView()
    
    let utherNeedMenu : UtherNeedMenu = {
        let menu = UtherNeedMenu()
        menu.spacing = 8
        return menu
    }()
    
    
    fileprivate func setupMenuContainerView(){
        
        let containerView = menuContainerView
        
        containerView.backgroundColor = self.backgroundColor  //.white //debug
        
        addSubview(containerView)
        addConstraintsWithFormat("H:|-6-[v0]-6-|", views: containerView)
        addCenteredXConstraint(about: containerView, to: self)
        
        containerView.addSubview(utherNeedMenu)
        containerView.addCenteredXConstraint(about: utherNeedMenu, to: containerView)
        containerView.addConstraintsWithFormat("V:|[v0]|", views: utherNeedMenu)
    }
    
    
    
    override func setupViews() {
        backgroundColor = UIColor(white: 0.99, alpha: 1)
        
        setupUserProfileImageView()
        setupUserProfileInfosContainerView()
        setupDetailsContainerView()
        setupMenuContainerView()
        
        addConstraintsWithFormat("V:[v0(180)]-2-[v1(40)]-4-|", views: detailsContainerView,menuContainerView)
    }
    
    
    
    func goToClientProfile(recognizer: UIGestureRecognizer) {
        if let context = context, let need = need {
            context.performSegue(withIdentifier: "segueFromMarketPlaceToUtherProfile", sender: self)
        }
    }
    
}
