//
//  UserProfileCollectionViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 25/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserProfileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "UserProfileCollectionViewCell"
    
    let wallpaperColor = UIColor(white : 0.99 , alpha : 1)
    
    var user : User? {
        didSet {
            isComponentModelReady = true
        }
    }
    var isComponentModelReady = false
    
    
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
    // MARK: - Save button
    
    /*@IBAction func saveUserProfile(_ sender: UIBarButtonItem) {
        ref?.setValue([
            Fire.userTypeKey : typeSegmentedControl.selectedSegmentIndex,
            Fire.userNameKey : usernameTextField.text,
            Fire.userDescriptionKey : interestTextView.text
            ])
        disableRightBarButtonItem()
    }*/
    
    //MARK: Firef
    
    var ref : DatabaseReference? = nil{
        didSet {
           // loadFireData()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        manageKeyboard()
        
        
        //user status button settings
        userAvailabilitySwitchableControl.context = self
        
        //ui inputs management initial settings
        disableRightBarButtonItem()
        
        
        //firef settings
        if let userID = Auth.auth().currentUser?.uid{
            let userRef = Fire.usersRef.child(userID)
            userAvailabilitySwitchableControl.ref = userRef.child(Fire.userStatusKey)
            self.ref = userRef.child(Fire.userProfileKey)
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    fileprivate func setupCollectionView(){
        collectionView?.backgroundColor = wallpaperColor
        collectionView?.register(UserProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfileCollectionViewCell
        
        cell.context = self
        cell.backgroundColor = wallpaperColor
        
        cell.context = self
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 200/*extra height*/)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
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

    
    
    fileprivate func manageKeyboard() {
        KeyboardNotification.keyboardWillShow(observer : self, selector: #selector(handleKeyboardNotification))
        KeyboardNotification.keyboardWillHide(observer : self, selector: #selector(handleKeyboardNotification))
    }
    
    
    /**
    * NE SEMBLE PAS MARCHER : TODO FAIRE MARCHEER PUIS GENERISER */
    func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            if let keyboardFrame = keyboardFrame {
                let keyboardHeight = (keyboardFrame.height) * (isKeyboardShowing ? 1 : -1)
              
                self.collectionView?.contentInset.bottom += (isKeyboardShowing ? 10 : -10)
                self.collectionView?.scrollIndicatorInsets.bottom += keyboardHeight
                
                UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                    
                }, completion: nil)
            }
        }
    }
    
    
    
    //Mark : unwinds
    
    @IBAction func returnFromUserKeywords(segue:UIStoryboardSegue) {}
    
    
    // MARK: - private methods
    
    /*private func loadFireData(){
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
    }*/

    
}
