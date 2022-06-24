//
//  String+Extension.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import Foundation

extension String {
    var className:String {
        return self.components(separatedBy: ".").last!
    }
}
