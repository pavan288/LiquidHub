//
//  ProjectDetails.swift
//  Liquid
//
//  Created by Pavan Powani on 6/20/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

class ProjectDetails: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var pieChartView: PieChartView!

    @IBOutlet weak var compTableView: UITableView!

    let components = ["C1", "C2", "C3", "C4", "C5", "C6"]
    let componentDetail = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    var projects = [ProjectModel]()
    
    override func viewDidLoad() {
        
        projects = []
        
        setChart(components, values: componentDetail)
        parseJSON()
    }
    
    func parseJSON(){
        for i in 7...8{
            let url = NSURL(string: "http://54.169.229.225:8080/LEM/lem/component/api/componentListByProjectId?projectId=\(i)")
            let jsonData = try? NSData(contentsOfURL: url!, options: [])
            let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let project = ProjectModel(projectName: "",projectId: 0, projectDomain: "")
            project.projectName = readableJSON[0]["projectDetails"]["name"].string! as String
            project.projectId = readableJSON[0]["projectDetails"]["id"].double!
            project.projectDomain = readableJSON[0]["projectDetails"]["project_domain"].string!
            projects.append(ProjectModel(projectName: "\(project.projectName)",projectId: project.projectId,projectDomain: project.projectDomain))
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        pieChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Components")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(150)+100)
            let green = Double(arc4random_uniform(150)+100)
            let blue = Double(arc4random_uniform(150)+100)
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = compTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ComponentCell
        
        cell.compName!.text = components[indexPath.row]
        cell.compHours!.text = String(componentDetail[indexPath.row])
//        cell.compTech!.text = String()
        
        
        return cell
    }
    
    
  
}
