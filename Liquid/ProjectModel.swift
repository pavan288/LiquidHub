//
//  Project.swift
//  Liquid
//
//  Created by Pavan Powani on 6/15/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation

class ProjectModel{
    
    var projectName: String
    var projectId: Double
    var projectDomain: String
    
    init(projectName: String, projectId: Double, projectDomain: String){
        
        self.projectName = projectName
        self.projectId = projectId
        self.projectDomain = projectDomain
    }
    
}