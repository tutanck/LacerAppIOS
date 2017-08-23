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
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Yes, totally looking to buy an iPhone 7.", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla ", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla", author : nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    
    func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCollectionViewCell
        
        
        let messageText = messages[indexPath.item].text
        
        
        
        let estimatedFrame = NSString(
            string: messageText
            ).boundingRect(
                with: CGSize(
                    width: 250/*width we want for the messageTextView rect*/,
                    height: 1000/*arbitrary height to have enougth space for text in the messageTextView rect (for making estimations of the real height needed)*/
                ),
                options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18/*textFontSize*/)],
                context: nil
        )
        
        
        
        
        cell.messageTextView.text = messageText
        
        
        if  indexPath.item % 2 == 0{
            
            
            cell.profileImageView.image = UIImage(named: "userPhoto")
            
            cell.messageTextView.frame = CGRect(
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
            cell.profileImageView.isHidden = false
            cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            cell.messageTextView.textColor = UIColor.black
            
        } else {
            
            
            //outgoing sending message
            
            cell.messageTextView.frame = CGRect(
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
            cell.profileImageView.isHidden = true
            cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
            cell.messageTextView.textColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedFrame = NSString(
            string: messages[indexPath.item].text
            ).boundingRect(
                with: CGSize(
                    width: 250/*width we want for the messageTextView rect*/,
                    height: 1000/*arbitrary height to have enougth space for text in the messageTextView rect (for making estimations of the real height needed)*/
                ),
                options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18/*textFontSize*/)],
                context: nil
        )
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20/*correction*/)
    }
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
}
