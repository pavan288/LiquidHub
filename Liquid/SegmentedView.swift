//
//  SegmentedView.swift
//  Liquid
//
//  Created by Pavan Powani on 6/15/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class SegmentedView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    //variables
    let searchController = UISearchController(searchResultsController: nil)
    var filteredProjects = [ProjectModel]()
    var filteredClients = [ClientModel]()
    var filteredAcc = [AcceleratorModel]()
    
    //container outlets
    @IBOutlet weak var ProductContainer: UIView!
    @IBOutlet weak var AccContainer: UIView!
    @IBOutlet weak var ClientContainer: UIView!
    
    

    //Model data
    var projects = [ProjectModel]()
    var accelerators = [AcceleratorModel]()
    var clients = [ClientModel]()
    
  
    
    //search across segments
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
        
        //dummy model data
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
        accelerators = [
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 1),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 2),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 3),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 4),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 5),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 6),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 7),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 8),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 9)
        ]

        clients = [
            ClientModel(clientName:"Client1", clientId: 1),
            ClientModel(clientName:"Client2", clientId: 2),
            ClientModel(clientName:"Client1", clientId: 3),
            ClientModel(clientName:"Client2", clientId: 4),
            ClientModel(clientName:"Client1", clientId: 5),
            ClientModel(clientName:"Client2", clientId: 6),
            ClientModel(clientName:"Client1", clientId: 7),
            ClientModel(clientName:"Client2", clientId: 8),
            ClientModel(clientName:"Client1", clientId: 9)
        ]

        
        
    }
    
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            filteredProjects = projects.filter({ (project: ProjectModel) -> Bool in
                        return project.projectName.lowercaseString.containsString(searchText.lowercaseString)
            })
            break
        case 1:
            filteredAcc = accelerators.filter ({ (acc: AcceleratorModel) -> Bool in
                return acc.acceleratorName.lowercaseString.containsString(searchText.lowercaseString)
            })
            break
        case 2:
            filteredClients = clients.filter ({ (client: ClientModel) -> Bool in
                return client.clientName.lowercaseString.containsString(searchText.lowercaseString)
                
            })
            break
        default:
            break
        }

        
        
        myTableView.reloadData()
    }
    
    
    @IBAction func showComponent(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            ProductContainer.hidden = true
            AccContainer.hidden = false
            ClientContainer.hidden = false
            break
        case 1:
            ProductContainer.hidden = false
            AccContainer.hidden = true
            ClientContainer.hidden = false
            break
        case 2:
            ProductContainer.hidden = false
            AccContainer.hidden = false
            ClientContainer.hidden = true
            break
        
        default:
            break
        }
    }
    
    
    
    
    //tableview implementation
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       var returnValue = 0
        
        
        if (self.searchController.active && searchController.searchBar.text != "") {
            switch(segmentedControl.selectedSegmentIndex){
            case 0:
                returnValue = filteredProjects.count
                break
            case 1:
                returnValue = filteredAcc.count
                break
            case 2:
                returnValue = filteredClients.count
                break
            default:
                break
            }
        }
        else {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            returnValue = projects.count
            break
        case 1:
            returnValue = accelerators.count
            break
        case 2:
            returnValue = clients.count
            break
        default:
            break
        }
            
        }
        
        return returnValue
    }
    
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        let project: ProjectModel
        let acc: AcceleratorModel
        let client: ClientModel
        
        
       if searchController.active && searchController.searchBar.text != "" {
        
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            project = filteredProjects[indexPath.row]
            cell.textLabel!.text = project.projectName
            break
        case 1:
            acc = filteredAcc[indexPath.row]
            cell.textLabel!.text = acc.acceleratorName
            break
        case 2:
            client = filteredClients[indexPath.row]
            cell.textLabel!.text = client.clientName
            break
        default:
            break
        }
        return cell
    }
        else {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            project = projects[indexPath.row]
            cell.textLabel!.text = project.projectName
            break
        case 1:
            acc = accelerators[indexPath.row]
            cell.textLabel!.text = acc.acceleratorName
            break
        case 2:
            client = clients[indexPath.row]
            cell.textLabel!.text = client.clientName
            break
        default:
            break
        }
        
        return cell
        
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            self.performSegueWithIdentifier("Product", sender: self)
            break
        case 1:
            self.performSegueWithIdentifier("Accelerator", sender: self)
            break
        case 2:
            self.performSegueWithIdentifier("Client", sender: self)
            break
        default:
            break
        }

    
        
    }
   

}
/*extension SegmentedView: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
*/
extension SegmentedView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
