//
//  MMAlert.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

public class MMAlert: NSObject {
    public var title:String? = ""
    public var isChecked:Bool? = false
    public var image:UIImage?
    public var urlImage:String?
    public var id:Int = 0
    public var idString:String? = ""
    public var color:UIColor?
    
    override public init() {
        super.init()
    }
}
