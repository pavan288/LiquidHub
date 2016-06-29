//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductTableView:UITableViewController {
    
    var filteredProjects = [ProjectModel]()
    var tempProjects = [ProjectModel]()
    var projects = [ProjectModel]()
    let searchController = UISearchController(searchResultsController: nil)
    var currentProject: String = ""
    
    
 

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        projects = tempProjects
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        
    }

    
    
        //tableview methods
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     if searchController.active && searchController.searchBar.text != "" {
     return filteredProjects.count
     }
     return projects.count
     }
     
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("PCell", forIndexPath: indexPath) as! ProductCell
     var project: ProjectModel
     
     if searchController.active && searchController.searchBar.text != "" {
     project = filteredProjects[indexPath.row]
     cell.pName.text = project.projectName
     } else {
     project = projects[indexPath.row]
     cell.pName.text = project.projectName
     }
     return cell
     }
    
/*    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = myTableView.indexPathForSelectedRow!
        let cell = myTableView.cellForRowAtIndexPath(indexPath)! as! ProductCell
        var project: ProjectModel
        project = projects[indexPath.row]
        cell.pName.text = project.projectName
        currentProject = cell.pName.text!
 
    }*/
    
    
    //search methods
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredProjects = projects.filter({ (project: ProjectModel) -> Bool in
            return project.projectName.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        myTableView.reloadData()
    }
    
    
 
    @IBAction func DetailsPressed(sender: AnyObject) {
        var indexPath: NSIndexPath!
        
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? ProductCell {
                    indexPath = myTableView.indexPathForCell(cell)
                    var project: ProjectModel
                    project = projects[indexPath.row]
                   currentProject = project.projectName
                }
            }
        }
        
        performSegueWithIdentifier("ProjectDetailSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let DVC = segue.destinationViewController as? ProjectDetails
            DVC!.projectName = currentProject
    }

    
    
}
extension ProductTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
