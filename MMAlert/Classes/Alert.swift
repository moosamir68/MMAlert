//
//  ASAlert.swift
//  Artiscovery
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

public class Alert: NSObject {
    var title:String? = ""
    var isChecked:Bool? = false
    var image:UIImage?
    var urlImage:String?
    var id:Int = 0
    var idString:String? = ""
    var color:UIColor?
    
    override public init() {
        super.init()
    }
}
