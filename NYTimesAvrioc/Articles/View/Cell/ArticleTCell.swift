//
//  ArticleTCell.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 22/06/22.
//

import UIKit

class ArticleTCell: UITableViewCell {

    @IBOutlet weak var imgArticle: AsyncImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblPublishDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUP()
        
    }
    
    func setUP(){
        self.lblPublishDate.font = UIFont.systemFont(ofSize: 12)
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 14);
        self.lblSource.font = UIFont.systemFont(ofSize: 12);
        
        self.lblTitle.textColor = .black;
        self.lblSource.textColor = .blue
        self.lblPublishDate.textColor = .gray
        
    }

    func setInfo(info : ArticleCellViewModel){
        
        imgArticle.downloadImage(url:info.image){ image in
            self.imgArticle.image = image ==  nil ? UIImage(named: "DummyImage")! : image;
        }
        self.lblTitle.text = info.title;
        self.lblSource.text = info.source;
        self.lblPublishDate.text = info.publishDate;
//
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
