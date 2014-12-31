//
//  DetailedStopViewController.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-30.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import UIKit

class DetailedStopViewController: UIViewController {

    @IBOutlet weak var moreStopInfo: UILabel!
    var labelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moreStopInfo.text = labelText
        
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
