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
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil),
        Message(text : "Bla Bla Bla", author : nil)
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
        
        cell.messageTextView.text = messages[indexPath.item].text
        
        let messageText = messages[indexPath.item].text
        
        cell.profileImageView.image = UIImage(named: "userPhoto")
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
        
        cell.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
        
        cell.textBubbleView.frame = CGRect(x: 48, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedFrame = NSString(
            string: messages[indexPath.item].text
            ).boundingRect(
                with: CGSize(width: 250, height: 1000),
                options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)],
                context: nil
        )
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
    }
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
}
