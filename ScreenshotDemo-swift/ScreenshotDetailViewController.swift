//
//  ScreenshotDetailViewController.swift
//  ScreenshotDemo
//
//  Created by shaobin on 16/12/16.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

import UIKit

class ScreenshotDetailViewController: UIViewController {
    var screenshotImage : UIImage?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.view.backgroundColor = UIColor.black
        self.initImageView()
    }
    
    func backAction() {
        self.dismiss(animated: true, completion: { _ in })
    }
    
    // MARK: - Initialization
    func initNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.backAction))
    }
    
    func initImageView() {
        let imageView = UIImageView(image: self.screenshotImage)
        imageView.center = CGPoint(x: CGFloat(self.view.bounds.midX), y: CGFloat(self.view.bounds.midY))
        imageView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        self.view.addSubview(imageView)
    }
}
