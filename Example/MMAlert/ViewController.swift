//
//  ViewController.swift
//  MMAlert
//
//  Created by Moosa Mir on 02/05/2018.
//  Copyright (c) 2018 Moosa Mir. All rights reserved.
//

import UIKit
import MMAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func userDidTapOnAlertButton(_ sender: Any) {
        let alertController = MMAlertSheetViewController()
        var elements:[MMAlert] = [MMAlert]()
        let redColor = MMAlert()
        redColor.color = .red
        redColor.title = "Red"
        
        let blackColor = MMAlert()
        blackColor.color = .black
        blackColor.title = "Black"
        
        let whiteColor = MMAlert()
        whiteColor.color = .white
        whiteColor.title = "White"
        
        elements.append(redColor)
        elements.append(blackColor)
        elements.append(whiteColor)
        
        alertController.elements = elements
        self.present(alertController, animated: true) {
            
        }
    }
}

