//
//  Section.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/9/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

//import Foundation

struct Section {
    var heading: String
    var items: [String]
    
    init(title: String, objects : [String]) {
        heading = title
        items = objects
    }
}

