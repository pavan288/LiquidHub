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
    var LHProjMgrName: String
    var LHProjMgrPhone: String
    var LHProjMgrEmail: String
    var LHClientMgrName: String
    var LHClientMgrPhone: String
    var LHClientMgrEmail: String
    
    init(clientName: String, clientId: Double, clientPh: String, clientEmail: String, LHProjMgrName: String, LHProjMgrPhone: String, LHProjMgrEmail: String, LHClientMgrName: String, LHClientMgrPhone: String, LHClientMgrEmail: String){
        
        self.clientName = clientName
        self.clientId = clientId
        self.clientPh = clientPh
        self.clientEmail = clientEmail
        
        self.LHProjMgrName = LHProjMgrName
        self.LHProjMgrPhone = LHProjMgrPhone
        self.LHProjMgrEmail = LHProjMgrEmail

        self.LHClientMgrName = LHClientMgrName
        self.LHClientMgrPhone = LHClientMgrPhone
        self.LHClientMgrEmail = LHClientMgrEmail

        
}
    
}