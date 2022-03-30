//
//  HomeViewController.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeViewController: class {
	var router: IHomeRouter? { get set }
}

class HomeViewController: BaseViewController {
    
    ///IBOutlets to modify the Y positions and width  animatedly
    @IBOutlet weak var imgMeliYPosition: NSLayoutConstraint!
    @IBOutlet weak var imgMeliWidth: NSLayoutConstraint!
    @IBOutlet weak var viewWelcomeYPosition: NSLayoutConstraint!
    @IBOutlet weak var viewInfoYPosition: NSLayoutConstraint!
    @IBOutlet weak var btnStartYPosition: NSLayoutConstraint!
    ///IBOutlets of views
    @IBOutlet weak var viewWelcome: UIView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
    private var isFirstTime = true
	var interactor: IHomeInteractor?
	var router: IHomeRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isFirstTime {
            self.animate()
        }
    }
    
    private func setUpViews(){
        self.btnStart.layer.cornerRadius = 10
        self.viewInfo.layer.borderWidth = 2
        self.viewInfo.layer.borderColor = UIColor.white.cgColor
        self.viewInfo.layer.cornerRadius = 10
        
        self.lblWelcome.text = HomeModel.Constants.welcome
        self.lblInfo.text = HomeModel.Constants.info
        self.lblName.text = HomeModel.Constants.name
        self.lblDescription.text = HomeModel.Constants.description
        self.btnStart.setTitle(HomeModel.Constants.start, for: .normal)
    }
    
    private func animate(){
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            self.imgMeliYPosition.constant -= self.deviceSize.height * 0.35
            self.imgMeliWidth.constant = 150
            self.viewWelcome.alpha = 1
            self.viewWelcomeYPosition.constant -= self.deviceSize.height * 0.2
            self.viewInfo.alpha = 1
            self.viewInfoYPosition.constant -= self.deviceSize.height * 0.1
            self.btnStart.isHidden = false
            self.btnStart.alpha = 1
            self.btnStartYPosition.constant -= self.deviceSize.height * 0.15
            self.view.layoutIfNeeded()
        }, completion: {(finished:Bool) in
            self.isFirstTime = false
        })
    }
}

extension HomeViewController: IHomeViewController {
	
}

