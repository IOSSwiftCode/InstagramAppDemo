//
//  LoadingIndicatorView.swift
//  DFIStaffApp
//
//  Created by chanthem on 2/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    var loadingIndicator : UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoadingIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoadingIndicator() {
        self.backgroundColor = UIColor.gray
        self.alpha = 0.9
        self.isHidden = true
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        // Position Activity Indicator in the center of the main view
        loadingIndicator.center = self.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        loadingIndicator.hidesWhenStopped = true
        
        self.addSubview(loadingIndicator)
    }
    
    func startIndicatorLoading() {
        self.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func stopIndicatorLoading() {
        self.isHidden = true
        loadingIndicator.stopAnimating()
    }

}
