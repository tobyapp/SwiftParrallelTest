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
    
    var testArrayOne = [ [1,2,3] , [4,5,6], [7,8,9] , [10,11,12], [13,14,15] , [16,17,18], [19,20,21] , [22,23,24], [1,2,3] , [4,5,6], [7,8,9] , [10,11,12], [13,14,15] , [16,17,18], [19,20,21] , [22,23,24] ]
    var testArrayTwo = [ [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12], [7,9,11] , [8,10,12] ]
    
    var totalArray = [Int]()

    let numberOfArrays = 2
    let operationQueue = NSOperationQueue()

//    func splitMatrix(splitBy: Int, arrayToSplit: [Array<Int>]) {
//        let x = arrayToSplit.count / splitBy
//        let tempArrayOne = arrayToSplit[]
//    }
    
    func calculateMatrix() {

        let startTime = NSDate()
        let processes = 4
        let segments = testArrayOne.count / processes // how many processes we want to use
        //let dividerArray = Array(0.stride(to: testArrayOne.count + 1, by: segments))
   

        
        //print("divider array = \(dividerArray)")
        
//        for i in 0 ..< dividerArray.count {
//            if i != dividerArray.count-1 {
//                let arrayOne = testArrayOne[dividerArray[i] ... (dividerArray[i+1]-1)]
//                //print("arrayOne : \(arrayOne)")
//                let arrayTwo = testArrayTwo[dividerArray[i] ... (dividerArray[i+1]-1)]
//                //print("arrayTwo : \(arrayTwo)")
//                addToQue(arrayOne[0], arrayTwo: arrayTwo[0], startTime: startTime, operationNumber: i)
//            }
        
        splitMatrix(processes: processes)
    }
    
    func splitMatrix(processes numberOfArrays: Int) { //, matrixOne : [Array<Int>], matrixTwo: [Array<Int>]
        let numOfelementsInArray = testArrayOne.count / numberOfArrays
        var matrixElement = 0
        var tempArray = [[Array<Int>]]()
        print("number of elements in each array is : \(numOfelementsInArray)")
        for i in 0 ..< numberOfArrays {
            print("array number : \(i+1)")
            var tempMatrix = [Array<Int>]()
            for _ in 0 ..< numOfelementsInArray {
                tempMatrix.append(testArrayOne[matrixElement])
                matrixElement = matrixElement + 1
            }
            //print(tempMatrix)
            tempArray.append(tempMatrix)
        }
        print(tempArray)
    }
    
    func addToQue(arrayOne: [Int], arrayTwo: [Int], startTime: NSDate, operationNumber: Int) {
        let operation = NSBlockOperation() {
            print("going to multiply \(arrayOne) by \(arrayTwo)")
            //self.multiplyMatricie(arrayOne, maTwo: arrayTwo)
            self.multiplySingleMatricie(arrayOne, maTwo: arrayTwo)
        }
        operation.completionBlock = {
            //print("done operation \(operNumber)")
            self.printTime(startTime)
        }
        operationQueue.addOperation(operation)
    }
    
    // multiply two single matricies
    func multiplySingleMatricie(maOne: [Int], maTwo: [Int]) {
        var total = 0
        for index in 0 ..< maOne.count {
            total += maOne[index] * maTwo[index]
        }
        print("total : \(total)")
        totalArray.append(total)
    }
    
    func printTime(startTime: NSDate) {
        if operationQueue.operationCount == 0 {
            //print("operationsCount = \(operationQueue.operationCount)")
            let endTime = NSDate()
            let timeInterval: Double = endTime.timeIntervalSinceDate(startTime) // <<<<< Difference in seconds (double)
            print("Time to complete operation version: \(timeInterval/0.001) milli-seconds")
        }
    }
    
    func multiplyMatricie(maOne: ArraySlice<[Int]>, maTwo: ArraySlice<[Int]>) {
        var total = 0
        for matrixOne in maOne {
            for matrixTwo in maTwo {
                for index in 0 ..< matrixOne.count {
                    print("multiplying \(matrixOne[index]) by \(matrixTwo[index])")
                    if index == 0 {
                        total = 0
                    }
                    total += matrixOne[index] * matrixTwo[index]
                    //prints results
                    if index  == (matrixOne.count - 1) || index == (matrixTwo.count - 1) {
                        print("total : \(total)")
                    }
                }
            }
        }
    }

    func test() {
        for var index = 0; index < testArrayOne.count; ++index {
            print(testArrayOne[index][index])
        }
    }
}
