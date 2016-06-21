//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class ProductTableView:UITableViewController {
    
    var filteredProjects = [ProjectModel]()
     var projects = [ProjectModel]()
    let searchController = UISearchController(searchResultsController: nil)
     let cells = SwiftyAccordionCells()
    
    var previouslySelectedHeaderIndex: Int?
    var selectedHeaderIndex: Int?
    var selectedItemIndex: Int?
    
    @IBOutlet weak var myTableView: UITableView!
    
     override func viewDidLoad() {
        //setup accordion table
        self.setup()
        
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
    }
  /*    //tableview methods
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
    */
    
  //setup the table items
    func setup() {
     //   self.enter.layer.cornerRadius = 4
        
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Assets Management"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 2"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Banking"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 1"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Commercial"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 2"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "HealthCare"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 2"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Life Sciences"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 2"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Insurance"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Project 2"))

        
    }
    
    //setup accordion table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.cells.items[indexPath.row]
        let value = item.value as? String
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PCell") {
            cell.textLabel?.text = value
            
            if item as? SwiftyAccordionCells.HeaderItem != nil {
                cell.backgroundColor = UIColor.whiteColor()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = self.cells.items[indexPath.row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            return 60
        } else if (item.isHidden) {
            return 0
        } else {
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.cells.items[indexPath.row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            if self.selectedHeaderIndex == nil {
                self.selectedHeaderIndex = indexPath.row
            } else {
                self.previouslySelectedHeaderIndex = self.selectedHeaderIndex
                self.selectedHeaderIndex = indexPath.row
            }
            
            if let previouslySelectedHeaderIndex = self.previouslySelectedHeaderIndex {
                self.cells.collapse(previouslySelectedHeaderIndex)
            }
            
            if self.previouslySelectedHeaderIndex != self.selectedHeaderIndex {
                self.cells.expand(self.selectedHeaderIndex!)
            } else {
                self.selectedHeaderIndex = nil
                self.previouslySelectedHeaderIndex = nil
            }
            
            self.myTableView.beginUpdates()
            self.myTableView.endUpdates()
            
        } else {
            if indexPath.row != self.selectedItemIndex {
                if let selectedItemIndex = self.selectedItemIndex {
                    let previousCell = self.myTableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedItemIndex, inSection: 0))
                    previousCell?.accessoryType = UITableViewCellAccessoryType.None
                }
                
                self.selectedItemIndex = indexPath.row
            }
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
extension ProductTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
