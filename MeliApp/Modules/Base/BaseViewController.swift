//
//  ViewController.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 28/03/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeNavBar()
    }
    
    ///Customization of the navigation bar
    private func customizeNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.AppColor.yellow
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: ProductListModel.Constants.backImage),
            style: .plain,
            target: self,
            action: #selector(self.backVc)
        )
        navigationController?.navigationBar.tintColor = UIColor.black
        let img = UIImageView()
        img.image = UIImage(named: ProductListModel.Constants.meliHorizontal)
        img.contentMode = .scaleAspectFill
        navigationItem.titleView = img
    }
    
    @objc func backVc(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func en(){
        self.navigationController?.popViewController(animated: true)
    }
    
    ///Method to show an activity indicator
    public func showActivityIndicator(show:Bool) {
        DispatchQueue.main.async {
            if show {
                if let viewIndicator = self.view.viewWithTag(99) {
                    viewIndicator.removeFromSuperview()
                }
                let viewContainer = UIView(frame: CGRect(x: 0, y: 0,
                                                         width: ScreenSize.screenWidth,
                                                         height: ScreenSize.screenHeight))
                viewContainer.tag = 99
                viewContainer.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 0.91)
                viewContainer.frame.origin = CGPoint(x: 0, y: 0)
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.color = .white
                activityIndicator.startAnimating()
                activityIndicator.center = viewContainer.center
                viewContainer.addSubview(activityIndicator)
                self.view.addSubview(viewContainer)
            } else {
                let viewIndicator = self.view.viewWithTag(99)
                viewIndicator?.removeFromSuperview()
            }
        }
    }
    
    ///Method to show an alert controller
    public func showErrorView(message: String, handlerAccept: ((UIAlertAction) -> Void)? = nil){
        let alertController = UIAlertController(title: GenericConstants.ErrorView.errorTitle,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.addAction(UIAlertAction(title: GenericConstants.acceptTitle,
                                                style: .default,
                                                handler: handlerAccept))
        self.present(alertController, animated: true, completion: nil)
    }


}

