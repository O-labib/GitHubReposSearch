//
//  Models.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import Foundation

struct PaginationInput {
    var page: Int
    var itemsPerPage: Int
}

struct PaginationInfo {
    var currentPage: Int
    var itemsPerPage: Int
    var totalPagesCount: Int
    var hasNext: Bool
}
