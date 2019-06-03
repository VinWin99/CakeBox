//
//  ViewController.swift
//  CakeBox
//
//  Created by Vineet Ramisetty on 5/13/19.
//  Copyright © 2019 Vineet Ramisetty, Krish Kalai. All rights reserved.
//

import UIKit

class CakePickerViewController: UIViewController {
    let supportLogic = SupportLogic.logicInstance
    
    private var db: [[String]] = []
    private var pageIndex: Int = 0
    
    private var cakeTitle: UILabel = UILabel()
    private var cakeImageView: UIImageView = UIImageView()
    private var cakeDescription: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        db = readPropertyList(bundleName: "Cakes")
        
        self.cakeTitle.font = UIFont(name: "Avenir",
                                     size: 24)
        
        cakeDescription.numberOfLines = 0
        cakeDescription.font = UIFont(name: "Avenir",
                                      size: 16)
        cakeDescription.frame = CGRect.init(x: 16,
                                            y: 375,
                                            width: self.view.bounds.width - 32,
                                            height: 100)
        cakeDescription.textAlignment = .justified
        
        getPageDetails()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        self.view.addSubview(cakeTitle)
        self.view.addSubview(cakeImageView)
        self.view.addSubview(cakeDescription)
    }

    func readPropertyList(bundleName: String) -> [[String]] {
        var cakes: [[String]] = []
        if let URL = Bundle.main.url(forResource: bundleName, withExtension: "plist") {
            if let cakeFromPlist = NSArray(contentsOf: URL) as? [[String]] {
                cakes = cakeFromPlist
            }
        }
        
        return cakes
    }
    
    func getPageDetails() {
        var runningHeight: CGFloat = 0
        
        cakeTitle.text = db[pageIndex][0]
        cakeTitle.sizeToFit()
        cakeTitle.center = CGPoint(x: self.view.center.x,
                                   y: 64)
        runningHeight += cakeTitle.frame.origin.y + cakeTitle.frame.height
        
        if let image = UIImage(named: db[pageIndex][1]) {
            cakeImageView.image = image
            let width = self.view.bounds.width - 32
            let height = image.size.height * width / image.size.width
            cakeImageView.frame = CGRect(x: 16,
                                         y: runningHeight,
                                         width: width,
                                         height: height)
            runningHeight += cakeImageView.frame.height
        }
        
        cakeDescription.text = db[pageIndex][2]
        cakeDescription.sizeToFit()
        cakeDescription.frame.origin = CGPoint(x: 16,
                                               y: runningHeight)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(RecipieViewController(cakeName: db[pageIndex][0],
                                                                            imageName: db[pageIndex][1],
                                                                            ingredients: db[pageIndex][3],
                                                                            recipie: db[pageIndex][4]),
                                                      animated: true)
    }
 
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                if pageIndex > 0 {
                    pageIndex -= 1
                }
            case .left:
                if pageIndex < db.count - 1 {
                    pageIndex += 1
                }
            default:
                return
            }
            self.getPageDetails()
        }
    }
}

