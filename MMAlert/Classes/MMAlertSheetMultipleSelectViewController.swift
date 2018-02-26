//
//  MMAlertSheetMultipleSelectViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Moosa Mir. All rights reserved.
//

import UIKit

public protocol AlertSheetMultipleSelectDelegate {
    func userDidTapOnConfirmAlertMultipleSelectController(fromController:MMAlertSheetMultipleSelectViewController, elements:[MMAlert])
}

public class MMAlertSheetMultipleSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var boxView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var dismissView: UIView!
    
    public var delegate:AlertSheetMultipleSelectDelegate?
    public var elements:[MMAlert] = [MMAlert]()
    
    public var titleDone:String? = "Done"
    public var fontDone:UIFont? = UIFont.boldSystemFont(ofSize: 18.0)
    public var colorDone:UIColor? = UIColor(displayP3Red:52.0/255.0, green: 74.0/255.0, blue: 99.0/255.0, alpha: 1.000)
    public var colorSeperator:UIColor? = UIColor.black.withAlphaComponent(0.4)
    
    public var fontTitleCell:UIFont?
    public var colorTitleCell:UIColor?
    
    public init() {
        super.init(nibName: "MMAlertSheetMultipleSelectViewController", bundle: Bundle(for: MMAlertSheetMultipleSelectViewController.classForCoder()))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewWillLayoutSubviews() {
        var heightTableView = CGFloat(self.elements.count) * 56.0
        let maxHeaightTableView = self.view.frame.size.height - 90.0
        if(heightTableView > maxHeaightTableView){
            heightTableView = maxHeaightTableView
            self.tableView.isScrollEnabled = true
        }else{
            self.tableView.isScrollEnabled = false
        }
        
        self.tableViewConstraintHeight.constant = heightTableView
    }
    
    //MARK:- initUI
    func initUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.boxView.backgroundColor = .clear
        self.view.backgroundColor = .clear
        self.doneButton.backgroundColor = .white
        self.doneButton.layer.cornerRadius = 14.0
        self.doneButton.layer.masksToBounds = true
        self.doneButton.titleLabel?.font = self.fontDone
        self.doneButton.setTitle(titleDone, for: .normal)
        self.doneButton.setTitleColor(colorDone, for: .normal)
        self.tableView.backgroundColor = .white
        self.tableView.layer.cornerRadius = 14.0
        self.tableView.layer.masksToBounds = true
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.separatorColor = self.colorSeperator
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.tableView.register(UINib(nibName: identifireAlertCell, bundle: Bundle(for: MMAlertSheetMultipleSelectViewController.classForCoder())), forCellReuseIdentifier: identifireAlertCell)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MMAlertSheetMultipleSelectViewController.dismissView(_:)))
        self.dismissView.addGestureRecognizer(tapGesture)
    }

    //MARK:- tableview delegate
    public func numberOfSections(in tableView: UITableView) -> Int {
        if(self.isEmptyDataSuorce()){
            return 0
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.isEmptyDataSuorce()){
            return 0
        }
        return (self.elements.count)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MMAlertTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: identifireAlertCell, for: indexPath) as! MMAlertTableViewCell
        let element = self.elements[indexPath.row]
        cell.fillData(alert: element)
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = self.elements[indexPath.row]
        let cell:MMAlertTableViewCell = self.tableView.cellForRow(at: indexPath) as! MMAlertTableViewCell
        
        if(alert.isChecked)!{
            alert.isChecked = false
        }else{
            alert.isChecked = true
        }
        
        cell.setUpUI(font: self.fontTitleCell, color: self.colorTitleCell)
        cell.fillData(alert: alert)
    }
    
    //MARK:- internal method
    func isEmptyDataSuorce() ->Bool{
        if(self.elements.count != 0){
            return false
        }
        return true
    }
    
    //MARK:- user did tap
    @IBAction func userDidTapOnDone(_ sender: AnyObject) {
        self.delegate?.userDidTapOnConfirmAlertMultipleSelectController(fromController: self, elements: self.elements)
    }
    
    @IBAction public func dismissView(_ sender: AnyObject) {
        self.delegate?.userDidTapOnConfirmAlertMultipleSelectController(fromController: self, elements: self.elements)
    }
}
