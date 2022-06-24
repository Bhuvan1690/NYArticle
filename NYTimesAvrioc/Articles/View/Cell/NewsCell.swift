//
//  NewsCell.swift
//  SportsTigerV3.0
//
//  Created by MyTeam11 on 22/06/20.
//  Copyright © 2020 MyTeam11. All rights reserved.
//

import UIKit
import SafariServices

class NewsCell: UICollectionViewCell {
    //MARK:- NewsState Enum
    
    @IBOutlet weak var vwReadMore: UIView!
    @IBOutlet weak var lblMainHeading : UILabel!
    @IBOutlet weak var lblSubHeading : UILabel!
    @IBOutlet weak var lblNews : UILabel!
    
    @IBOutlet weak var imgArticle : AsyncImageView!
    
//    @IBOutlet weak var viewImagBg : UIView!
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var lblReadMore: UILabel!
    @IBOutlet weak var imgReadMoreArrow: UIImageView!
    @IBOutlet weak var viewReadMoreArrow: UIView!
    @IBOutlet weak var viewReadMoreBg: UIView!
    
    var vc : UIViewController?
    var objNews: ArticleDetailViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp();
    }
    
     //MARK:-  Inital Setup
    //setupData
    func setUp(){
        lblMainHeading.textColor = .black
        imgArticle.contentMode = .scaleToFill
        
        self.viewParent.backgroundColor = .white;
        self.viewParent.layer.shadowOpacity = 0.5
        self.viewParent.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.viewParent.layer.shadowRadius = 5.0
        self.viewParent.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewParent.layer.masksToBounds = false
        self.lblReadMore.textColor = .blue
        self.viewReadMoreArrow.backgroundColor = .blue.withAlphaComponent(0.5)
        self.imgReadMoreArrow.tintColor = .white
        self.viewReadMoreBg.backgroundColor = .blue.withAlphaComponent(0.1)
        
        self.lblMainHeading.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    @IBAction func btnReadMoreTap(_ sender: UIButton) {
        guard let url = URL(string: self.objNews?.url ?? "") else{return}
        self.openInSafarViewController(url);
    }
    

    
    // Configure news data from HomeNewsResult modal
    func configureNewsData(modal : ArticleDetailViewModel){
        self.objNews = modal
        lblMainHeading.text = modal.title
        
        let textAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let textPart1 = NSMutableAttributedString(string: modal.shortDescript, attributes: textAttributes1)

        let textCombination1 = NSMutableAttributedString()
        textCombination1.append(textPart1)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        // *** Apply attribute to string ***
        textCombination1.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, textCombination1.length))
        
        lblNews.attributedText = textCombination1//modal.newsBody
        lblReadMore.text = "Read More"
        
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let textPartOne = NSMutableAttributedString(string: modal.source, attributes: textAttributesOne)
        let points = " \u{2022} " + modal.publishDate
        let textPartTwo = NSMutableAttributedString(string: String(describing: points), attributes: textAttributesTwo)
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        self.lblSubHeading.attributedText = textCombination
        imgArticle.downloadImage(url:modal.image){ image in
            self.imgArticle.image = image ==  nil ? UIImage(named: "DummyImage")! : image;
        }
    }
}

extension NewsCell: SFSafariViewControllerDelegate{
    func openInSafarViewController(_ url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: url,configuration: config)
        safariVC.delegate = self;
        self.vc?.showDetailViewController(safariVC, sender: self)
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil);
    }
}
