//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class ClientTableView: UITableViewController {
    
    var filteredClients = [ClientModel]()
    var clients = [ClientModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
    
        
        clients = [
            ClientModel(clientName:"client1", clientId: 1),
            ClientModel(clientName:"client2", clientId: 2),
            ClientModel(clientName:"client1", clientId: 3),
            ClientModel(clientName:"client2", clientId: 4),
            ClientModel(clientName:"client1", clientId: 5),
            ClientModel(clientName:"client2", clientId: 6),
            ClientModel(clientName:"client1", clientId: 7),
            ClientModel(clientName:"client2", clientId: 8),
            ClientModel(clientName:"client1", clientId: 9)
        ]
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredClients.count
        }
        return clients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        var client: ClientModel
        
        if searchController.active && searchController.searchBar.text != "" {
            client = filteredClients[indexPath.row]
            cell.textLabel!.text = client.clientName
        } else {
            client = clients[indexPath.row]
            cell.textLabel!.text = client.clientName
        }
        
        
        return cell
    }
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredClients = clients.filter({ (client: ClientModel) -> Bool in
            return client.clientName.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        myTableView.reloadData()
    }
    
}
extension ClientTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}