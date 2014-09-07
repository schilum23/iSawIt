//
//  SeriesTableViewController.swift
//  iSawIt
//
//  Created by Oliver Rosner on 06.09.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import UIKit
import CoreData

class SeriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchSeries: UISearchBar!
    var series = []
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchSeries.delegate = self
        searchSeries.becomeFirstResponder()
        
        createSerie("81189", name: "Breaking Bad")
        createSerie("23", name: "23")
        createSerie("74845", name: "Weeds")
        createSerie("80379", name: "The Big Bang Theory")
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    
    }
    
    // MARK: - CoreData
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: serieFetchRequest(), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func serieFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Series")
        println("Start request -> SearchText: \(searchText)")
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "seriesName = '\(searchText)'")
            
        }
        
        let sortDescriptor = NSSortDescriptor(key: "seriesName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func serieExists(id: String) -> Bool {
        
        var fetchRequest = NSFetchRequest(entityName: "Series")
        if context != nil {
            fetchRequest.predicate = NSPredicate(format: "serieID = '\(id)'")
            series = context!.executeFetchRequest(fetchRequest, error: nil) as NSArray!
            
            return (series.count > 0)
        }
        
        return true
        
    }
    
    func createSerie(id: String, name: String) {
       
        if context != nil && !serieExists(id) {
            let entityDescripition = NSEntityDescription.entityForName("Series", inManagedObjectContext: context!)
            let newSerie = Series(entity: entityDescripition!, insertIntoManagedObjectContext: context!)
            newSerie.seriesName = name
            newSerie.serieID = id
            context?.save(nil)
        }
        
    }
    
    // MARK: - SearchBar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        tableView.reloadData()

    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar!) {
        self.searchText = ""

        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        tableView.reloadData()

    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let serie = fetchedResultController.objectAtIndexPath(indexPath) as Series
        cell.textLabel?.text = serie.seriesName
        return cell
    }

}
