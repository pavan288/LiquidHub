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

class ClientTableView: UITableViewController {
    
    var filteredClients = [ClientModel]()
    var clients = [ClientModel]()
    let searchController = UISearchController(searchResultsController: nil)
    var NumberOfRows = 0
 
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
    
        clients = [
         /*   ClientModel(clientName:"client1", clientId: 1, clientPh: "9876543210", clientEmail: "client1@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr1", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr1@xyz.com"),
            ClientModel(clientName:"client2", clientId: 2, clientPh: "9876543210", clientEmail: "client2@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr2", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr2@xyz.com"),
            ClientModel(clientName:"client1", clientId: 3, clientPh: "9876543210", clientEmail: "client3@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr3", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr3@xyz.com"),
            ClientModel(clientName:"client2", clientId: 4, clientPh: "9876543210", clientEmail: "client4@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr4", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr4@xyz.com"),
            ClientModel(clientName:"client1", clientId: 5, clientPh: "9876543210", clientEmail: "client5@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr5", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr5@xyz.com"),
            ClientModel(clientName:"client2", clientId: 6, clientPh: "9876543210", clientEmail: "client6@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr6", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr6@xyz.com"),
            ClientModel(clientName:"client1", clientId: 7, clientPh: "9876543210", clientEmail: "client7@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr7", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr7@xyz.com"),
            ClientModel(clientName:"client2", clientId: 8, clientPh: "9876543210", clientEmail: "client8@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr8", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr8@xyz.com"),
            ClientModel(clientName:"client1", clientId: 9, clientPh: "9876543210", clientEmail: "client9@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr8", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr8@xyz.com") */
        ]
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
            let client =  ClientModel(clientName:"client2", clientId: 8, clientPh: "9876543210", clientEmail: "client8@xyz.com", LHProjMgrName: "LHProjectMgr1", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr8", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr8@xyz.com")
            
            client.clientName = readableJSON[0]["projectDetails"]["client"].string! as String
            client.clientId = readableJSON[0]["projectDetails"]["id"].double!
            client.clientPh = readableJSON[0]["projectDetails"]["clientcontact"].string!
            client.LHProjMgrName = readableJSON[0]["projectDetails"]["projectmanager"].string!
            
            clients.append(ClientModel(clientName:"\(client.clientName)", clientId: client.clientId, clientPh: "\(client.clientPh)", clientEmail: "client8@xyz.com", LHProjMgrName: "\(client.LHProjMgrName)", LHProjMgrPhone: "9876543210", LHProjMgrEmail: "lhprojmgr1@xyz.com", LHClientMgrName: "LHClientMgr8", LHClientMgrPhone: "9876543210", LHClientMgrEmail: "lhclientmgr8@xyz.com"))
        }
    }
    

    

    

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredClients.count
        }
        return clients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ClientCell
        var client: ClientModel
        
        if searchController.active && searchController.searchBar.text != "" {
            client = filteredClients[indexPath.row]
            cell.cName!.text = client.clientName
        } else {
            client = clients[indexPath.row]
            cell.cName!.text = client.clientName
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
    
    
    @IBAction func DetailsPressed(sender: UIButton) {
       // self.performSegueWithIdentifier("ClientDetailSegue", sender: sender)
    }
    
    //segue
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "ClientDetailSegue" {
            let indexPath : NSIndexPath
            if let button = sender as? UIButton {
                let cell = button.superview?.superview as! UITableViewCell
                indexPath = self.tableView.indexPathForCell(cell)!
            
            let destination = segue.destinationViewController as? ClientDetails
            var client: ClientModel
            client = clients[indexPath.row]
            
            let cellName = client.clientName
            let cellPh = client.clientPh
            let cellEmail = client.clientEmail
                
                let projcellName = client.LHProjMgrName
                let projcellPh = client.LHProjMgrPhone
                let projcellEmail = client.LHProjMgrEmail
                
                let clientcellName = client.LHClientMgrName
                let clientcellPh = client.LHClientMgrPhone
                let clientcellEmail = client.LHClientMgrEmail
            
            destination!.tempName = cellName
            destination!.tempPh = cellPh
                destination!.tempEmail = cellEmail
                
                destination!.tempProjMgrName = projcellName
                destination!.tempProjMgrPhone = projcellPh
                destination!.tempProjMgrEmail = projcellEmail
                
                destination!.tempClientMgrName = clientcellName
                destination!.tempClientMgrPhone = clientcellPh
                destination!.tempClientMgrEmail = clientcellEmail
                
            }
        }
    } 
    
    @IBAction func cancelToClientTableView(segue:UIStoryboardSegue) {
    }
}
extension ClientTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}