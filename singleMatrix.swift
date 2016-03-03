//
//  singleMatrix.swift
//  matrixMultiplication
//
//  Created by Toby Applegate on 02/03/2016.
//  Copyright © 2016 Toby Applegate. All rights reserved.
//


import Cocoa

class singleMatrix {
    var testArrayOne, testArrayTwo: [[Int]]?
    var matrixArrayOne: [[Int]] = []
    var matrixArrayTwo: [[Int]] = []

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
    
    func multiplyMatricie() {
        let startTime = NSDate()
        
        var total = 0
        for matrixOne in matrixArrayOne {
            for matrixTwo in matrixArrayTwo {
                for var index = 0; index < matrixOne.count; ++index {
                    
                    //resets total to 0 when multiplying new matrix
                    if index == 0 {
                        total = 0
                    }
                    
                    total += matrixOne[index] * matrixTwo[index]
                    
                    //prints results
                    //                    if index  == (number.count - 1) {
                    //                        print(total)
                    //                    }
                }
            }
        }
        
        let endTime = NSDate()
        let timeInterval: Double = endTime.timeIntervalSinceDate(startTime) // <<<<< Difference in seconds (double)
        print("Time to complete non parallel version: \(timeInterval/0.001) milli-seconds")
    }
    
    func test() {
        for var index = 0; index < testArrayOne!.count; ++index {
            print(testArrayOne![index][index])
        }
    }

//        let matrixOne = NSString(string:"/Users/tobyapplegate/Desktop/arrayOne").stringByExpandingTildeInPath
//        let matrixOneFileContent = try? NSString(contentsOfFile: matrixOne, encoding: NSUTF8StringEncoding)
//
//        let matrixOneString = "\(matrixOneFileContent!)"
//        let matrixOneStringArray = matrixOneString.componentsSeparatedByString("],")
//
//        for var elements in matrixOneStringArray {
//            elements = elements.stringByReplacingOccurrencesOfString("]", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//            elements = elements.stringByReplacingOccurrencesOfString("[", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//
//            let tempMatrixArray = elements.componentsSeparatedByString(",").map{Int($0)!}
//            matrixArrayOne.append(tempMatrixArray)
//        }

}