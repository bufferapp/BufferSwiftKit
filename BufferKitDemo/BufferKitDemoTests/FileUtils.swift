//
//  FileUtils.swift
//  BufferKit
//
//  Created by Humberto Aquino on 1/22/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import Foundation

class FileUtils {
    class func readJSONasData(filename: String) -> NSData? {
        if let path = NSBundle(forClass: FileUtils.self).pathForResource(filename, ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                return data
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("Invalid filename/path.")
            return nil
        }
    }
    
    class func readJSONasString(filename: String) -> String? {
        if let data = self.readJSONasData(filename) {
            if let jsonString = String(data: data, encoding: NSUTF8StringEncoding) {
                return jsonString
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
