//
//  UtherProfileCollectionViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 26/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherProfileCollectionViewCell: BasicCollectionViewCell {
    
    var context : UtherProfileCollectionViewController?
    
    
    //userProfileImageView
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Inner ratingView
        
        let ratingView: RatingControl = {
            let rating = RatingControl()
            rating.starSize = CGSize(width: 24.0, height: 24.0)
            rating.translatesAutoresizingMaskIntoConstraints = false
            return rating
        }()
        imageView.addSubview(ratingView)
        imageView.addConstraintsWithFormat("H:|-8-[v0]", views: ratingView)
        imageView.addConstraintsWithFormat("V:[v0]-8-|", views: ratingView)
        
        //Inner presenceView
        
        let presenceView: UIImageView = {
            let presence = UIImageView()
            presence.backgroundColor = .red
            presence.contentMode = .scaleAspectFill
            presence.layer.cornerRadius = 12
            presence.layer.masksToBounds = true
            presence.translatesAutoresizingMaskIntoConstraints = false
            return presence
        }()
        imageView.addSubview(presenceView)
        imageView.addConstraintsWithFormat("H:[v0(24)]-8-|", views: presenceView)
        imageView.addConstraintsWithFormat("V:[v0(24)]-8-|", views: presenceView)
        
        //interraction
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    fileprivate func setupUserProfileImageView() {
        FormLabeledEntry.installEntryIn(parent: self,entry: profileImageView)
    }
    
    
    
    //standingRatingControl
    
    let standingRatingControl : RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.isEditable = true
        return ratingControl
    }()
    
    fileprivate func setupStandingRatingControl() {
        addSubview(standingRatingControl)
        addCenteredXConstraint(about: standingRatingControl, to: self)
    }
    
    
    
    //typeContainerView
    
    var typeContainerView : UIView = UIView()
    
    lazy var typeSegmentedControl : UISegmentedControl = {
        let segmentedControl = UISegmentedControl(
            items: ["Particulier", "Entreprise"]
        )
        segmentedControl.selectedSegmentIndex = 0 //TODO
        
        let frame = UIScreen.main.bounds
        segmentedControl.frame = CGRect(
            x : frame.minX + 10,
            y : frame.minY + 50,
            width : frame.width - 20,
            height : frame.height*0.1
        )
        
        segmentedControl.layer.cornerRadius = 5.0  // Don't let background bleed
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        
        //interraction
        segmentedControl.isUserInteractionEnabled = false
        
        return segmentedControl
    }()
    
    fileprivate func setupTypeContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: self,
            entry: FormLabeledEntry.composeEntry(
                containerView: typeContainerView,
                view: typeSegmentedControl,
                text : "JE SUIS UN(E)",
                debug: false),
            debug: false)
    }
    
    
    
    //identityContainerView
    
    var identityContainerView : UIView = UIView()
    
    let usernameTextField : UITextField = {
        let textField = UITextField()
        textField.text = "Joan"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        
        //border
        textField.layer.borderWidth = 0.8;
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textField.backgroundColor = .white
        
        //interraction
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    fileprivate func setupIdentityContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: self,
            entry: FormLabeledEntry.composeEntry(
                containerView: identityContainerView,
                view: usernameTextField,
                text : "NOM D'UTILISATEUR",
                debug: false),
            debug: false)
    }
    
    
    
    //resumeContainerView
    
    var resumeContainerView : UIView = UIView()
    
    let resumeTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = "Sample message Sample message Sample message Sample message Sample message Sample message Sample message Sample message Sample message Sample message Sample message "
        textView.backgroundColor = .white
        
        //border
        textView.layer.borderWidth = 0.8;
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textView.backgroundColor = .white
        
        //interraction
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    fileprivate func setupResumeContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: self,
            entry: FormLabeledEntry.composeEntry(
                containerView: resumeContainerView,
                view: resumeTextView,
                text : "PRÉSENTATION DE MON ACTIVITÉ",
                viewHeight : 226,
                debug: false),
            debug: false)
    }
    
    
    
    //manageActivityKeywordsButton
    
    lazy var manageActivityKeywordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LES MOTS-CLÉS DE MON ACTIVITÉ", for: UIControlState())
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(showActivityKeywords), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupManageActivityKeywordsButton() {
        addSubview(manageActivityKeywordsButton)
        addConstraintsWithFormat("H:|-24-[v0]-24-|", views: manageActivityKeywordsButton)
        addCenteredXConstraint(about: manageActivityKeywordsButton, to: self)
    }
    
    
    override func setupViews() {
        setupUserProfileImageView()
        setupStandingRatingControl()
        setupTypeContainerView()
        setupIdentityContainerView()
        setupResumeContainerView()
        setupManageActivityKeywordsButton()
        
        addConstraintsWithFormat("V:|[v0(200)]-16-[v1]-32-[v2(54)]-16-[v3(54)]-16-[v4(250)]-16-[v5(34)]", views: profileImageView,standingRatingControl,typeContainerView,identityContainerView,resumeContainerView,manageActivityKeywordsButton)
    }
    
    
    
    
    
    
    // MARK: - SEGUE
    
    func showActivityKeywords(){
        if let context = context/*, let uther = uther TODO */ {
            context.performSegue(withIdentifier: "segueFromUtherProfileToUtherActivityKeywords", sender: self)
        }
    }
    
    
    
    
}
