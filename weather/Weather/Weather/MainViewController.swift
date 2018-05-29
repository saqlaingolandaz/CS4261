//
//  MainViewController.swift
//  Weather
//
//  Created by Sonify on 5/29/18.
//  Copyright © 2018 Sonify. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityBar: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var button: UIButton!

    
    
    @IBAction func buttonClicked(sender: AnyObject) {
        let session = NSURLSession.sharedSession()
        //Gets custom weather info of chosen location
        let url = NSURL(string:"https://api.wunderground.com/api/16337742f9b11efe/conditions/q/" + cityBar.text! + ".json")
        print(cityBar)
        let returnedData = NSData(contentsOfURL: url!)
        var error: NSError?
        var parsedData:NSDictionary = [:]
        
        do {
            parsedData = try NSJSONSerialization.JSONObjectWithData(returnedData!, options: NSJSONReadingOptions.MutableContainers)as! NSDictionary
        } catch let error as NSError {
            // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
            print("A JSON parsing error occurred, here are the details:\n \(error)")
        }
        
        var topLevel:NSDictionary = parsedData["current_observation"] as! NSDictionary
        var secondLevel:NSDictionary = topLevel["display_location"] as! NSDictionary
        
        self.result.text = (secondLevel["full"] as! NSString as String) + "\n"
        self.result.text = self.result.text! + (topLevel["temperature_string"] as! NSString as String)
        
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
