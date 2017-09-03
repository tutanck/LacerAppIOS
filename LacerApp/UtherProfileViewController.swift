//
//  UtherProfileViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 28/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherProfileViewController: ScrollViewController {
    
    
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
        FormLabeledEntry.installEntryIn(parent: containerView,entry: profileImageView)
    }
    
    
    
    //standingRatingControl
    
    let standingRatingControl : RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.isEditable = true
        return ratingControl
    }()
    
    fileprivate func setupStandingRatingControl() {
        containerView.addSubview(standingRatingControl)
        containerView.addCenteredXConstraint(about: standingRatingControl, to: containerView)
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
            parent: containerView,
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
            parent: containerView,
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
            parent: containerView,
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
        containerView.addSubview(manageActivityKeywordsButton)
        containerView.addConstraintsWithFormat("H:|-24-[v0]-24-|", views: manageActivityKeywordsButton)
        containerView.addCenteredXConstraint(about: manageActivityKeywordsButton, to: containerView)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.contentSize = CGSize(width:view.bounds.size.width,height: 800)
        containerView.backgroundColor = UIColor(white: 0.99, alpha: 1)
        
        setupUserProfileImageView()
        setupStandingRatingControl()
        setupTypeContainerView()
        setupIdentityContainerView()
        setupResumeContainerView()
        setupManageActivityKeywordsButton()
        
        containerView.addConstraintsWithFormat("V:|[v0(200)]-16-[v1]-32-[v2(54)]-16-[v3(54)]-16-[v4(250)]-16-[v5(34)]", views: profileImageView,standingRatingControl,typeContainerView,identityContainerView,resumeContainerView,manageActivityKeywordsButton)
        
        
        
        _id = "59ab7691217e0e0294d2e1c9"
    }
    
    
    
    
    
    // MARK: - SEGUE
    
    func showActivityKeywords(){
        performSegue(withIdentifier: "segueFromUtherProfileToUtherActivityKeywords", sender: self)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    // MARK: - IO
    let regina = IO.r
    
    var _id : String?=nil {
        didSet {
            loadData()
        }
    }
    
    
    // MARK: - private methods
    
    private func loadData(){
        if let userid = self._id {
            regina.find(coll: DB.user_profiles, query: ["_id" : userid], ack: dataDidLoad)
        }
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONObjects {
                populateUI(data : res)
            }
        })
    }
    
    private func populateUI(data : JSONObjects){
        if data.count == 1 {
            let profile = data[0]
            self.typeSegmentedControl.selectedSegmentIndex = profile["type"] as? Int ?? 0
            self.usernameTextField.text = profile["username"] as? String ?? ""
            self.resumeTextView.text = profile["resume"] as? String ?? ""
        }else{
            Waiter.isConfused(self)
        }
    }

    
}
