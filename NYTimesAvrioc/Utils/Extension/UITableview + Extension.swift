//
//  UITableview + Extension.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import UIKit

extension UITableView {
    
    func  registerTableViewCellWithNib(nibName:String){
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: nibName)
        self.tableFooterView = UIView()
    }
}
