//
//  UtherProfileCollectionViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 26/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UtherProfileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "UtherProfileCollectionViewCell"
    
    let wallpaperColor = UIColor(white : 0.99 , alpha : 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    
    fileprivate func setupCollectionView(){
        collectionView?.backgroundColor = wallpaperColor
        collectionView?.register(UtherProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UtherProfileCollectionViewCell
        
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
    
    
}
