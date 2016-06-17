//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class ProductTableView:UITableViewController {
    
    var filteredProjects = [ProjectModel]()
     var projects = [ProjectModel]()
    
    
     override func viewDidLoad() {
        
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
    }
    
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         var returnValue = 0
        returnValue = projects.count
        return returnValue
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
         let project: ProjectModel
        
        project = projects[indexPath.row]
        cell.textLabel!.text = project.projectName
        
        return cell
    }
    }

