//
//  ViewController.swift
//  GeneralTesting
//
//  Created by Grigory Bochkarev on 14.02.17.
//  Copyright © 2017 GRIB. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, pedometerDataDelegate {
    
    let manager = CMMotionActivityManager()
    let pedometerIn = Pedometer()
    
    @IBOutlet var labelP: UILabel?
    @IBOutlet var label2 : UILabel?
    @IBOutlet var label3 : UILabel?
    @IBOutlet var label4 : UILabel?
    @IBOutlet var label5 : UILabel?
    @IBAction func startMesure() {
        print("start measure")
        /*
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
        }
       */
        pedometerIn.startTracking()
    }
    
    func startUpdateLabelP() {
        pedometerIn.startTracking()
    }
    
    @IBAction func stopMesure() {
        //pedometer.stopUpdates()
        pedometerIn.stopTracking()
        labelP?.text = "Stoped"
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pedometerIn.delegate = self
        //pedometerIn = Pedometer()
        //pedometerIn.delegate = self
        print("delegationg try")
        if pedometerIn.delegate != nil {
            print("delegation failed")
        } else {
            print("delegation done")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

