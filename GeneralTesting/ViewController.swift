//
//  ViewController.swift
//  GeneralTesting
//
//  Created by Grigory Bochkarev on 14.02.17.
//  Copyright © 2017 GRIB. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let pedometer = CMPedometer()
    
    @IBOutlet var label1 : UILabel?
    @IBAction func startMesure() {
        
        guard CMPedometer.isCadenceAvailable() &&
            CMPedometer.isPaceAvailable() else{
                print("Pace and cadence data are not available")
                return
        }
        
        let calender = Calendar.current
        let yesterday = calender.date(byAdding: .day, value: -1, to: Date())
        //let today = Date()
        if yesterday != nil {
            pedometer.startUpdates(from: yesterday!) {
                data, error in
    
                //Unwrap the data and make sure we didn't run into an error
                guard let activityData = data, error == nil else {
                    print("There was an error getting the data: \(error)")
                    return
                }
    
                let pace = activityData.currentPace
                if (pace != nil) {
                    print("Pace = \(pace)")
                }
    
                let cadence = activityData.currentCadence
                if cadence != nil {
                    print("Cadence = \(cadence)")
                }
                
                let str = "Pace = \(pace) \n Cadence = \(cadence)"
                self.label1?.text = str
            }
            
//            pedometer.queryPedometerData(from: yesterday!, to: today, withHandler: {data, error in
//                //Unwrap the data and make sure we didn't run into an error
//                guard let activityData = data, error == nil else {
//                    print("There was an error getting the data: \(error)")
//                    return
//                }
//                //prints out step count
//                print("Steps: \(activityData.numberOfSteps)")
//                //print out optional distance in of walking and running in meters
//                print("Distance \(activityData.distance)")
//                //print out optional floors ascended
//                print("Floors ascended: \(activityData.floorsAscended)")
//                //print out optional floors descended
//                print("Floors descended \(activityData.floorsDescended)")
//                
//                print(activityData.averageActivePace)
//                print(activityData.currentCadence)
//                print(activityData.currentPace)
//            })
        }

    }
    
    @IBAction func stopMesure() {
        pedometer.stopUpdates()
        label1?.text = "Stoped"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

