//
//  Enum.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/25/24.
//

import Foundation

enum FilterOption: String, CaseIterable {
  case all, complete, incomplete
}

enum SortByOption: String, CaseIterable, Hashable {
  case dueDate = "dueDate"
  case createdDate = "createdDate"
}

enum SortOrderOption: String, CaseIterable, Hashable {
  case ascending = ""
  case descending = "-"
}
