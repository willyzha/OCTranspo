//
//  ViewController.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-21.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UITableViewController,  UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate  {

    var busStops = [BusStopModel]()
    var filteredBusStops = [BusStopModel]()
    var filtering = false
    var coreLocationController:CoreLocationController?
    
    //@IBOutlet weak var busStopTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bus Stops"
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.coreLocationController     = CoreLocationController()
        
        let manager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }

    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            managedContext.deleteObject(busStops[indexPath.row] as NSManagedObject)
            busStops.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"BusStop")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [BusStopModel]?
        
        if let results = fetchedResults {
            busStops = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredBusStops.count
        } else {
            return self.busStops.count
        }
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("BusStopCell") as StopTableViewCell
        
            //var candy : Candy
        
            if tableView == self.searchDisplayController!.searchResultsTableView {
                let person = filteredBusStops[indexPath.row]
                //cell.textLabel!.text = person.valueForKey("name") as String?
                cell.stopName.text = person.getName()
                cell.stopCode.text = person.getCodeAsString()
                self.filtering = true
            }else {
                let person = busStops[indexPath.row]
                //cell.textLabel!.text = person.valueForKey("name") as String?
                cell.stopName.text = person.getName()
                cell.stopCode.text = person.getCodeAsString()
                self.filtering = false
            }
        
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func loadButtonClick(sender: AnyObject) {
        LoadBusStopData()
    }
    
    func LoadBusStopData(){
 
        var busStops: [BusStop] = FileReader.parseBusStopCSV("stops", fileExtension: "txt")
        
        for stop in busStops {
            
            println(stop.toString())
            
            saveBusStop(stop.getName(), code: stop.getCode(), id: stop.getId(), lat: stop.getLat(), long: stop.getLong(), tag: stop.getTag())
        }
        
        self.tableView.reloadData()
        
    }
    
    func saveBusStop(name: String, code: Float, id: String, lat: Float, long: Float, tag: String) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.insertNewObjectForEntityForName("BusStop",inManagedObjectContext:managedContext) as BusStopModel
        
        //3
        entity.name = name
        entity.id = id
        entity.code = code
        entity.lat = lat
        entity.long = long
        entity.searchTags = tag
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        //5
        busStops.append(entity)
    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredBusStops = self.busStops.filter({( busStop: BusStopModel) -> Bool in
            //var categoryMatch = (scope == "All") || (busStop.category == scope)
            //var stringMatch = busStop.name.lowercaseString.rangeOfString(searchText.lowercaseString)
            //return (stringMatch != nil) //&& categoryMatch
            
            return busStop.searchMatch(searchText)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        println(coreLocationController?.getLocation())
        if filtering == false {
            println(self.busStops[indexPath.row].toString())
        }else{
            println(self.filteredBusStops[indexPath.row].toString())
        }
    }
}