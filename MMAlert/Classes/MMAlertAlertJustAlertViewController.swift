//
//  MMAlertAlertJustAlertViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 11/13/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

public protocol AlertAlertJustAlertDelegate {
    func userDidTapOnCancelButton(fromController:MMAlertAlertJustAlertViewController)
}

public class MMAlertAlertJustAlertViewController: UIViewController {
    @IBOutlet var contanerViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var boxView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var CancelButton: UIButton!
    @IBOutlet var lineUnerHeaderView: UIView!
    @IBOutlet var lineUnerContentView: UIView!
    
    public var delegate:AlertAlertJustAlertDelegate?
    
    public var cancelTitle:String? = "Cancel"
    public var titleHeader:String? = ""
    public var titleContent:String? = ""
    
    public var fontHeader:UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var fontContent:UIFont? = UIFont.systemFont(ofSize: 14.0)
    public var fontButtons:UIFont? = UIFont.systemFont(ofSize: 14.0)
    
    public var colorCancel:UIColor? = UIColor(displayP3Red:52.0/255.0, green: 74.0/255.0, blue: 99.0/255.0, alpha: 1.000)
    public var colorHeader:UIColor? = .black
    public var colorContent:UIColor? = .black
    public var colorLineUnderHeader:UIColor? = .lightGray
    public var colorLineUnderContent:UIColor? = .lightGray
    public var colorContainer:UIColor? = .white
    
    public var contentAlignment:NSTextAlignment = .center
    
    public init() {
        super.init(nibName: "MMAlertAlertJustAlertViewController", bundle: Bundle(for: MMAlertAlertJustAlertViewController.classForCoder()))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setContanerheight()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setContanerheight()
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setContanerheight()
    }
    
    //MARK:- initUI
    private func initUI(){
        
        self.boxView.backgroundColor = .clear
        self.view.backgroundColor = .clear
        
        self.contentLabel.numberOfLines = 0
        self.contentLabel.lineBreakMode = .byWordWrapping
        
        self.headerLabel.text = titleHeader
        self.contentLabel.text = titleContent
        self.CancelButton.setTitle(cancelTitle, for: .normal)
        
        self.containerView.backgroundColor = self.colorContainer
        self.headerLabel.textColor = self.colorHeader
        self.contentLabel.textColor = self.colorContent
        self.CancelButton.setTitleColor(self.colorCancel, for: .normal)
        self.lineUnerHeaderView.backgroundColor = self.colorLineUnderHeader
        self.lineUnerContentView.backgroundColor = self.colorLineUnderContent
        
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 15.0
        
        self.headerLabel.font = self.fontHeader
        self.contentLabel.font = self.fontContent
        self.CancelButton.titleLabel?.font = self.fontButtons
        self.contentLabel.textAlignment = self.contentAlignment
        
        self.setContanerheight()
        
        self.headerLabel.adjustsFontForContentSizeCategory = true
        
        
    }
    
    private func setContanerheight(){
        let contentSize = self.contentLabel.intrinsicContentSize
        
        let containerHeight = self.headerLabel.frame.size.height + contentSize.height + 8 + 8 + 1 + self.CancelButton.frame.size.height
        self.contanerViewConstraintHeight.constant = containerHeight
    }
    
    //MARK:- user did tap
    
    @IBAction func userDidTapOnCancelButton(_ sender: Any) {
        self.delegate?.userDidTapOnCancelButton(fromController: self)
    }
    
}

