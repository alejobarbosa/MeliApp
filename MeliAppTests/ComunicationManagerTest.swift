//
//  ComunicationManagerTest.swift
//  MeliAppTests
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//

import XCTest
@testable import MeliApp

class ComunicationManagerTest: BaseTests {

    let comunicationManager = MockComunicationManager()
    enum ExpectedValues {
        static let productsCount = 2
    }
    
    //MARK: Search Product Service
    ///Tests Search Product with success response
    func testSearchForProduct_withSuccessResponse() {
        let expectation = self.expectation(description: "testSearchProduct")
        let data = getData(fromJSONFile: Constants.mockProducts)
        comunicationManager.data = data ?? Data()
        comunicationManager.searchForProduct(query: "iphone",
                                             offset: 0,
                                             handler: { (response) in
            switch response {
            case .success(let products):
                DispatchQueue.main.async {
                    let p = products.products
                    XCTAssertEqual(p.count, ExpectedValues.productsCount)
                    expectation.fulfill()
                }
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    ///Tests Search Product with failure response
    func testSearchForProduct_withFailureResponse() {
        let expectation = self.expectation(description: "testSearchProduct")
        let data = getData(fromJSONFile: Constants.mockProducts)
        comunicationManager.data = data ?? Data()
        comunicationManager.shouldReturnError = true
        comunicationManager.searchForProduct(query: "iphone",
                                             offset: 0,
                                             handler: { (response) in
            switch response {
            case .success(_):
                XCTFail()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
                break
            }
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    //MARK: Product Detail Service
    ///Tests Get Product Detail with success response
    func testGetProductDetail_withSuccessResponse() {
        let expectation = self.expectation(description: "testProductDetail")
        let data = getData(fromJSONFile: Constants.mockProductDetail)
        comunicationManager.data = data ?? Data()
        comunicationManager.getProductDetail(forProduct: "iphone",
                                             handler: { (response) in
            switch response {
            case .success(let productDetail):
                DispatchQueue.main.async {
                    XCTAssertNotNil(productDetail.id)
                    expectation.fulfill()
                }
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    ///Tests Search Product with failure response
    func testGetProductDetail_withProductsFailureResponse() {
        let expectation = self.expectation(description: "testProductDetail")
        let data = getData(fromJSONFile: Constants.mockProducts)
        comunicationManager.data = data ?? Data()
        comunicationManager.shouldReturnError = true
        comunicationManager.getProductDetail(forProduct: "iphone",
                                             handler: { (response) in
            switch response {
            case .success(_):
                XCTFail()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
                break
            }
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
