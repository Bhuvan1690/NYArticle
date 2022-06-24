//
//  ViewController.swift
//  NYTimesAvrioc
//
//  Created by Bhuvan Sharma on 22/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    var arrArticles : [ArticleDto] = []
    @IBOutlet weak var tblArticles: UITableView!
    var loaderAlert : UIAlertController?
    var dict : [Int:Int] = [0:1,1:7,2:30]
    private lazy var viewModel = ArticleViewModel()
    private lazy var  bag: DisposeBag? = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        
        tblArticles.registerTableViewCellWithNib(nibName: "ArticleTCell")
        viewModel.delegate = self;
        viewModel.articles.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tblArticles.reloadData()
            }
        }.disposed(by: bag)
        viewModel.articleAPIError.bind(listener: showErrorAlert).disposed(by: bag)
        self.callApi(period: 1)
        
    }
    
    func callApi(period : Int){
        viewModel.getArticles(endPoint: ApiEndPoint.mostViewed(section: "all-sections", periods: period))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title  = "Most Popular Articles"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = "Back"
    }
    
    @IBAction func actionForPeriodChange(_ sender: UISegmentedControl) {
        self.callApi(period: dict[sender.selectedSegmentIndex] ?? 1)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTCell.description().className) as! ArticleTCell
        if let modal = viewModel.getArticleCellModel(for: indexPath.row){
            cell.setInfo(info: modal)
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).loadVC(ArticleDetailVC.self){
            vc.viewModel = self.viewModel;
            vc.redirectID = viewModel.articleId(for: indexPath.row)
            self.navigationController?.pushViewController(vc, animated: true);
        }
    }
    
    
    
}

extension ViewController : showLoader{
    func isLoading(loading: LoadingState) {
        
        switch loading {
        case .loading:
            self.LoadingStart()
        case .normal:
            self.LoadingStop()
        }
    }
}

extension UIViewController {
    func showErrorAlert(err: String?) {
        guard let err =  err else {
            return
        }
        self.showAlert(msg: err)
    }
}
