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
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        instructions.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDismiss(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldDismiss(textField)
    }
    
    func openURL(string: String) {
        guard let url = URL(string: string) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func openAboutIPAPage(_ sender: UIBarButtonItem) {
        openURL(string: NSLocalizedString("IPAWikipediaURL", comment: "URL of the Wikipedia IPA page"))
    }
    
    @IBAction func openFeedback(_ sender: Any) {
        openURL(string: "https://vince14genius.github.io/support/")
    }
}

