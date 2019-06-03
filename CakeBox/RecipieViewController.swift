//
//  RecipeViewController.swift
//  CakeBox
//
//  Created by Vineet Ramisetty on 5/13/19.
//  Copyright © 2019 Vineet Ramisetty, Krish Kalai. All rights reserved.
//

import UIKit

class RecipieViewController: UIViewController {
    let supportLogic = SupportLogic.logicInstance
    
    var cakeName: String!
    var image: UIImage!
    var ingredients: String!
    var recipie: String!
    
    init(cakeName: String, imageName: String, ingredients: String, recipie: String){
        super.init(nibName: nil, bundle: nil)
        self.cakeName = cakeName
        self.image = UIImage(named: imageName)!
        self.ingredients = ingredients.replacingOccurrences(of: "\\n", with: "\n")
        self.recipie = recipie.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let topInset: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        let doneButton = UIButton(type: .system)
        doneButton.frame = CGRect(x: 16,
                                  y: topInset,
                                  width: 0,
                                  height: 0)
        doneButton.setTitle("Done",
                            for: .normal)
        doneButton.addTarget(self,
                             action: #selector(performDismiss),
                             for: .touchUpInside)
        doneButton.sizeToFit()
        
        var runningHeight: CGFloat = 0
        let scrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: doneButton.frame.height + topInset,
                                                    width: self.view.bounds.width,
                                                    height: self.view.bounds.height - doneButton.frame.height - topInset))
        
        let cakeTitle = UILabel()
        cakeTitle.frame = CGRect(x: 16,
                                 y: runningHeight,
                                 width: self.view.bounds.width - 32,
                                 height: 0)
        cakeTitle.numberOfLines = 0
        cakeTitle.text = cakeName
        cakeTitle.font = UIFont(name: "Avenir",
                                size: 24)
        cakeTitle.sizeToFit()
        runningHeight += cakeTitle.frame.height
        
        let cakeImageViewWidth = scrollView.frame.width - 32
        let cakeImageView = supportLogic.getImageView(image: image,
                                                      origin: CGPoint(x: 16,
                                                                      y: runningHeight),
                                                      boundingDimension: cakeImageViewWidth)
        runningHeight += cakeImageView.frame.height
        
        let ingredientView = UILabel()
        ingredientView.frame = CGRect.init(x: 16,
                                           y: runningHeight,
                                           width: self.view.bounds.width - 32,
                                           height: 0)
        ingredientView.numberOfLines = 0
        ingredientView.text = ingredients
        ingredientView.sizeToFit()
        runningHeight += ingredientView.frame.height + 32
        
        let recipieView = UILabel()
        recipieView.frame = CGRect.init(x: 16,
                                        y: runningHeight,
                                        width: self.view.bounds.width - 32,
                                        height: 0)
        recipieView.numberOfLines = 0
        recipieView.text = recipie
        recipieView.sizeToFit()
        runningHeight += recipieView.frame.height
        
        scrollView.addSubview(cakeTitle)
        scrollView.addSubview(cakeImageView)
        scrollView.addSubview(ingredientView)
        scrollView.addSubview(recipieView)
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width,
                                        height: runningHeight)
        self.view.addSubview(scrollView)
        self.view.addSubview(doneButton)
    }
    
    @objc
    func performDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}
