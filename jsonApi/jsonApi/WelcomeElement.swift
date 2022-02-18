//
//  Modale.swift
//  jsonApi
//
//  Created by vishnu saini on 17/02/22.

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias Welcome = [WelcomeElement]

