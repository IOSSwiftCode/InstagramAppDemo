//
//  NewFeedTableViewCell.swift
//  InstagramApp
//
//  Created by son chanthem on 3/19/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postedImgae: UIImageView!
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var postedDurationLable: UILabel!
    @IBOutlet weak var commets: UIButton!
    
    var viewModel: PostCellViewModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImage.image = nil
        usernameLabel.text = ""
        postedImgae.image = nil
        likedLabel.text = ""
        postedDurationLable.text = ""
        commets.setTitle("", for: .normal)
    }
}

extension PostTableViewCell {
    
    func configure(with model: Post) {
        
        viewModel = PostCellViewModel(post: model)
        
        profileImage.cornerRadius()
        profileImage.kf.setImage(with: viewModel.profileImage)
        postedImgae.kf.setImage(with: viewModel.postImgae)
        usernameLabel.text = viewModel.username
        likedLabel.text = viewModel.like
        commets.setTitle(viewModel.comment, for: .normal)
        postedDurationLable.text = viewModel.duration
    }

}

//MARK: - Helper Methods
extension PostTableViewCell {
    
    public static var cellId: String {
        return "PostTableViewCell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: PostTableViewCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: PostTableViewCell.cellId, bundle: PostTableViewCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.cellId)
    }
    
}
