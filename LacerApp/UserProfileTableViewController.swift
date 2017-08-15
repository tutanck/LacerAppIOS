//
//  UserProfileTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserProfileTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - ImageView
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard : This code ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly
        usernameTextField.resignFirstResponder()
        interestTextView.resignFirstResponder()
        
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
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        showRightBarButtonItem()
    }
    
    
    // MARK: - RatingControl
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    // MARK: - SegmentedControl
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBAction func typeSegmentedControlChanged(_ sender: UISegmentedControl) { showRightBarButtonItem() }
    
    
    // MARK: - TextField
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()         // Hide the keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { showRightBarButtonItem() }
    
    
    // MARK: - TextView
    
    @IBOutlet weak var interestTextView: UITextView!
    
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()         // Hide the keyboard
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { showRightBarButtonItem() }
    
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
    // MARK: - Actions

    
    // MARK: - Tap gesture
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        usernameTextField.endEditing(true)
        interestTextView.endEditing(true)
    }
    
    
    // MARK: - Save button
    
    @IBAction func saveUserProfile(_ sender: UIBarButtonItem) {
        ref?.setValue([
            Fire.userTypeKey : typeSegmentedControl.selectedSegmentIndex,
            Fire.userNameKey : usernameTextField.text,
            Fire.userDescriptionKey : interestTextView.text
            ])
        hideRightBarButtonItem()
    }
    
    //MARK: Firef
    
    var ref : DatabaseReference? = nil{
        didSet {
            loadFireData()
        }
    }
    
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //user status button settings
        userAvailabilitySwitchableControl.context = self
        
        //ui inputs management initial settings
        begin()
        
        
        //firef settings
        if let userID = Auth.auth().currentUser?.uid{
            let userRef = Fire.usersRef.child(userID)
            userAvailabilitySwitchableControl.ref = userRef.child(Fire.userStatusKey)
            self.ref = userRef.child(Fire.userProfileKey)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
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
    
    
    
    
    // MARK: - private methods
    
    private func loadFireData(){
        if let ref = self.ref {
            ref.observeSingleEvent(of:.value, with: { snapshot in
                if snapshot.exists(){
                    //populate ui
                    let value = snapshot.value as? NSDictionary
                    self.typeSegmentedControl.selectedSegmentIndex = value?[Fire.userTypeKey] as? Int ?? 0
                    self.usernameTextField.text = value?[Fire.userNameKey] as? String ?? ""
                    self.interestTextView.text = value?[Fire.userDescriptionKey] as? String ?? ""
                }
            })
        }
    }
    
    private func begin(){
        hideRightBarButtonItem()
        
        usernameTextField.delegate = self
        interestTextView.delegate = self
    }
    
    private func hideRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = false
        }
    }
    
    private func showRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = true
        }
    }
    
    
    
}
