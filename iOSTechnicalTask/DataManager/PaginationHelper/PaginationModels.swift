//
//  Models.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import Foundation

struct PaginationInput {
    
    /// pagination is assumed to start at page 0
    var page: Int
    var itemsPerPage: Int = 10

    static var firstPage: PaginationInput {
        return PaginationInput(page: 0)
    }
}

struct PaginationInfo {
    var currentPage: Int
    var itemsPerPage: Int
    var totalPagesCount: Int
    var hasNext: Bool

    var nextPageInput: PaginationInput {
        return PaginationInput(page: currentPage + 1)
    }
}
