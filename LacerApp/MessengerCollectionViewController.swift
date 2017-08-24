//
//  MessengerCollectionViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 23/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class MessengerCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "MessageCollectionViewCell"
    
    var interlocutor : User? {
        didSet {
            navigationItem.title = interlocutor?.name
            
            //messages = messages.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    
    var messages: [Message] = [
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Yes, totally looking to buy an iPhone 7.", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla", author : nil)
    ]
    
    
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ecrire un message..."
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Envoyer", for: UIControlState())
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    var bottomConstraint: NSLayoutConstraint?

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupCollectionView()
        setupInputComponents()
    }
    
    
    fileprivate func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.scrollToLastItem(atIts: .bottom, animated: false)
    }
    
    
    fileprivate func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat("H:|[v0]|", views: messageInputContainerView)
        view.addConstraintsWithFormat("V:[v0(48)]", views: messageInputContainerView)
        
        bottomConstraint = view.addBottomToBottomConstraint(about: messageInputContainerView, to :view)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintsWithFormat("H:|-8-[v0][v1(65)]-2-|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: sendButton)
        messageInputContainerView.addConstraintsWithFormat("H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0(0.5)]", views: topBorderView)
        
        KeyboardNotification.keyboardWillShow(observer : self, selector: #selector(handleKeyboardNotification))
        KeyboardNotification.keyboardWillHide(observer : self, selector: #selector(handleKeyboardNotification))
        
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCollectionViewCell
        
        let messageText = messages[indexPath.item].text
        
        cell.messageTextView.text = messageText
        
        let estimatedFrame = FrameEstimator.estimateTextFrame(text : messageText, textFontSize : 18, desiredWidth : 250)
        
        if  indexPath.item % 2 == 0  /*(uther message)*/{
            
            cell.profileImageView.image = interlocutor?.photo
            
            cell.makeup(style : .full)
                .messageTextView.frame = CGRect(
                    x: 48/*natural messageTextView's margin to the frame*/ + 8 /*text's margin to the left by shifting the messageTextView's position by 8 pixels from the textBubbleView */,
                    y: 0,
                    width: estimatedFrame.width + 16 /*prevent text overflow*/,
                    height: estimatedFrame.height + 20/*correction*/
            )
            
            cell.textBubbleView.frame = CGRect(
                x: 48/*natural textBubbleView's margin to the frame*/ ,
                y: 0,
                width: estimatedFrame.width + 16/*prevent text overflow*/  + 8/*text's margin to the right by extending by 8 pixels the textBubbleView's width */,
                height: estimatedFrame.height + 20/*correction*/
            )
            
            
            
        } else /*(user message)*/{
            
            cell.makeup(style: .light)
                .messageTextView.frame = CGRect(
                    x: view.frame.width - estimatedFrame.width - 16 - 16 /*prevent text overflow*/,
                    y: 0,
                    width: estimatedFrame.width + 16 /*prevent text overflow*/,
                    height: estimatedFrame.height + 20/*correction*/
            )
            
            cell.textBubbleView.frame = CGRect(
                x: view.frame.width - estimatedFrame.width - 16 - 8 - 16 /*prevent text overflow*/,
                y: 0,
                width: estimatedFrame.width + 16 /*prevent text overflow*/ + 8,
                height: estimatedFrame.height + 20/*correction*/
            )
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedFrame = FrameEstimator.estimateTextFrame(text : messages[indexPath.item].text, textFontSize : 18, desiredWidth : 250)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20/*height correction*/)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)  //TODO add tap gesture
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
