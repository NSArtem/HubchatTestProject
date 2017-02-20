//
//  ViewController.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit
import SnapKit

class MainScreenController: UIViewController {

    var headerViewModel: PhotoForumHeaderViewModel?
    var feedViewModel: PostsFeedViewModel?
    
    let heightForHeader: CGFloat = 256.0
    
    var headerImageView: UIImageView?
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var tableView: UITableView?
    var headerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        setupView()
        bindViewModel()
        headerViewModel?.reloadData()
        feedViewModel?.reloadData()
    }
    
    required convenience init(headerViewModel: PhotoForumHeaderViewModel, feedViewModel: PostsFeedViewModel) {
        self.init()
        self.headerViewModel = headerViewModel
        self.feedViewModel = feedViewModel
    }
    
    private func bindViewModel() {
        headerViewModel?.viewModelDidError = { error in
            let alert = UIAlertController(title: "Unable to load data", message: "Check your netowrk connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        headerViewModel?.viewModelDidUpdate = { viewModel in
            self.titleLabel?.text = viewModel.title
            self.descriptionLabel?.text = viewModel.description
            self.headerImageView?.image = viewModel.headerImage
        }
        feedViewModel?.viewModelDidError = { error in
            let alert = UIAlertController(title: "Unable to load data", message: "Check your netowrk connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        feedViewModel?.viewModelDidUpdate = { viewModel in
            self.tableView?.reloadData()
        }

    }
    
    private func setupView() {
        //TableView
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44.0;
        PostCell.registerCell(tableView)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
        self.tableView = tableView
        
        //Header
        headerView = UIView()
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = UIColor.white
        headerImageView = UIImageView()
        descriptionLabel = UILabel()
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.textAlignment = .center
        descriptionLabel?.textColor = .white
        headerView?.addSubview(headerImageView!)
        headerView?.addSubview(titleLabel!)
        headerView?.addSubview(descriptionLabel!)
        headerImageView?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.edges.equalTo(headerView!)
        })
        titleLabel?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.center.equalTo(headerView!)
        })
        descriptionLabel?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel!).offset(8)
            ConstraintMaker.left.equalTo(headerView!).offset(16)
            ConstraintMaker.right.equalTo(headerView!).offset(-16)
            ConstraintMaker.bottom.equalTo(headerView!).offset(-8)
        })
        
    }

}

//MARK: - UITableViewDataSource
extension MainScreenController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel?.postCells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = feedViewModel?.postCells?[indexPath.row] else {
            debugPrint("Unable to find cell")
            return UITableViewCell()
        }
        let cell = PostCell.dequeueCell(tableView, indexPath: indexPath, viewModel: viewModel)
        return cell
    }
    

}

//MARK: - UITableViewDelegate
extension MainScreenController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? PostCell)?.loadData()
    }
}

