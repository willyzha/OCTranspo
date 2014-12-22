//
//  ViewController.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-21.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController,  UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate  {

    var busStops = [BusStopModel]()
    var filteredBusStops = [BusStopModel]()
    
    @IBOutlet weak var busStopTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func add(sender: AnyObject) {
        
        /*
        var alert = UIAlertController(title: "New name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.saveName(textField.text)
                self.busStopTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        */
    }


    /*
    func saveName(name: String) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("BusStop",
            inManagedObjectContext:
            managedContext)
        
        let stop = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        stop.setValue(name, forKey: "name")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        people.append(person)
    }
    */
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
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
            //var candy : Candy
        
            if tableView == self.searchDisplayController!.searchResultsTableView {
                let person = filteredBusStops[indexPath.row]
                cell.textLabel!.text = person.valueForKey("name") as String?
            }else {
                let person = busStops[indexPath.row]
                cell.textLabel!.text = person.valueForKey("name") as String?
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
            
            saveBusStop(stop.getName(), code: stop.getCode(), id: stop.getId(), lat: stop.getLat(), long: stop.getLong())
        }
        
        self.busStopTable.reloadData()
        
        /*
        if let o = output {
            println(o)
            
            
            saveBusStop(, code: 8767, id: "AA010", lat: 45.439869, long: -75.695839)
            
            self.busStopTable.reloadData()
            
        }
*/
    }
    
    func saveBusStop(name: String, code: Float, id: String, lat: Float, long: Float) {
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
            var stringMatch = busStop.name.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil) //&& categoryMatch
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
    

        
    
}
    

