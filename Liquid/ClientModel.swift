//
//  ClientModel.swift
//  Liquid
//
//  Created by Pavan Powani on 6/15/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation

class ClientModel{
    
    var clientName: String
    var clientId: Double
    var clientPh: String
    var clientEmail: String
    init(clientName: String, clientId: Double, clientPh: String, clientEmail: String){
        
        self.clientName = clientName
        self.clientId = clientId
        self.clientPh = clientPh
        self.clientEmail = clientEmail
}
    
}