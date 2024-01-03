//
//  CakeTests.swift
//  CakeTests
//
//  Created by Aaron Wilson on 11/14/23.
//

import XCTest
@testable import Cake

final class CakeTests: XCTestCase {
    
    var vm: AllDessertsViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = AllDessertsViewModel(dataService: MockDessertsDataService(), cacheService: CacheService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }
    
    func test_AllDessertsViewModel_FetchDesserts_notNil() async {
//        given
        let dataArray: [Dessert] = []
//        when
        await vm?.fetchDesserts()
//        then
        XCTAssertNotEqual(dataArray, vm?.desserts)
    }
    
    func test_AllDessertsViewModel_SortDesserts_isSortingCorrectly() async {
//        given
        let dessert = Dessert(meal: "AAAA", mealThumb: "", id: "")
//        when
        await vm?.fetchDesserts()
        vm?.desserts.append(dessert)
        vm?.sortDesserts()
//        then
        XCTAssertTrue(vm?.desserts.first == dessert)
    }
    
    func test_AllDessertsViewModel_SortDesserts_isSortingCorrectly2() async {
//        given
        let dessert = Dessert(meal: "ZZZZ", mealThumb: "", id: "")
//        when
        await vm?.fetchDesserts()
        vm?.desserts.append(dessert)
        vm?.sortDesserts()
//        then
        XCTAssertFalse(vm?.desserts.first == dessert)
    }
    
    func test_AllDessertsViewModel_FetchDesserts_showAlertIsFalse() async {
//        given
        let falseBool = false
//        when
        await vm?.fetchDesserts()
//        then
        XCTAssertEqual(vm?.showAlert, falseBool)
    }

    func test_AllDessertsViewModel_showAlert_isTrue() async {
//        given
        vm = nil
        let viewModel = AllDessertsViewModel(dataService: MockDessertsDataServiceError(), cacheService: CacheService())
//        when
       await viewModel.fetchDesserts()
//        then
        XCTAssertTrue(viewModel.showAlert)
        
    }
    
    func test_AllDessertsViewModel_errorMessage_isNotNil() async {
//        given
        vm = nil
        let viewModel = AllDessertsViewModel(dataService: MockDessertsDataServiceError(), cacheService: CacheService())
//        when
        await viewModel.fetchDesserts()
//        then
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
