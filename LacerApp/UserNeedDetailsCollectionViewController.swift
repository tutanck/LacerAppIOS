//
//  UserNeedDetailsCollectionViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 27/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "UserNeedDetailsCollectionViewCell"
    
    let wallpaperColor = UIColor(white : 0.99 , alpha : 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        manageKeyboard()
        
        //TODO
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UserNeedDetailsViewController.keyboardWillShow(_:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UserNeedDetailsViewController.keyboardWillHide(_:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    // MARK: - Tap gesture
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
    //    titleTextField.endEditing(true)
      //  descriptionTextView.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupCollectionView(){
        collectionView?.backgroundColor = wallpaperColor
        collectionView?.register(UserNeedDetailsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserNeedDetailsCollectionViewCell
        
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
    
}
