//
//  UIViewController+Extensions.swift
//  NYTimesAvrioc

//  Created by Bhuvan Sharma on 23/06/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ title: String? = nil, msg: String?, buttonText: String = "OK") {
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showActionSheet(msg: String?, buttons:[String], cancelTitle: String = "Cancel", clickedItem:@escaping ((String) -> Void), view: UIView) {
        let alert = UIAlertController(
            title: nil,
            message: msg,
            preferredStyle: .actionSheet
        )
        
        if  UIDevice.current.userInterfaceIdiom == .pad {
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = view.bounds            
        }
        
        for item in buttons {
            alert.addAction(UIAlertAction(title: item, style: .default, handler: { (action) in
                clickedItem(item)
            }))
        }
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func LoadingStart(msg : String = "Please wait..."){
        Loader.alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        Loader.alert.view.addSubview(loadingIndicator)
        present(Loader.alert, animated: true, completion: nil)
      }

      func LoadingStop(){
        Loader.alert.dismiss(animated: true, completion: nil)
      }
    
}
