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
    
    @IBOutlet var profileImage: [UIImageView]!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postedImgae: UIImageView!
    @IBOutlet weak var postedDescLabel: UILabel!
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var postedDurationLable: UILabel!
    @IBOutlet weak var commets: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImage.forEach { $0.image = nil }
        usernameLabel.text = ""
        postedImgae.image = nil
        postedDescLabel.text = ""
        likedLabel.text = ""
        postedDurationLable.text = ""
        commets.setTitle("", for: .normal)
    }
}

extension PostTableViewCell {
    
    private func configure(with model: Post) {
        profileImage.forEach {
            $0.kf.setImage(with: URL(string: model.user!.profileImage!))
        }
        postedImgae.kf.setImage(with: URL(string: model.postImgae!.imageURL!))
        
        usernameLabel.text = model.user!.username!
        likedLabel.text = "\(model.like!.count!) Likes"
        commets.setTitle("View all \(model.comment!.count!) comments", for: .normal)
        postedDescLabel.text = model.desc ?? ""
        
    }
}

//MARK: - Helper Methods
extension PostTableViewCell {
    
    public static var cellId: String {
        return "NewFeedTableViewCell"
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
    
    public static func loadFromNib(owner: Any?) -> PostTableViewCell {
        return bundle.loadNibNamed(PostTableViewCell.cellId, owner: owner, options: nil)?.first as! PostTableViewCell
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with post: Post) -> PostTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellId, for: indexPath) as! PostTableViewCell
        cell.configure(with: post)
        return cell
    }
    
}
