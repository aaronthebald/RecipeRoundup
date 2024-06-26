//
//  CakeTests.swift
//  CakeTests
//
//  Created by Aaron Wilson on 11/14/23.
//

import XCTest
@testable import Cake

final class CakeTests: XCTestCase {
    let itemCategories = ["Beef", "Chicken", "Pasta", "Seafood", "Dessert"]
    var vm: ItemsListViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = ItemsListViewModel(dataService: MockDessertsDataService(), cacheService: CacheService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }
    
    func test_AllDessertsViewModel_FetchItems_notNil() async {
        
        guard 
            let viewModel = vm,
            let category = itemCategories.randomElement() else {
            XCTFail()
                return
        }
        await viewModel.fetchItems(category: category)
        XCTAssert(viewModel.items.count > 0)
    }
    
//    func test_AllDessertsViewModel_SortDesserts_isSortingCorrectly() async {
////        given
//        let dessert = Dessert(meal: "AAAA", mealThumb: "", id: "")
////        when
//        await vm?.fetchDesserts()
//        vm?.desserts.append(dessert)
////        then
//        XCTAssertTrue(vm?.filteredDesserts.first == dessert)
//    }
//    
//    func test_AllDessertsViewModel_SortDesserts_isSortingCorrectly2() async {
////        given
//        let dessert = Dessert(meal: "ZZZZ", mealThumb: "", id: "")
////        when
//        await vm?.fetchDesserts()
//        vm?.desserts.append(dessert)
////        then
//        XCTAssertFalse(vm?.filteredDesserts.first == dessert)
//    }
//    
//    func test_AllDessertsViewModel_FetchDesserts_showAlertIsFalse() async {
////        given
//        let falseBool = false
////        when
//        await vm?.fetchDesserts()
////        then
//        XCTAssertEqual(vm?.showAlert, falseBool)
//    }
//
//    func test_AllDessertsViewModel_showAlert_isTrue() async {
////        given
//        vm = nil
//        let viewModel = AllDessertsViewModel(dataService: MockDessertsDataServiceError(), cacheService: CacheService())
////        when
//       await viewModel.fetchDesserts()
////        then
//        XCTAssertTrue(viewModel.showAlert)
//        
//    }
//    
//    func test_AllDessertsViewModel_errorMessage_isNotNil() async {
////        given
//        vm = nil
//        let viewModel = AllDessertsViewModel(dataService: MockDessertsDataServiceError(), cacheService: CacheService())
////        when
//        await viewModel.fetchDesserts()
////        then
//        XCTAssertNotNil(viewModel.errorMessage)
//    }
}
