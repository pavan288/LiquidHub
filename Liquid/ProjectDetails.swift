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
    
    var projectName: String = ""

    var components = [String]()
    var componentDetail = [Double]()
    var componentsTech = [String]()
    
    override func viewDidLoad() {
        parseJSON()
        setChart(components, values: componentDetail)
    }
    
    func parseJSON(){
        if projectName == "Subaru"{
                let url = NSURL(string: "http://54.169.229.225:8080/LEM/lem/component/api/componentListByProjectId?projectId=8")
                let jsonData = try? NSData(contentsOfURL: url!, options: [])
                let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
                let component = ComponentModel(componentName: "", componentId: 0, compHours: 0, techUsed: "")
            for i in 0...(readableJSON.count-1){
                component.componentName = readableJSON[i]["name"].string! as String
                component.componentId = readableJSON[i]["newComponent"].double!
                component.compHours = readableJSON[i]["totalHours"].double!
                component.techUsed = readableJSON[i]["technology"].string!
                components.append(component.componentName)
                componentDetail.append(component.compHours)
                componentsTech.append(component.techUsed)
            }
        }else if projectName == "InsPro"{
            let url = NSURL(string: "http://54.169.229.225:8080/LEM/lem/component/api/componentListByProjectId?projectId=7")
            let jsonData = try? NSData(contentsOfURL: url!, options: [])
            let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let component = ComponentModel(componentName: "", componentId: 0, compHours: 0, techUsed: "")
            for i in 0...readableJSON.count-1{
            component.componentName = readableJSON[i]["name"].string! as String
            component.componentId = readableJSON[i]["newComponent"].double!
            component.compHours = readableJSON[i]["totalHours"].double!
            component.techUsed = readableJSON[i]["technology"].string!
            components.append(component.componentName)
            componentDetail.append(component.compHours)
            componentsTech.append(component.techUsed)
            }
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
        cell.compTech!.text = componentsTech[indexPath.row]
        
        
        return cell
    }
    
    
  
}
