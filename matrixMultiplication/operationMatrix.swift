//
//  operationMatrix.swift
//  matrixMultiplication
//
//  Created by Toby Applegate on 02/03/2016.
//  Copyright © 2016 Toby Applegate. All rights reserved.
//

import Foundation
import Cocoa

class operationMatrix {

        var testArrayOne, testArrayTwo: [[Int]]?
        var matrixArrayOne: [[Int]] = []
        var matrixArrayTwo: [[Int]] = []
        let numberOfArrays = 4
        let operationQueue = NSOperationQueue()
        
        func calculateMatrix() {
            mapArrayFromString("/Users/tobyapplegate/Desktop/arrayOne", arrayName: "matrixArrayOne")
            mapArrayFromString("/Users/tobyapplegate/Desktop/arrayTwo", arrayName: "matrixArrayTwo")
            
            let startTime = NSDate()
            
            let processes = 4
            
            let segments = matrixArrayOne.count / processes // how many processes we want to use
            let dividerArray = Array(0.stride(to: matrixArrayOne.count + 1, by: segments))

            for var i = 0; i < dividerArray.count; i++ {
                if i != dividerArray.count-1 {
                    let arrayOne = matrixArrayOne[dividerArray[i] ... (dividerArray[i+1]-1)]
                    let arrayTwo = matrixArrayTwo[dividerArray[i] ... (dividerArray[i+1]-1)]
                    addToQue(arrayOne, arrayTwo: arrayTwo, startTime: startTime, operNumber: i)
                }
            }
    }
    
    func addToQue(arrayOne: ArraySlice<[Int]>, arrayTwo: ArraySlice<[Int]>, startTime: NSDate, operNumber: Int) {
        let operation = NSBlockOperation() {
            self.multiplyMatricie(arrayOne, maTwo: arrayTwo)
        }
        operation.completionBlock = {
            //print("done operation \(operNumber)")
            self.printTime(startTime)
        }
        operationQueue.addOperation(operation)
    }
    
    func printTime(startTime: NSDate) {
        if operationQueue.operationCount == 0 {
            print("operationsCount = \(operationQueue.operationCount)")
            let endTime = NSDate()
            let timeInterval: Double = endTime.timeIntervalSinceDate(startTime) // <<<<< Difference in seconds (double)
            print("Time to complete operation version: \(timeInterval/0.001) milli-seconds")
        }
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
    
    func multiplyMatricie(maOne:  ArraySlice<[Int]>, maTwo:  ArraySlice<[Int]>) {
            var total = 0
            for matrixOne in maOne {
                for matrixTwo in maTwo {
                    for var index = 0; index < matrixOne.count; ++index {
                        if index == 0 {
                            total = 0
                        }
                        total += matrixOne[index] * matrixTwo[index]
                    }
                }
            }
        }
        
        func test() {
            for var index = 0; index < testArrayOne!.count; ++index {
                print(testArrayOne![index][index])
            }
        }
}

extension Array {
    func splitBy(subSize: Int) -> [[Element]] {
        return 0.stride(to: self.count, by: subSize).map { startIndex in
            let endIndex = startIndex.advancedBy(subSize, limit: self.count)
            return Array(self[startIndex ..< endIndex])
        }
    }
}