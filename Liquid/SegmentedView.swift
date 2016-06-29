//
//  SegmentedView.swift
//  Liquid
//
//  Created by Pavan Powani on 6/15/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit


class SegmentedView: UIViewController {

   
    @IBOutlet weak var productView: UITableView!
    @IBOutlet weak var clientView: UITableView!
 
    
   
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.productView.hidden = false
            self.clientView.hidden = true
            break
        case 1:
            productView.hidden = true
            clientView.hidden = false
            break
        default:
            break
        }
    }
    
    
  
}



