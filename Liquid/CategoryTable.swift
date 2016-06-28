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

class CategoryTableView:UITableViewController {
    
    var filteredProjects = [ProjectModel]()
     var projects = [ProjectModel]()
    let searchController = UISearchController(searchResultsController: nil)
    var selectedCategory: String = ""
    var NumberOfRows = 0
   
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var Categories = ["Assets & Wealth Managaement","Banking","Commercial","Healthcare","Life Sciences","Insurance"]
    
     override func viewDidLoad() {
  
        projects = []

        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        
         parseJSON()

    }
    
    func parseJSON(){
        for i in 7...8{
        let url = NSURL(string: "http://54.169.229.225:8080/LEM/lem/component/api/componentListByProjectId?projectId=\(i)")
        let jsonData = try? NSData(contentsOfURL: url!, options: [])
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let project = ProjectModel(projectName: "",projectId: 0, projectDomain: "")
            project.projectName = readableJSON[0]["projectDetails"]["name"].string! as String
            project.projectId = readableJSON[0]["projectDetails"]["id"].double!
            project.projectDomain = readableJSON[0]["projectDetails"]["project_domain"].string!
            projects.append(ProjectModel(projectName: "\(project.projectName)",projectId: project.projectId,projectDomain: project.projectDomain))
        }
    }
    
    
     //tableview methods
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredProjects.count
        }
        return Categories.count
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var project = ProjectModel(projectName: "",projectId: 0, projectDomain: "")
        
        if searchController.active && searchController.searchBar.text != "" {
            let cell = tableView.dequeueReusableCellWithIdentifier("Pcell", forIndexPath: indexPath) 
            project = filteredProjects[indexPath.row]
            cell.textLabel?.text = project.projectName
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath) as! CategoryCell
            cell.categoryName.text = Categories[indexPath.row]
            
            if(cell.categoryName.text == project.projectDomain){
            cell.categoryCount.text = String(projects.count)
            }
        
            return cell
        }
        
        
        
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
    @IBAction func cancelToTableView(segue:UIStoryboardSegue) {
    }

 
}
extension CategoryTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
