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
    let urlString = "http://54.169.229.225:8080/LEM/lem/api/login/homePage"
    var NumberOfRows = 0
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var Categories = ["Assets & Wealth Managaement","Banking","Commercial","Healthcare","Life Sciences","Insurance"]
    
     override func viewDidLoad() {
        
        parseJSON()
        
        projects = [
            ProjectModel(projectName:"Project1", projectId: 1, projectDomain: "Assets & Wealth Management"),
            ProjectModel(projectName:"Project2", projectId: 2, projectDomain: "Banking"),
            ProjectModel(projectName:"Project1", projectId: 3, projectDomain: "Commercial"),
            ProjectModel(projectName:"Project2", projectId: 4, projectDomain: "Insurance"),
            ProjectModel(projectName:"Project1", projectId: 5, projectDomain: "Healthcare"),
            ProjectModel(projectName:"Project2", projectId: 6, projectDomain: "Life Sciences"),
            ProjectModel(projectName:"Project1", projectId: 7, projectDomain: "Healthcare"),
            ProjectModel(projectName:"Project2", projectId: 8, projectDomain: "Banking"),
            ProjectModel(projectName:"Project1", projectId: 9, projectDomain: "Insurance")
        ]

        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false

    }
    
    func parseJSON(){
        
        let url = NSURL(string: urlString)
        let jsonData = try? NSData(contentsOfURL: url!, options: [])
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        NumberOfRows = readableJSON.count
        let project = ProjectModel(projectName: "",projectId: 0, projectDomain: "")
        
        
        for i in 0...(NumberOfRows-1){
            project.projectName = readableJSON[i]["name"].string! as String
            project.projectId = readableJSON[i]["id"].double!
            project.projectDomain = readableJSON[i]["project_domain"].string!
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
                 var project: ProjectModel
        
        if searchController.active && searchController.searchBar.text != "" {
            let cell = tableView.dequeueReusableCellWithIdentifier("Pcell", forIndexPath: indexPath) 
            project = filteredProjects[indexPath.row]
            cell.textLabel?.text = project.projectName
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath) as! CategoryCell
            cell.categoryName.text = Categories[indexPath.row]
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
