//
//  MMAlertTableViewCell.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Moosa Mir. All rights reserved.
//

import UIKit
import Kingfisher

class MMAlertTableViewCell: UITableViewCell {
    @IBOutlet var boxView: UIView!
    @IBOutlet var titleItem: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var fontTitle = UIFont.systemFont(ofSize: 18.0)
    var colorTitle = UIColor(displayP3Red:0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.000)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleItem.font = self.fontTitle
        self.titleItem.textColor = self.colorTitle
        self.itemImageView.layer.cornerRadius = 5.0
        self.itemImageView.layer.masksToBounds = true
        self.titleItem.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI(font:UIFont?, color:UIColor?){
        if(font != nil){
            self.fontTitle = font!
        }
        
        if(color != nil){
            self.colorTitle = color!
        }
        
        self.titleItem.font = self.fontTitle
        self.titleItem.textColor = self.colorTitle
    }
    
    func fillData(alert:MMAlert?){
        if(alert != nil){
            if(alert?.color != nil){
                self.titleItem.textColor = self.colorTitle
                self.boxView.backgroundColor = alert?.color
            }
            if(alert?.title != nil){
                self.titleItem.text = alert?.title
            }else{
                self.titleItem.text = ""
            }
            if(alert?.isChecked != nil && (alert?.isChecked)!){
                self.checkBoxImageView.image = #imageLiteral(resourceName: "libraryConfirm")
            }else{
                self.checkBoxImageView.image = nil
            }
            
            if(alert?.image != nil){
                self.itemImageView.image = alert?.image
            }else if(alert?.urlImage != nil){
                let url = URL(string: (alert?.urlImage)!)
                self.itemImageView.kf.setImage(with: url)
            }else{
                self.itemImageView.image = nil
            }
        }else{
            self.itemImageView.image = nil
            self.checkBoxImageView.image = nil
            self.titleItem.text = ""
            
        }
    }
}
