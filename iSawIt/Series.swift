//
//  Series.swift
//  iSawIt
//
//  Created by Oliver Rosner on 06.09.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import Foundation
import CoreData

class Series: NSManagedObject {

    @NSManaged var serieFavorite: NSNumber
    @NSManaged var serieID: String
    @NSManaged var serieImage: NSData
    @NSManaged var serieImageLink: NSData
    @NSManaged var seriesName: String
    @NSManaged var seasons: NSSet

}
