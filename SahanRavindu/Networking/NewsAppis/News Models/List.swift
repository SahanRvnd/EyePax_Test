//
//  List.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation

// MARK: - News
struct NewsItem: Codable {
    var title: [String]?
    var news: [Article]?
    var section: String?
}
