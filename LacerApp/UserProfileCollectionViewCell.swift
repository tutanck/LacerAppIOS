//
//  UserProfileCollectionViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 25/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserProfileCollectionViewCell: BasicCollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    var context : UserProfileCollectionViewController?
    
    
    //userProfileImageView
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageFromPhotoLibrary))
        singleTap.numberOfTapsRequired = 1;
        imageView.addGestureRecognizer(singleTap)
        return imageView
    }()
    
    fileprivate func setupUserProfileImageView() {
        FormLabeledEntry.installEntryIn(parent: self,entry: profileImageView)
    }
    
    
    
    //standingRatingControl
    
    let standingRatingControl : RatingControl = {
        let ratingControl = RatingControl()
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
    
    
    
    
    
    override func setupViews() {
        setupUserProfileImageView()
        setupStandingRatingControl()
        setupTypeContainerView()
        setupIdentityContainerView()
        setupResumeContainerView()
        setupManageActivityKeywordsButton()
        
        addConstraintsWithFormat("V:|[v0(200)]-16-[v1]-32-[v2(54)]-16-[v3(54)]-16-[v4(250)]-16-[v5(34)]", views: profileImageView,standingRatingControl,typeContainerView,identityContainerView,resumeContainerView,manageActivityKeywordsButton)
        
        setInputsDelegate()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard : This code ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly
        usernameTextField.resignFirstResponder()
        resumeTextView.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        context?.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        context?.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            //fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            if let context = context {
                Alert.displayMessage(context: context, message: "Impossible de charger l'image.")
            }
            return
        }
        
        // Set photoImageView to display the selected image.
        profileImageView.image = selectedImage
        
        // Dismiss the picker.
        context?.dismiss(animated: true, completion: nil)
        
        context?.enableRightBarButtonItem()
    }
    
    
    
    func showActivityKeywords(){
        print("showActivityKeywords")
        if let context = context/*, let user = user*/ {
            context.performSegue(withIdentifier: "segueFromUserProfileToUserKeywords", sender: self)
        }
    }
    
    
    func typeSegmentedControlChanged(_ sender: UISegmentedControl) { context?.enableRightBarButtonItem() }
    
    // MARK: - Tap gesture : TODO
    
    func hideKeyboard(_ sender: AnyObject) { usernameTextField.endEditing(true); resumeTextView.endEditing(true) }
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder(); return true }
    
    func textFieldDidEndEditing(_ textField: UITextField) { context?.enableRightBarButtonItem() }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool { textView.resignFirstResponder() ;return true }
    
    func textViewDidEndEditing(_ textView: UITextView) { context?.enableRightBarButtonItem() }
    
    private func setInputsDelegate(){ usernameTextField.delegate = self; resumeTextView.delegate = self }
    
}
