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
            navigationItem.title = interlocutor?.username
            
            //messages = messages.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    
    var messages: [Message] = [
        Message(_id: "", text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", authorID : "",recipientID : ""),
        Message(_id: "", text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", authorID : "",recipientID : ""),
        Message(_id: "", text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", authorID : "",recipientID : "")
    ]
    
    
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let inputTextField: UITextView = {
        let textField = UITextView()
        textField.layer.borderWidth = 0.8;
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        //textField.placeholder = "Ecrire un message..."//TODO
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: UIControlState())
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    
    var bottomConstraint: NSLayoutConstraint?
    
    
    
    //Global tap gesture
    fileprivate func setTapToDissmissKeyboard(){
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        singleTap.numberOfTapsRequired = 1;
        collectionView?.addGestureRecognizer(singleTap)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupCollectionView()
        setupInputComponents()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    fileprivate func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.scrollToLastItem(atIts: .bottom, animated: false)
        setTapToDissmissKeyboard()
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
        
        messageInputContainerView.addConstraintsWithFormat("H:|[v0][v1(65)]-2-|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: sendButton)
        messageInputContainerView.addConstraintsWithFormat("H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0(0.5)]", views: topBorderView)
        
        KeyboardNotification.addObserverOnKeyboardWillShow(observer : self, selector: #selector(handleKeyboardNotification))
        KeyboardNotification.addObserverOnKeyboardWillHide(observer : self, selector: #selector(handleKeyboardNotification))
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCollectionViewCell
        
        let messageText = messages[indexPath.item].text
        
        cell.messageTextView.text = messageText
        
        let estimatedFrame = FrameEstimator.estimateTextFrame(text : messageText, textFontSize : 18, desiredWidth : 250)
       
        let correction : CGFloat = 20 //estimated frame's height correction
        
        let textOverflow : CGFloat = 16 //text overflow prevention
        
        let textMargin : CGFloat = 8 //text margin : difference of space between textBubbleView & messageTextView
        //by example : for the .full style, we get this  :
        //text's margin to the left by shifting the messageTextView's position by 8 pixels from the textBubbleView
        //text's margin to the right by extending by 8 pixels the textBubbleView's width
        
        if  indexPath.item % 2 == 0  /*(uther message)*/{
            
            cell.profileImageView.image = interlocutor?.photo ?? UIImage(named : "userPhoto")
            
            //textBubbleView's margin to the frame's left
            let marginToFrameLeft : CGFloat = 48
            
            cell.makeup(style : .full, margin: marginToFrameLeft + textMargin)
                .messageTextView.frame = CGRect(
                    x: marginToFrameLeft + textMargin,
                    y: 0,
                    width: estimatedFrame.width + textOverflow,
                    height: estimatedFrame.height + correction
            )
            
            cell.textBubbleView.frame = CGRect(
                x: marginToFrameLeft,
                y: 0,
                width: estimatedFrame.width + textOverflow + textMargin,
                height: estimatedFrame.height + correction
            )
            
            
            
        } else /*(user message)*/{
            
            //textBubbleView's margin to the frame's left
            let marginToFrameRight : CGFloat = view.frame.width - estimatedFrame.width - 16 - 16
            
            cell.makeup(style: .light, margin: 24)
                .messageTextView.frame = CGRect(
                    x: marginToFrameRight,
                    y: 0,
                    width: estimatedFrame.width + textOverflow,
                    height: estimatedFrame.height + correction
            )
            
            cell.textBubbleView.frame = CGRect(
                x: marginToFrameRight - textMargin,
                y: 0,
                width: estimatedFrame.width + textOverflow + textMargin,
                height: estimatedFrame.height + correction
            )
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedFrame = FrameEstimator.estimateTextFrame(text : messages[indexPath.item].text, textFontSize : 18, desiredWidth : 250)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20/*height correction*/+ 24 /*dateLabel*/)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
    
    func hideKeyboard(_ sender: AnyObject) { inputTextField.endEditing(true) }

    
    func simulate() {
       let messageText = "Here's a text message that was sent a few minutes ago..."
        let message = Message(_id: "", text: messageText, authorID: "", recipientID:"")
        messages.append(message)
        
        //messages = messages.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        
        //if let item = messages.index(of: message) {
            let receivingIndexPath = IndexPath(item: messages.count - 3, section: 0)
            collectionView?.insertItems(at: [receivingIndexPath])
        //}
    }
    
    
    func handleSend() {
        if let messageText = inputTextField.text {
            
            if messageText.isEmpty {return}
            
            messages.append(Message(_id: "",text: messageText, authorID: "", recipientID:""))
            
            
            let item = messages.count - 1
            let insertionIndexPath = IndexPath(item: item, section: 0)
            collectionView?.insertItems(at: [insertionIndexPath])
            //collectionView?.scrollToItem(at: insertionIndexPath, at: .bottom, animated: true)
            
            collectionView!.scrollToLastItem(atIts: .bottom, animated: true)
            inputTextField.text = nil
        }
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
