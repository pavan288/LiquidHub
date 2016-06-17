//
//  ClientDetails.swift
//  Liquid
//
//  Created by Pavan Powani on 6/17/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import UIKit

class ClientDetails: UIViewController {
    
    var clients = [ClientModel]()
    var tempName: String = ""
    var tempPh: String = ""
    
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        name.text = tempName
        phone.text = tempPh
        
       
        
    }
    
    @IBAction func Back(sender: AnyObject) {
        
    }
    
    
}
