//
//  ViewController.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 2018/9/6.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var instructions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        instructions.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textFieldDismiss(_ sender: Any) {
    }
    
}

