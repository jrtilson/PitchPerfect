//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jeff Tilson on 2015-09-30.
//  Copyright © 2015 Jeff Tilson. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(title: String, filePathUrl: NSURL) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}