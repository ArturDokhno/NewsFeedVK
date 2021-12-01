//
//  NewsFeedViewController.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 11.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var  feedViewModel = FeedViewModel.init(cells: [])
    
    @IBOutlet var table: UITableView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        
        table.separatorStyle = .none
//        table.backgroundColor = .clear
//        view.backgroundColor = .darkGray
        
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayNewsfeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            table.reloadData()
        }
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
}
