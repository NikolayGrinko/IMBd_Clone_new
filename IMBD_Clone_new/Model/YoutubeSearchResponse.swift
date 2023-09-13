//
//  YoutubeSearchResponse.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 13.09.2023.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: idVideoElement
}

struct idVideoElement: Codable {
    let kind: String
    let videoId: String
}
