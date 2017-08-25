//
//  UserProfileCollectionViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 25/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserProfileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "UserProfileCollectionViewCell"
    
    var isComponentModelReady = false
    
    let wallpaperColor = UIColor(white : 0.99 , alpha : 1)
    
    var user : User? {
        didSet {
            isComponentModelReady = true
        }
    }
    
    
    var bottomConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupComponentView()
        manageKeyboard()
    }
    
    
    fileprivate func setupCollectionView(){
        collectionView?.backgroundColor = wallpaperColor
        collectionView?.register(UserProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupComponentView() {
    }
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfileCollectionViewCell
        
        cell.backgroundColor  = wallpaperColor
        
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
    
    
    
    
    
    fileprivate func manageKeyboard() {
        KeyboardNotification.keyboardWillShow(observer : self, selector: #selector(handleKeyboardNotification))
        KeyboardNotification.keyboardWillHide(observer : self, selector: #selector(handleKeyboardNotification))
    }
    
    func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                if isKeyboardShowing {
                    self.collectionView?.scrollToLastItem(atIts: .bottom, animated: true)
                }
            })
        }
    }
    
}
