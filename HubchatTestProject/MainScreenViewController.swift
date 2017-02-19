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
    
    let cellidentifier: String = "postcell"
    
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
    }
    
    required convenience init(viewModel: PhotoForumHeaderViewModel) {
        self.init()
        headerViewModel = viewModel
    }
    
    private func bindViewModel() {
        headerViewModel?.didError = { error in
            let alert = UIAlertController(title: "Unable to load data", message: "Check your netowrk connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        headerViewModel?.didUpdate = { viewModel in
            self.titleLabel?.text = viewModel.title
            self.descriptionLabel?.text = viewModel.description
            self.headerImageView?.image = viewModel.headerImage
        }
    }
    
    private func setupView() {
        //TableView
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(PostCell.self, forCellReuseIdentifier: cellidentifier)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
        self.tableView = tableView
        
        //Header
        headerView = UIView()
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        headerImageView = UIImageView()
        descriptionLabel = UILabel()
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.textAlignment = .center
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

extension MainScreenController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 256
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath)
        return cell
    }
}

extension MainScreenController: UITableViewDelegate {
    
}

