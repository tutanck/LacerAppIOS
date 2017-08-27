//
//  UserNeedDetailsCollectionViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 27/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedDetailsCollectionViewCell: BasicCollectionViewCell, UITextFieldDelegate, UITextViewDelegate{
    
    var context : UserNeedDetailsCollectionViewController?
    
    
    
    // MARK: - Inner Users Results TableView
    
    var matchingProfilesTableView: UITableView = {
        let tableView = UITableView()
                tableView.register(MatchingProfilesTableViewCell.self, forCellReuseIdentifier: "MatchingProfilesTableViewCell")
            return tableView
        }()
        
        
        var matchingProfilesTableViewDelegate : MatchingProfilesTableViewDelegate!
        
        let searchController = UISearchController(searchResultsController: nil)
        
        
        
        
        
        // MARK: - System Events
        
        override func setupViews() {
            
            matchingProfilesTableViewDelegate = MatchingProfilesTableViewDelegate()
            matchingProfilesTableView.delegate = matchingProfilesTableViewDelegate
            matchingProfilesTableView.dataSource = matchingProfilesTableViewDelegate
            matchingProfilesTableViewDelegate.tableView = matchingProfilesTableView
            
            //SearchController parameters
            searchController.searchResultsUpdater = matchingProfilesTableViewDelegate
            
            
            searchController.dimsBackgroundDuringPresentation = false
            context?.definesPresentationContext = true
            matchingProfilesTableView.tableHeaderView = searchController.searchBar
            
            //SearchController's search bar parameters
            searchController.searchBar.scopeButtonTitles = ["Particuliers","Entreprises"]
            searchController.searchBar.delegate = matchingProfilesTableViewDelegate
            
            
            
            FormLabeledEntry.installEntryIn(parent: self,entry: matchingProfilesTableView)
            
            addConstraintsWithFormat("V:|[v0(380)]", views: matchingProfilesTableView)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*//typeContainerView
         
         var typeContainerView : UIView = UIView()
         
         lazy var typeSegmentedControl : UISegmentedControl = {
         let segmentedControl = UISegmentedControl(
         items: ["Particulier", "Entreprise"]
         )
         segmentedControl.selectedSegmentIndex = 0
         
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
         
         segmentedControl.addTarget(self, action: #selector(typeSegmentedControlChanged), for: .valueChanged)
         
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
         textField.placeholder = " Entrez votre nom d'utilisateur"
         textField.font = UIFont.systemFont(ofSize: 16)
         textField.textAlignment = .left
         //border
         textField.layer.borderWidth = 0.8;
         textField.layer.cornerRadius = 5
         textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
         textField.backgroundColor = .white
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
         button.setTitle("GÉRER LES MOTS-CLÉS DE MON ACTIVITÉ", for: UIControlState())
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
         
         
         
         //Global tap gesture
         fileprivate func setTapToDissmissKeyboard(){
         let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
         singleTap.numberOfTapsRequired = 1;
         addGestureRecognizer(singleTap)
         }
         
         
         
         
         
         override func setupViews() {
         setupTypeContainerView()
         setupIdentityContainerView()
         setupResumeContainerView()
         setupManageActivityKeywordsButton()
         
         addConstraintsWithFormat("V:|[v0(200)]-16-[v1]-32-[v2(54)]-16-[v3(54)]", views:typeContainerView,identityContainerView,resumeContainerView,manageActivityKeywordsButton)
         
         setInputsDelegate()
         setTapToDissmissKeyboard()
         }
         
         */
        
        
        
        
        
        // MARK: - Actions
        
        func showActivityKeywords(){
            if let context = context/*, let user = user TODO */ {
                context.performSegue(withIdentifier: "segueFromUserProfileToUserKeywords", sender: self)
            }
        }
        
        
        //func hideKeyboard(_ sender: AnyObject) { usernameTextField.endEditing(true); resumeTextView.endEditing(true) }
        
        
        func typeSegmentedControlChanged(_ sender: UISegmentedControl) { context?.enableRightBarButtonItem() }
        
        
        
        // MARK: - TextInputs handlers
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder(); return true }
        
        func textFieldDidEndEditing(_ textField: UITextField) { context?.enableRightBarButtonItem() }
        
        func textViewShouldReturn(_ textView: UITextView) -> Bool { textView.resignFirstResponder() ;return true }
        
        func textViewDidEndEditing(_ textView: UITextView) { context?.enableRightBarButtonItem() }
        
        //private func setInputsDelegate(){ usernameTextField.delegate = self; resumeTextView.delegate = self }
        
}
