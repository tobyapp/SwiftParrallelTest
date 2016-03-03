//
//  ViewController.swift
//  matrixMultiplication
//
//  Created by Toby Applegate on 29/02/2016.
//  Copyright © 2016 Toby Applegate. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let nonParrallel = singleMatrix()
    let parrallel = parallelMatrix()
    let operation = operationMatrix()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nonParrallel.calculateMatrix()
        parrallel.calculateMatrix()
        operation.calculateMatrix()
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    

}
