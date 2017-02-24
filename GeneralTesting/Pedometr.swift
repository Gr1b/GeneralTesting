//
//  Pedometr.swift
//  GeneralTesting
//
//  Created by Grigory Bochkarev on 23.02.17.
//  Copyright © 2017 GRIB. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

protocol pedometerDataDelegate : class {
   
    var labelP: UILabel? {get set}
    func startUpdateLabelP()
    
}

class Pedometer  {
    
    weak var delegate : pedometerDataDelegate?
    
    let motionQueue = OperationQueue()
    let pedometer = CMPedometer()
    var pace = ""
    var cadence = ""
    
    func startTracking() {
        
        print("tracking started")
        
        if CMPedometer.isCadenceAvailable() && CMPedometer.isPedometerEventTrackingAvailable() {
            print("updetes srarted1")
            //let now = Date()
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                // TODO: Error handling here
                guard let activityData = pedometerData, error == nil else {
                    print("There was an error getting the data: \(error)")
                    return
                }
                self.motionQueue.addOperation {

                    var str = "nill"

                    let pace = activityData.currentPace
                    if (pace != nil) {
                        print("Pace = \(pace)")
                        str = "Pace = \(pace!)"
                    } else {
                        print("pace nill")
                    }
                    
                    let cadence = activityData.currentCadence
                    if cadence != nil {
                        print("Cadence = \(cadence)")
                        str.append("/n Cadence = \(cadence!)")
                    } else {
                        print("cadence = nill")
                    }
                    
                    self.cadence = "Cadence = \(cadence)"
                    self.pace = "Pace = \(pace)"
                    //self.label1?.text = str
                    print(str)
                    if self.delegate != nil {
                        OperationQueue.main.addOperation {
                            self.delegate!.labelP?.text = str
                        }
                    } else {
                        print("no delegate")
                    }
                }
            }
        } else {
            print("This device is not support Core Motion, use pulse istead")
        }
    }
    
    func stopTracking() {
        pedometer.stopUpdates()
        print("stoped")
    }
    
}
