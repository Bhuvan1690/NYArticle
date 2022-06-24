//
//  Storyboard+Extension.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 23/06/22.
//

import UIKit

extension UIStoryboard {
    func loadVC<T: UIViewController>(_ type : T.Type) -> T? {
        return self.instantiateViewController(withIdentifier: T.description().className) as? T
    }
}
