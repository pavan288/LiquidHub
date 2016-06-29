//
//  ComponentModel.swift
//  Liquid
//
//  Created by Pavan Powani on 6/15/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation

class ComponentModel{
    
    var componentName: String
    var componentId: Double
    var compHours: Double
    var techUsed: String
    
    init(componentName: String, componentId: Double, compHours: Double, techUsed: String){
        
        self.componentName = componentName
        self.componentId = componentId
        self.compHours = compHours
        self.techUsed = techUsed
    }
    
}