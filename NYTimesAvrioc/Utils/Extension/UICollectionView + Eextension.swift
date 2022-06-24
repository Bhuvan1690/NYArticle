//
//  UICollectionView + Eextension.swift
//  NYTimesAvrioc
//
//  Created by MT11-1195 on 23/06/22.
//

import UIKit


extension UICollectionView {
    
    func  registerCollectionViewCellWithNib(nibName:String){
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: nibName)
    }
}
