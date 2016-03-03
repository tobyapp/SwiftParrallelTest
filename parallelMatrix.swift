//
//  singleMatrix.swift
//  matrixMultiplication
//
//  Created by Toby Applegate on 02/03/2016.
//  Copyright © 2016 Toby Applegate. All rights reserved.
//


import Cocoa

class parallelMatrix {
    
    //arrays
    var testArrayOne, testArrayTwo: [[Int]]?
    var matrixArrayOne: [[Int]] = []
    var matrixArrayTwo: [[Int]] = []
    var answerArray: [Int] = []
    
    //GCD parameters
    var dispatchGroup:dispatch_group_t = dispatch_group_create() //A group of block objects submitted to a queue for asynchronous invocation.
    var queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) //A dispatch queue is a lightweight object to which your application submits blocks for subsequent execution.
    let concurrentValueQue = dispatch_queue_create("com.tapplegate.matrixMultiplication.valueQue", DISPATCH_QUEUE_CONCURRENT) //que is concurrent (runs multiple things at same time)
    var semaphore:dispatch_semaphore_t = dispatch_semaphore_create(8)
    
    func calculateMatrix() {
        
        self.testArrayOne = [ [1,2,3] , [4,5,6] ]
        self.testArrayTwo = [ [7,9,11] , [8,10,12] ]
        
        mapArrayFromString("/Users/tobyapplegate/Desktop/arrayOne", arrayName: "matrixArrayOne")
        mapArrayFromString("/Users/tobyapplegate/Desktop/arrayTwo", arrayName: "matrixArrayTwo")
        
        print(matrixArrayOne.count)
        print(matrixArrayTwo.count)
        multiplyMatricie()
    }
    
    //convert 2d array in file (which is a string) to 2D int array
    func mapArrayFromString(filePath: String, arrayName: String) {
        
        let matrix = NSString(string:filePath).stringByExpandingTildeInPath
        let matrixFileContent = try? NSString(contentsOfFile: matrix, encoding: NSUTF8StringEncoding)
        
        let matrixString = "\(matrixFileContent!)"
        let matrixStringArray = matrixString.componentsSeparatedByString("],")
        
        for var elements in matrixStringArray {
            elements = elements.stringByReplacingOccurrencesOfString("]", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            elements = elements.stringByReplacingOccurrencesOfString("[", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            let tempMatrixArray = elements.componentsSeparatedByString(",").map{Int($0)!}
            
            if arrayName == "matrixArrayOne" {
                matrixArrayOne.append(tempMatrixArray)
            }
            else {
                matrixArrayTwo.append(tempMatrixArray)
            }
            
        }
    }
    
    //multiply the two matricies together
    
    func saveToArray(answer: Int) {
       
        dispatch_barrier_async(concurrentValueQue) { //write opperation to custom que, only item in que
            self.answerArray.append(answer)
            dispatch_async(self.GlobalMainQueue) { // print notification this is done on main thread
                //print("added \(answer) to answerArray")
            }
        }
    }
    
    func multiplyMatricie() {
        let startTime = NSDate()
        var total = 0
//
//        var dispatchGroup:dispatch_group_t = dispatch_group_create() //A group of block objects submitted to a queue for asynchronous invocation.
//        var queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) //A dispatch queue is a lightweight object to which your application submits blocks for subsequent execution.
//        let concurrentValueQue = dispatch_queue_create("com.tapplegate.matrixMultiplication.valueQue", DISPATCH_QUEUE_CONCURRENT) //que is concurrent (runs multiple things at same time)
//        var semaphore:dispatch_semaphore_t = dispatch_semaphore_create(8)

        
        
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_group_enter(dispatchGroup)
//        //dispatch_group_async(group, queue) { () -> Void in
//        
//        
//        dispatch_async(concurrentValueQue, { () -> Void in
//            print("hello world")
//        })
//        
//        dispatch_group_leave(dispatchGroup)
//        dispatch_semaphore_signal(semaphore)
//        
//        
//        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
        
        
        
        dispatch_async(GlobalUserInitiatedQueue) { //placein background que so main thread isnt blocked
            
            dispatch_group_enter(self.dispatchGroup) // notifys a group that task has started
                for matrixOne in self.matrixArrayOne {
                    for matrixTwo in self.matrixArrayTwo {
                        for var index = 0; index < matrixOne.count; ++index {
                            
                            //resets total to 0 when multiplying new matrix
                            if index == 0 {
                                total = 0
                            }
                            
                            total += matrixOne[index] * matrixTwo[index]
                            
                            // save and print results
                            if index  == (matrixOne.count - 1) {
                                self.saveToArray(total)
                            }
                        }
                    }
                }
            dispatch_group_leave(self.dispatchGroup) //notfiy group that work is done
            
            dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER) // waits until all tasks are complete or until time expires (wont as time is infinite).
          
        dispatch_async(self.GlobalMainQueue) { //all tasks complete, call back main thread to complete clousre
            
            print("all tasks complete")
            let endTime = NSDate()
            let timeInterval: Double = endTime.timeIntervalSinceDate(startTime)
            print("Time to complete parallel version: \(timeInterval/0.001) milli-seconds")
            }
            let endTime1 = NSDate()
            let timeInterval1: Double = endTime1.timeIntervalSinceDate(startTime)
            print("Time to complete parallel version after clousre: \(timeInterval1/0.001) milli-seconds")
        }
        
        
    }
    
    func test() {
        for var index = 0; index < testArrayOne!.count; ++index {
            print(testArrayOne![index][index])
        }
    }
    
        var GlobalMainQueue: dispatch_queue_t {
            return dispatch_get_main_queue()
        }
        
        var GlobalUserInteractiveQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
        }
        
        var GlobalUserInitiatedQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
        }
        
        var GlobalUtilityQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)
        }
        
        var GlobalBackgroundQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
        }
    
}