//
//  InstaViewController.swift
//  InstaParse
//
//  Created by Kwaku Owusu on 3/10/16.
//  Copyright © 2016 Kwaku Owusu. All rights reserved.
//

import UIKit
import Parse
class InstaViewController: UIViewController {

    var posts:[Post]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var query = PFQuery(className: "post")

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
