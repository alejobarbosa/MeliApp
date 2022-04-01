//
//  ProductListViewController.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IProductListViewController {
	var router: IProductListRouter? { get set }
    func showError(message: String)
    func showData()
}

class ProductListViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewProducts: UITableView!
    
	var interactor: IProductListInteractor?
	var router: IProductListRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    private func setUpViews(){
        self.tableViewProducts.delegate = self
        self.tableViewProducts.dataSource = self
        self.tableViewProducts.register(ProductCell.nib,
                                        forCellReuseIdentifier: ProductCell.identifier)
        self.tableViewProducts.separatorStyle = .none
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
    }
    
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    
}

extension ProductListViewController: IProductListViewController {
    func showError(message: String){
        self.showActivityIndicator(show: false)
        self.showErrorView(message: message)
    }
    
    func showData(){
        if (self.interactor?.isNewCall ?? true) {
            self.tableViewProducts.setContentOffset(.zero, animated:true)
        }
        self.showActivityIndicator(show: false)
        self.tableViewProducts.reloadData()
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier,
                                                    for: indexPath) as? ProductCell,
           let product = interactor?.products {
            cell.setData(product: product[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProductCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let productId = self.interactor?.products[indexPath.row].id {
            self.router?.navigateToProductDetail(productId: productId)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.interactor?.getMoreProducts()
        }
    }
	
}

extension ProductListViewController: UISearchBarDelegate {
	
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.showActivityIndicator(show: true)
        self.interactor?.isNewCall = true
        self.interactor?.searchForProduct(text: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}
