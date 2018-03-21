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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImage.image = nil
        usernameLabel.text = ""
        postedImgae.image = nil
        likedLabel.text = ""
        postedDurationLable.text = ""
        commets.setTitle("", for: .normal)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        profileImage.cornerRadius()
    }
  
}

extension PostTableViewCell {
    
    func configure(with model: Post) {
        profileImage.kf.setImage(with: URL(string: model.user!.profileImage!))
        
        postedImgae.kf.setImage(with: URL(string: model.postImgae!.imageURL!))
        
        usernameLabel.text = model.user!.username!
        likedLabel.text = "\(model.like!.count!) Likes"
        commets.setTitle("\(model.comment!.count!) comments", for: .normal)
        postedDurationLable.text = stringFromDate(date: model.createdTime!)
    }
    
    private func stringFromDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("Unable to create date from string \(dateString) with format \(dateFormatter.dateFormat)")
        }

        let now = Date()
        
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.allowedUnits = [.day, .minute, .hour]
        componentsFormatter.maximumUnitCount = 2
        componentsFormatter.unitsStyle = .full
        
        guard let fromString = componentsFormatter.string(from: date, to: now) else { return "" }
        
        return "\(fromString) ago".uppercased()
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
    
    public static func loadFromNib(owner: Any?) -> PostTableViewCell {
        return bundle.loadNibNamed(PostTableViewCell.cellId, owner: owner, options: nil)?.first as! PostTableViewCell
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with post: Post) -> PostTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellId, for: indexPath) as! PostTableViewCell
        cell.configure(with: post)
        return cell
    }
    
}
