//
//  PostCell.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class PostCell: UITableViewCell {
    
    static let cellidentifier: String = "PostCell"
    
    private var viewModel: PostCellViewModel?
    
    var avatarImageView: UIImageView?
    var userNameLabel: UILabel?
    var postImageView: UIImageView?
    var postTextLabel: UILabel?
    var upvoteLabel: UILabel?

    func bindViewModel(viewModel: PostCellViewModel) {
        self.viewModel = viewModel
        setupViews()
        userNameLabel?.text = viewModel.userName
        postTextLabel?.text = viewModel.postText
        upvoteLabel?.text = viewModel.upvotes
        self.viewModel?.viewModelDidUpdate = { viewModel in
            self.avatarImageView?.image = viewModel.userImage
            self.postImageView?.image = viewModel.postImages?.first?.image
        }
    }
    
    
    func loadData() {
        viewModel?.reloadData()
    }
    
    func setupViews() {
        //avatar
        let avatarDiameter = 64
        let avatarImageView = UIImageView()
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (maker) in
            maker.left.equalTo(contentView).offset(16)
            maker.top.equalTo(contentView).offset(16)
            maker.width.equalTo(avatarDiameter)
            maker.height.equalTo(avatarDiameter)
        }
        avatarImageView.layer.cornerRadius = CGFloat(avatarDiameter / 2)
        avatarImageView.clipsToBounds = true
        self.avatarImageView = avatarImageView
        
        //username
        let userNameLabel = UILabel()
        contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(avatarImageView)
            maker.left.equalTo(avatarImageView.snp.right).offset(8)
            maker.right.greaterThanOrEqualTo(contentView.snp.right).offset(-8)
        }
        self.userNameLabel = userNameLabel
        
        //text
        let postTextLabel = UILabel()
        postTextLabel.numberOfLines = 0
        contentView.addSubview(postTextLabel)
        postTextLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(avatarImageView.snp.bottom).offset(8)
            maker.left.equalTo(contentView).offset(8)
            maker.right.equalTo(contentView).offset(-8)
        }
        self.postTextLabel = postTextLabel
        
        //ImageView
        let postImageView = UIImageView()
        contentView.addSubview(postImageView)
        postImageView.clipsToBounds = true
        postImageView.contentMode = UIViewContentMode.scaleAspectFill
        postImageView.backgroundColor = UIColor.blue
        postImageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(postTextLabel.snp.bottom).offset(8)
            maker.left.equalTo(contentView)
            maker.right.equalTo(contentView)
            var ratio: Float
            if let width = viewModel?.postImages?.first?.width, let height = viewModel?.postImages?.first?.height {
                ratio = Float(width/height)
            } else {
                ratio = 0.64
            }
            maker.height.equalTo(postImageView.snp.width).multipliedBy(ratio)
        }
        self.postImageView = postImageView
        
        //upvotes
        let upvoteLabel = UILabel()
        contentView.addSubview(upvoteLabel)
        upvoteLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(postImageView.snp.bottom).offset(8)
            maker.left.equalTo(contentView)
            maker.right.equalTo(contentView)
            maker.bottom.equalTo(contentView).offset(-6)
        }
        self.upvoteLabel = upvoteLabel
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    static func registerCell(_ tableView: UITableView) {
        tableView.register(PostCell.self, forCellReuseIdentifier: cellidentifier)
    }
    
    static func dequeueCell(_ tableView: UITableView, indexPath: IndexPath, viewModel: PostCellViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as? PostCell else {
            fatalError()
        }
        cell.bindViewModel(viewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
}
