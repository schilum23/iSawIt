//
//  Seasons.swift
//  iSawIt
//
//  Created by Oliver Rosner on 06.09.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import Foundation
import CoreData

class Seasons: NSManagedObject {

    @NSManaged var seasonImageLink: String
    @NSManaged var seasonName: String
    @NSManaged var seasonSortNumber: NSNumber
    @NSManaged var seasonText: String
    @NSManaged var serie: Series
    @NSManaged var episodes: NSSet

}
