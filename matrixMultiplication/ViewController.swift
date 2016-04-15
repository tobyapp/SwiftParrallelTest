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
    let test = TestOperationMatrix()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Non parrallel verison
        //nonParrallel.calculateMatrix()
        
        // Using GCD
        //parrallel.calculateMatrix()
        
        // Using NSOperation que
        //operation.calculateMatrix()
        
        //Tetsing the logic of multiplying matricies
        test.calculateMatrix()
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    

}
