//
//  DessertDetailsViewModel_Tests.swift
//  CakeTests
//
//  Created by Aaron Wilson on 12/10/23.
//

import XCTest
@testable import Cake
// Tests were written for older version of the app. Will return to rewrite test suite.

final class DessertDetailsViewModel_Tests: XCTestCase {

    var vm: DessertDetailsViewModel?
    
    override func setUpWithError() throws {
        vm = DessertDetailsViewModel(dataService: MockDessertsDataService())
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_DessertDetailsViewModel_DessertDetails_notPlaceholderDetails() async {
//        given
        let testDetails = DessertDetailsModel.placeholderDetails
        let id = "53007"
//        when
        await vm?.fetchDetails(id: id)
//        then
        XCTAssertNotEqual(testDetails, vm?.dessertDetails)
    }
    
    func test_DessertDetailsViewModel_ErrorMessage_isNil() async {
//        given
        let id = "53007"
//        when
        await vm?.fetchDetails(id: id)
//        then
        XCTAssertNil(vm?.errorMessage)
    }

    func test_DessertDetailsViewModel_ErrorMessage_isNotNil() async {
//        given
        vm = nil
        let viewModel = DessertDetailsViewModel(dataService: MockDessertsDataServiceError())
//        when
        await viewModel.fetchDetails(id: "")
//        then
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func test_DessertDetailsViewModel_showAlert_isFalse() async {
//        given
        let falseBool = false
//        when
        await vm?.fetchDetails(id: "")
//        then
        XCTAssertEqual(falseBool, vm?.showAlert)

    }
    
    func test_DessertDetailsViewModel_showAlert_isTrue() async {
//        given
        vm = nil
        let viewModel = DessertDetailsViewModel(dataService: MockDessertsDataServiceError())
//        when
        await viewModel.fetchDetails(id: "")
//        then
        XCTAssertTrue(viewModel.showAlert)
    }
    
    
}
