//
//  PostCell.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    static let cellidentifier: String = "PostCell"
    
    private var viewModel: PostCellViewModel?
    
    var avatarImageView: UIImageView?
    var userNameLabel: UILabel?
    var imageViews: [UIImageView]?
    var postTextLabel: UILabel?
    
    
    func bindViewModel(viewModel: PostCellViewModel) {
        self.viewModel = viewModel
        setupViews()
        userNameLabel?.text = viewModel.userName
        postTextLabel?.text = viewModel.postText
        self.viewModel?.didUpdate = { viewModel in
            self.avatarImageView?.image = viewModel.userImage
            for (index, imageView) in (self.imageViews ?? []).enumerated() {
                imageView.image = viewModel.postImages?[index].image
            }
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
        
        var imageViews = [UIImageView]()
        
        //pictures
        if let imagesToAdd = viewModel?.postImages {
            for (index, image) in imagesToAdd.enumerated() {
                let imageView = UIImageView()
                contentView.addSubview(imageView)
                imageViews.append(imageView)
                imageView.snp.makeConstraints({ (maker) in
                    maker.left.equalTo(contentView)
                    maker.right.equalTo(contentView)
                    if index == 0 {
                        maker.top.equalTo(postTextLabel.snp.bottom).offset(8)
                    } else {
                        maker.top.equalTo(imageViews[index-1].snp.bottom)
                    }
                    if index == imagesToAdd.count-1 {
                        maker.bottom.equalTo(contentView)
                    }
                    if let width = image.width, let height = image.height {
                        maker.width.equalTo(imageView.snp.height).multipliedBy(Float(width) / Float(height))
                    }
                })
            }
        }
        
        self.imageViews = imageViews
 
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
