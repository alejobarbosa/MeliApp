//
//  MeliAppUITests.swift
//  MeliAppUITests
//
//  Created by Luis Alejandro Barbosa Lee on 28/03/22.
//

import XCTest
@testable import MeliApp

class MeliAppUITests: XCTestCase {

    
    override func setUp() {
        XCUIApplication().launch()
    }

    //MARK: Test Validate Views
    func testExistViews_firstVC() {
        let app = XCUIApplication()
        let lblWelcome = app.staticTexts["¡Bienvenido!"]
        XCTAssertTrue(lblWelcome.exists)
        let lblKnow = app.staticTexts["Conoce mi información"]
        XCTAssertTrue(lblKnow.exists)
        let lblName = app.staticTexts["Alejandro Barbosa"]
        XCTAssertTrue(lblName.exists)
        let lblInfo = app.staticTexts["iOS Developer\nalejobarbosalee@gmail.com"]
        XCTAssertTrue(lblInfo.exists)
        let btnStart = app.buttons["Empezar"]
        XCTAssertTrue(btnStart.exists)
    }
    
    //MARK: Test Navigation
    func testNavigationSuccess(){
        let app = XCUIApplication()
        app.buttons["Empezar"].tap()
        let tableView = app.tables["Empty list"]
        let tableShown = tableView.waitForExistence(timeout: 5)
        XCTAssert(tableShown)
    }
    
    //MARK: Test Search Product
    func testSearchProduct(){
            let app = XCUIApplication()
            app.buttons["Empezar"].tap()
            app.searchFields["Buscar en Mercado Libre"].clearAndEnterText("iphone")
            app.buttons["Search"].tap()
            let activityIndicator = app.activityIndicators["In progress"]
            let activityIndicatorShown = activityIndicator.waitForExistence(timeout: 5)
            XCTAssert(activityIndicatorShown)
    }
}

extension XCUIElement {
    func clearAndEnterText(_ text: String)
        {
            guard let stringValue = self.value as? String else {
                XCTFail("Tried to clear and enter text into a non string value")
                return
            }

            self.tap()

            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

            self.typeText(deleteString)
            self.typeText(text)
        }
}
