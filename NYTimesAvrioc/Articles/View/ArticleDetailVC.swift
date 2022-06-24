//
//  ArticleDetailVC.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 22/06/22.
//

import UIKit

class ArticleDetailVC: UIViewController{
    
    @IBOutlet weak var collNews: UICollectionView!
    @IBOutlet weak var viewScrollToTop: UIView!
    @IBOutlet weak var btnScrollToTop: UIButton!
    
    var viewModel : ArticleViewModel!
    var contentOffsetY: CGFloat = 0
    var redirectID : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollection()
        self.updateListBasedOnId()
    }
    
    func setUpCollection(){
        self.collNews.registerCollectionViewCellWithNib(nibName: "NewsCell")
        self.collNews.registerCollectionViewCellWithNib(nibName: "NewsBannerCell")
        self.collNews.registerCollectionViewCellWithNib(nibName: "NewsCarousalCell")
        let layout = AnimatedCollectionViewLayout()
        layout.animator = PageAttributesAnimator()
        collNews.collectionViewLayout = layout
        collNews.reloadData()
        
        self.btnScrollToTop.setTitleColor(.white, for: .normal)
        self.viewScrollToTop.backgroundColor = .black.withAlphaComponent(0.6)
    }
    
    @IBAction func btnScrollToTop(_ sender: UIButton?) {
        self.topIndexOfnews()
    }
    
    func topIndexOfnews(){
        if self.collNews.contentOffset.y > 0.0{
            self.collNews.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            self.contentOffsetY = 0
        }
        self.viewScrollToTop.isHidden = true
    }
    
    
    func updateListBasedOnId() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let weakSelf = self else {fatalError()}
            weakSelf.collNews.reloadData()
            weakSelf.checkArticleId(id: weakSelf.redirectID);
        }
    }
    
    func checkArticleId(id: Int) {
        if id != 0{
            if viewModel.totalCount > 0{
                if let index = viewModel.articles.value.firstIndex(where: { $0.id == id }){
                    self.collNews.layoutIfNeeded()
                    self.collNews.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically , animated: false);
                    self.collNews.setNeedsLayout()
//                    let visibleRect = CGRect(origin: collNews.contentOffset, size: collNews.bounds.size)
//                    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//                    let visibleIndexPath = collNews.indexPathForItem(at: visiblePoint)
//                    
//                    if let indexP = visibleIndexPath{
//                        if indexP.item > index{
//                            self.collNews.reloadData()
//                            self.collNews.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: false);
//                        } else if indexP.item < index{
//                            self.collNews.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false);
//                        } else{
//                            self.collNews.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false);
//                        }
//                    }else{
//                        self.collNews.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false);
//                    }
                }
            }
        }
    }
}

extension ArticleDetailVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.totalCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.setUp()
        cell.vc = self;
        if let modal = viewModel.getArticleDetailModel(for: indexPath.row){
            cell.configureNewsData(modal: modal)
        }        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
//MARK:- ScrollViewDelegate Method
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            self.viewScrollToTop.isHidden = true
        }
   }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
 //       self.checkAfterScroll();
     
     let visibleRect = CGRect(origin: collNews.contentOffset, size: collNews.bounds.size)
     let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
     let visibleIndexPath = collNews.indexPathForItem(at: visiblePoint)
     
     if visibleIndexPath != nil {
         if visibleIndexPath!.item > 0 {
             if self.viewScrollToTop.isHidden {
                 UIView.transition(with: view, duration: 0.1, options: .transitionCrossDissolve, animations: {
                     self.viewScrollToTop.isHidden = false
                 })
             }
         }
         else {
             if !self.viewScrollToTop.isHidden {
                 UIView.transition(with: view, duration: 0.1, options: .transitionCrossDissolve, animations: {
                     self.viewScrollToTop.isHidden = true
                 })
             }
         }
     }
    }
}
