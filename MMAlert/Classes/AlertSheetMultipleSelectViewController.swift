//
//  ASAlertViewController.swift
//  Artiscovery
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

public protocol AlertMultipleSelectDelegate {
    func userDidTapOnConfirmAlertMultipleSelectController(fromController:AlertMultipleSelectViewController?, elements:[Alert]?)
}

public class AlertMultipleSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var boxView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var dismissView: UIView!
    
    public var delegate:AlertMultipleSelectDelegate?
    public var elements:[Alert]?
    
    public var titleDone:String? = "Done"
    public var fontDone:UIFont? = UIFont.boldSystemFont(ofSize: 18.0)
    public var colorDone:UIColor? = UIColor(displayP3Red:52.0/255.0, green: 74.0/255.0, blue: 99.0/255.0, alpha: 1.000)
    public var colorSeperator:UIColor? = UIColor.black.withAlphaComponent(0.4)
    
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
        var heightTableView = CGFloat((self.elements?.count)!) * 56.0
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
        
        self.tableView.register(UINib(nibName: identifireAlertCell, bundle: nil), forCellReuseIdentifier: identifireAlertCell)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AlertViewController.dismissView(_:)))
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
        return (self.elements?.count)!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AlertTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: identifireAlertCell, for: indexPath) as! AlertTableViewCell
        let element = self.elements![indexPath.row]
        cell.fillData(alert: element)
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = self.elements![indexPath.row]
        let cell:AlertTableViewCell = self.tableView.cellForRow(at: indexPath) as! AlertTableViewCell
        
        if(alert.isChecked)!{
            alert.isChecked = false
        }else{
            alert.isChecked = true
        }
        
        cell.fillData(alert: alert)
    }
    
    //MARK:- internal method
    func isEmptyDataSuorce() ->Bool{
        if(self.elements != nil && self.elements?.count != 0){
            return false
        }
        return true
    }
    
    //MARK:- user did tap
    @IBAction func userDidTapOnDone(_ sender: AnyObject) {
        self.delegate?.userDidTapOnConfirmAlertMultipleSelectController(fromController: self, elements: self.elements)
    }
    
    @IBAction func dismissView(_ sender: AnyObject) {
        self.delegate?.userDidTapOnConfirmAlertMultipleSelectController(fromController: self, elements: self.elements)
    }
}
