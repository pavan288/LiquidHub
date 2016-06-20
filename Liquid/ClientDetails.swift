//
//  ClientDetails.swift
//  Liquid
//
//  Created by Pavan Powani on 6/17/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import UIKit

class ClientDetails: UITableViewController {
    
    var clients = [ClientModel]()
    var tempName: String = ""
    var tempPh: String = ""
    var tempEmail: String = ""
    var tempProjMgrName: String = ""
    var tempProjMgrPhone: String = ""
    var tempProjMgrEmail: String = ""
    var tempClientMgrName: String = ""
    var tempClientMgrPhone: String = ""
    var tempClientMgrEmail: String = ""
    
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var clientEmail: UILabel!
    @IBOutlet weak var projectMgrName: UILabel!
    @IBOutlet weak var projectMgrPhone: UILabel!
    @IBOutlet weak var projectMgrEmail: UILabel!
    @IBOutlet weak var clientMgrName: UILabel!
    @IBOutlet weak var clientMgrPhone: UILabel!
    @IBOutlet weak var clientMgrEmail: UILabel!
    
    
    override func viewDidLoad() {
        clientName.text = tempName
        clientPhone.text = tempPh
        clientEmail.text = tempEmail
        
        projectMgrName.text = tempProjMgrName
        projectMgrPhone.text = tempProjMgrPhone
        projectMgrEmail.text = tempProjMgrEmail
        
        clientMgrName.text = tempClientMgrName
        clientMgrPhone.text = tempClientMgrPhone
        clientMgrEmail.text = tempClientMgrEmail
        
        

    }

    

    
}
