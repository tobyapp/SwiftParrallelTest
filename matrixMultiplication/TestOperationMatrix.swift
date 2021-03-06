//
//  operationMatrix.swift
//  matrixMultiplication
//
//  Created by Toby Applegate on 02/03/2016.
//  Copyright © 2016 Toby Applegate. All rights reserved.
//

import Foundation
import Cocoa

class TestOperationMatrix {
    
    var testArrayOne = [ [1,2,3], [4,5,6], [7,8,9], [10,11,12], [13,14,15], [16,17,18], [19,20,21], [22,23,24], [25,26,27], [28,29,30], [31,32,33], [34,35,36], [37,38,39] , [40,41,42], [43,44,45] , [46,47,48]]
    var testArrayTwo = [ [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12]]
    
//    var testArrayOne = [ [1,2,3], [4,5,6]]
//   var testArrayTwo = [ [7,9,11] , [8,10,12]]
    var totalArray = [Int]()
    let operationQueue = NSOperationQueue.mainQueue()
    
    func calculateMatrix() {

        let startTime = NSDate()
        let processes = 4
        
        operationQueue.maxConcurrentOperationCount = processes //defines max number of operations that can excecute at the same time
        // Default is one

        let splitArrayOne = splitMatrix(processes: processes, matrix: testArrayOne)
        let splitArrayTwo = splitMatrix(processes: processes, matrix: testArrayTwo)
        
        //iterate through the two nested arrays of matricies and multiply them e.g. 1.1 * 2.1, 1.1 * 2.2, 1.2 * 2.1, 1.2 * 2.2 (see link for more info)
        var operationNumberCount = 1
        for count in 0..<splitArrayOne.count {
            for count1 in 0..<splitArrayTwo.count {
                addToQue(splitArrayOne[count], arrayTwo: splitArrayTwo[count1], startTime: startTime, operationNumber: operationNumberCount)
                operationNumberCount += 1
            }
        }
    }
    
    func splitMatrix(processes numberOfArrays: Int, matrix array: [Array<Int>]) -> [[Array<Int>]]{
        let numOfelementsInArray = array.count / numberOfArrays
        var matrixElement = 0
        var tempArray = [[Array<Int>]]()
        for _ in 0 ..< numberOfArrays {
            var tempMatrix = [Array<Int>]()
            for _ in 0 ..< numOfelementsInArray {
                tempMatrix.append(array[matrixElement])
                matrixElement = matrixElement + 1
            }
            tempArray.append(tempMatrix)
        }
        return tempArray
    }
    
    // Add work to NSOperation que
    func addToQue(arrayOne: [Array<Int>], arrayTwo: [Array<Int>], startTime: NSDate, operationNumber: Int) {
        
        let operation = op(arrayOne: arrayOne, arrayTwo: arrayTwo)
        operation.completionBlock = {
            self.printTime(startTime)
            
            //print("done operation \(operationNumber)")
            //print(self.totalArray)
        }
        operationQueue.addOperation(operation)
    }
    
    // Print finish time
    func printTime(startTime: NSDate) {
        //prints time when no work left in the que
        if operationQueue.operationCount == 0 {
            let endTime = NSDate()
            let timeInterval: Double = endTime.timeIntervalSinceDate(startTime) // Difference in seconds (double)
            print("Time to complete : \(timeInterval/0.001) milli-seconds")
        }
    }
    
    
}

class op: NSBlockOperation {
    
    var totalArray = [Int]()
    var maOne: [Array<Int>]?
    var maTwo: [Array<Int>]?
    
    init(arrayOne: [Array<Int>], arrayTwo: [Array<Int>]){
        maOne = arrayOne
        maTwo = arrayTwo
    }
    
    override func main() {
        multiplyMatricie(maOne!, maTwo: maTwo!)
        print(totalArray)
    }
    
    // Multiple two differernt matracies
    func multiplyMatricie(maOne: [Array<Int>], maTwo: [Array<Int>]) {
        var total = 0
        for matrixOne in maOne {
            for matrixTwo in maTwo {
                for index in 0 ..< matrixOne.count {
                    if index == 0 {
                        total = 0
                    }
                    total += matrixOne[index] * matrixTwo[index]
                    if index  == (matrixOne.count - 1) || index == (matrixTwo.count - 1) {
                        //print("total : \(total)")
                        totalArray.append(total)
                        print(totalArray)
                    }
                }
            }
        }
    }

    
}
