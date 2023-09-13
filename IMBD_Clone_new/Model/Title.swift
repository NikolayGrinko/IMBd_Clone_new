//
//  Title.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 03.09.2023.
//

import Foundation

// MARK: Крайнее

struct TrendingTitleResponse: Codable {
    
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let originalTitle: String?
    let image: String?
    let type: String?
    let year: String?
    let releaseDate: String?
    let awards: String?
    let director: String?
}

/*
 "id": "string",
   "title": "string",
   "originalTitle": "string",
   "fullTitle": "string",
   "type": "string",
   "year": "string",
   "image": "string",
   "releaseDate": "string",
   "runtimeMins": "string",
   "runtimeStr": "string",
   "plot": "string",
   "plotLocal": "string",
   "plotLocalIsRtl": true,
   "awards": "string",
   "directors": "string",
   "directorList": [
 */
