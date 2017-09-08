//
//  UserProfileViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 28/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserProfileViewController: ScrollViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
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
        FormLabeledEntry.installEntryIn(parent: containerView,entry: profileImageView)
    }
    
    
    
    //standingRatingControl
    
    let standingRatingControl : RatingControl = {
        let ratingControl = RatingControl()
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
        textField.placeholder = " Entrez votre nom d'utilisateur"
        textField.text=""
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
        textView.text = ""
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
        button.setTitle("GÉRER LES MOTS-CLÉS DE MON ACTIVITÉ", for: UIControlState())
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
    
    
    
    
    lazy var disconnectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DÉCONNEXION", for: UIControlState())
        let backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        let titleColor = UIColor(white: 0.99, alpha: 1)
        button.setTitleColor(titleColor, for: UIControlState())
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(disconnect), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    fileprivate func setupDisconnectButton() {
        containerView.addSubview(disconnectButton)
        containerView.addConstraintsWithFormat("H:|-24-[v0]-24-|", views: disconnectButton)
        containerView.addCenteredXConstraint(about: disconnectButton, to: containerView)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width:view.bounds.size.width,height: 832)
        containerView.backgroundColor = UIColor(white: 0.99, alpha: 1)
        
        setupUserProfileImageView()
        setupStandingRatingControl()
        setupTypeContainerView()
        setupIdentityContainerView()
        setupResumeContainerView()
        setupManageActivityKeywordsButton()
        setupDisconnectButton()
        
        containerView.addConstraintsWithFormat("V:|[v0(200)]-16-[v1]-32-[v2(54)]-16-[v3(54)]-16-[v4(250)]-16-[v5(34)]-32-[v6(34)]", views: profileImageView,standingRatingControl,typeContainerView,identityContainerView,resumeContainerView,manageActivityKeywordsButton,disconnectButton)
        
        
        //user status button settings
        userAvailabilitySwitchableControl.context = self
        
        //ui inputs management initial settings
        disableRightBarButtonItem()
        
        setInputsDelegate()
        manageKeyboard()
        setTapToDissmissKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //Global tap gesture
    fileprivate func setTapToDissmissKeyboard(){
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        singleTap.numberOfTapsRequired = 1;
        containerView.addGestureRecognizer(singleTap)
    }
    
    
    func disableRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = false
        }
    }
    
    func enableRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = true
        }
    }
    
    
    
    
    
    // MARK: - Actions
    
    func disconnect(){
        Alert.displayMessage(
            context: self,
            headerTitle : "Déconnexion",
            message: "Vous allez être déconnecté.",
            confirmAction : {action in print("déconnexion")},
            cancellable : true
        )
    }
    
    func showActivityKeywords(){
        performSegue(withIdentifier: "segueFromUserProfileToUserKeywords", sender: self)
    }
    
    
    func hideKeyboard(_ sender: AnyObject) { usernameTextField.endEditing(true); resumeTextView.endEditing(true) }
    
    
    func typeSegmentedControlChanged(_ sender: UISegmentedControl) { enableRightBarButtonItem() }
    
    
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
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            Alert.displayMessage(context: self, message: "Impossible de charger l'image.")
            return
        }
        
        // Set photoImageView to display the selected image.
        profileImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        enableRightBarButtonItem()
    }
    
    
    
    
    // MARK: - TextInputs handlers
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder(); return true }
    
    func textFieldDidEndEditing(_ textField: UITextField) { enableRightBarButtonItem() }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool { textView.resignFirstResponder() ;return true }
    
    func textViewDidEndEditing(_ textView: UITextView) { enableRightBarButtonItem() }
    
    private func setInputsDelegate(){ usernameTextField.delegate = self; resumeTextView.delegate = self }
    
    
    
    fileprivate func manageKeyboard() {
        KeyboardNotification.addObserverOnKeyboardWillShow(observer : self, selector: #selector(keyboardWillShow))
        KeyboardNotification.addObserverOnKeyboardWillHide(observer : self, selector: #selector(keyboardWillHide))
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if !isKeyboardVisible{
            KeyboardNotification.adjustInsetForKeyboardShow(true, notification: notification, scrollView: scrollView)
            isKeyboardVisible = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        KeyboardNotification.adjustInsetForKeyboardShow(false, notification: notification, scrollView: scrollView)
        isKeyboardVisible = false
    }
    
    private var isKeyboardVisible = false
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    //Mark : unwinds
    
    @IBAction func returnFromUserKeywords(segue:UIStoryboardSegue) {}
    
    
    
    
    // MARK: - Save button
    
    @IBAction func saveUserProfile(_ sender: UIBarButtonItem) {
        UserProfileSnap(
            type: typeSegmentedControl.selectedSegmentIndex,
            username: usernameTextField.text!,
            resume: resumeTextView.text,
            ack: userProfileDidSave)
        
        disableRightBarButtonItem()
    }
    
    
    
    
    
    // MARK: - private methods
    
    private func userProfileDidSave (dataArray : [Any])->(){
        enableRightBarButtonItem()
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            Alert.displayMessage(context: self, headerTitle: "Votre profil a été mis à jour", confirmable : false)
            disableRightBarButtonItem()
        })
    }
    
    
    
    
    
    private func loadData(){
        UserProfilesColl.findUserProfile(ack: dataDidLoad)
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {
                populateUI(data : res)
            }
        })
    }
    
    private func populateUI(data : JSONArray){
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
