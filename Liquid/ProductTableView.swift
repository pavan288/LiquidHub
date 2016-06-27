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
    var projects = [ProjectModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
 

    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        //setup accordion table
        //    self.setup()
        
        projects = [
            ProjectModel(projectName:"Project1", projectId: 1),
            ProjectModel(projectName:"Project2", projectId: 2),
            ProjectModel(projectName:"Project1", projectId: 3),
            ProjectModel(projectName:"Project2", projectId: 4),
            ProjectModel(projectName:"Project1", projectId: 5),
            ProjectModel(projectName:"Project2", projectId: 6),
            ProjectModel(projectName:"Project1", projectId: 7),
            ProjectModel(projectName:"Project2", projectId: 8),
            ProjectModel(projectName:"Project1", projectId: 9)
        ]
        
        
        
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
    
}
extension ProductTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
