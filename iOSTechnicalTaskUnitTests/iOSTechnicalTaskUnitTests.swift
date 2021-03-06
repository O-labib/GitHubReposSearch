//
//  iOSTechnicalTaskUnitTests.swift
//  iOSTechnicalTaskUnitTests
//
//  Created by mac on 3/6/21.
//

import XCTest
@testable import iOSTechnicalTask

class iOSTechnicalTaskUnitTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testArrayDividedIntoPagesYieldCorrectCount() throws {
        let array = Array(1...20)
        let arrayPages = array.dividedIntoPages(ofSize: 5)
        XCTAssert(arrayPages.count == 4)
    }
    func testReposFilterWithEmptySearchQueryYieldAllRepos() {
        let allRepos = tenMockedRepos()
        let filteredReposNil = allRepos.filtered(forTitlesContaining: nil)
        let filteredReposEmpty = allRepos.filtered(forTitlesContaining: "")
        XCTAssert(allRepos.count == filteredReposNil.count)
        XCTAssert(allRepos.count == filteredReposEmpty.count)
    }
    func testReposPaginatedCorrectly() {
        let repos = tenMockedRepos()
        let paginationResult = repos.paginated(with: PaginationInput(page: 0, itemsPerPage: 2))
        XCTAssert(paginationResult.paginationInfo.totalPagesCount == 5)
        XCTAssert(paginationResult.paginationInfo.hasNext == true)
        XCTAssert(paginationResult.repos.count <= 2)
    }

    func testReposPaginationWithWrongPageYieldNoResults() {
        let repos = tenMockedRepos()
        let paginationResult = repos.paginated(with: PaginationInput(page: 10, itemsPerPage: 2))
        XCTAssert(paginationResult.paginationInfo.hasNext == false)
        XCTAssert(paginationResult.repos.count == .zero)
    }
    
    func testReposPaginationWithLargeItemsPerPageYieldOnePage() {
        let repos = tenMockedRepos()
        let paginationResult = repos.paginated(with: PaginationInput(page: 0, itemsPerPage: 20))
        XCTAssert(paginationResult.paginationInfo.hasNext == false)
        XCTAssert(paginationResult.paginationInfo.totalPagesCount == 1)
    }
}
fileprivate extension iOSTechnicalTaskUnitTests {
    func tenMockedRepos() -> [GithubRepoModel] {
        return [
            mockedRepo(),
            mockedRepo(),
            mockedRepo(),
            mockedRepo(),
            mockedRepo(),
            
            mockedRepo(),
            mockedRepo(),
            mockedRepo(),
            mockedRepo(),
            mockedRepo(),
        ]
    }
    func mockedRepo() -> GithubRepoModel {
        GithubRepoModel()
    }
}
