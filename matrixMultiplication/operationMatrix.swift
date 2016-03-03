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
            
            self.testArrayOne = [ [1,2,3] , [4,5,6] ]
            self.testArrayTwo = [ [7,9,11] , [8,10,12] ]
            
            mapArrayFromString("/Users/tobyapplegate/Desktop/arrayOne", arrayName: "matrixArrayOne")
            mapArrayFromString("/Users/tobyapplegate/Desktop/arrayTwo", arrayName: "matrixArrayTwo")
            
            print(matrixArrayOne.count)
            print(matrixArrayTwo.count)
            //multiplyMatricie()
            
            let startTime = NSDate()
            
//            let arrayOne1 = matrixArrayOne[0 ... 99]
//            let arrayOne2 = matrixArrayOne[100 ... 199]
//            let arrayOne3 = matrixArrayOne[200 ... 299]
//            let arrayOne4 = matrixArrayOne[300 ... 399]
//            
//            let arrayTwo1 = matrixArrayTwo[0 ... 99]
//            let arrayTwo2 = matrixArrayTwo[100 ... 199]
//            let arrayTwo3 = matrixArrayTwo[200 ... 299]
//            let arrayTwo4 = matrixArrayTwo[300 ... 399]
            
            let count = 32
            
            let segments = matrixArrayOne.count / count // 400 / 4
            let dividerArray = Array(0.stride(to: matrixArrayOne.count + 1, by: segments))
            
            print("divider array = \(dividerArray)")
            
            for var i = 0; i < dividerArray.count; i++ {
                print("i = \(i)")
                print(dividerArray.count-1)
                if i != dividerArray.count-1 {
                    print(i)
                    let arrayOne = matrixArrayOne[dividerArray[i] ... (dividerArray[i+1]-1)]
                    let arrayTwo = matrixArrayTwo[dividerArray[i] ... (dividerArray[i+1]-1)]
                    addToQue(arrayOne, arrayTwo: arrayTwo, startTime: startTime, operNumber: i)
                }
//                else {
//                    let arrayOne = matrixArrayOne[dividerArray[i] ... (dividerArray[i+1]-1)]
//                    let arrayTwo = matrixArrayTwo[dividerArray[i] ... (dividerArray[i+1]-1)]
//                    addToQue(arrayOne, arrayTwo: arrayTwo, startTime: startTime, operNumber: i)
//                }


            }
    }
    
    func addToQue(arrayOne: ArraySlice<[Int]>, arrayTwo: ArraySlice<[Int]>, startTime: NSDate, operNumber: Int){
        
        let operation = NSBlockOperation() {
            self.multiplyMatricie(arrayOne, maTwo: arrayTwo)
        }
        operation.completionBlock = {
            print("done opperatoin \(operNumber)")
            self.printTime(startTime)
        }
        operationQueue.addOperation(operation)
    }
    
//            let op1 = NSBlockOperation() {
//                self.multiplyMatricie(arrayOne1, maTwo: arrayTwo1)
//            }
//            
//            op1.completionBlock = {
//                print("done op1")
//                self.printTime(startTime)
//            }
//           
//            let op2 = NSBlockOperation() {
//                self.multiplyMatricie(arrayOne2, maTwo: arrayTwo2)
//            }
//            
//            op2.completionBlock = {
//                print("done op2")
//                self.printTime(startTime)
//            }
//            
//            let op3 = NSBlockOperation() {
//                self.multiplyMatricie(arrayOne3, maTwo: arrayTwo3)
//            }
//            
//            op3.completionBlock = {
//                print("done op3")
//                self.printTime(startTime)
//            }
//            
//            let op4 = NSBlockOperation() {
//                self.multiplyMatricie(arrayOne4, maTwo: arrayTwo4)
//            }
//            
//            op4.completionBlock = {
//                print("done op4")
//                self.printTime(startTime)
//            }
//            
//            operationQueue.addOperations([op1,op2,op3,op4], waitUntilFinished: false)
        //}
    
    func printTime(startTime: NSDate){
        if operationQueue.operationCount == 0 {
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


//multiply the two matricies together

//    func divideArray(array: String, increment: Int) {
//        if array == "matrixArrayOne" {
//            let size = matrixArrayOne.count/increment
//            print(size)
////            let strideAmount = strid
//            for index in stride(from: 0, to: matrixArrayOne.count, by: size) {
//                print("index : \(index)")
//
//            }
//        }
//        else {
//
//        }
//    }
    