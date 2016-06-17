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
    
    var filteredclients = [ClientModel]()
    var clients = [ClientModel]()
    
    
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
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        returnValue = clients.count
        return returnValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let client: ClientModel
        
        client = clients[indexPath.row]
        cell.textLabel!.text = client.clientName
        
        return cell
    }
}

