//
//  Constants.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 13/03/22.
//

import Foundation

struct Constants {
    static let baseUrl = "https://api.stackexchange.com/2.2/"
    static let topQuestionsListAPIURL = "questions?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=10"
    static let questionDetailAPIURL = "questions/<questionID>?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=10&filter=!9_bDDxJY5"
}
