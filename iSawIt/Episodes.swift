//
//  Episodes.swift
//  iSawIt
//
//  Created by Oliver Rosner on 06.09.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import Foundation
import CoreData

class Episodes: NSManagedObject {

    @NSManaged var episodeID: String
    @NSManaged var episodeImageLink: String
    @NSManaged var episodeName: String
    @NSManaged var episodeNumber: NSNumber
    @NSManaged var episodeText: String
    @NSManaged var episodeViewed: NSNumber
    @NSManaged var season: Seasons

}
