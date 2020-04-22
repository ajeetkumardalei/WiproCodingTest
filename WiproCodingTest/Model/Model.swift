//
//  Model.swift
//  WiproCodingTest
//
//  Created by AjeetZone on 11/04/20.
//  Copyright © 2020 AjeetZone. All rights reserved.
//

import Foundation



struct CanadaInfo: Codable {
    var title: String?
    var rows: [Row]?
}

struct Row: Codable {
    var title:String?
    var description:String?
    var imageHref:String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
    
}


