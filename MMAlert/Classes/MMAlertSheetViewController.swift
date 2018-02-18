//
//  MMAlertSheetViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Moosa Mir. All rights reserved.
//
let identifireAlertCell = "MMAlertTableViewCell"
import UIKit

public protocol AlertSheetDelegate {
    func userDidTapOnElement(fromController:MMAlertSheetViewController, index:Int, withElements:[MMAlert])
    func userDidTapOnDismissAlertController(fromController:MMAlertSheetViewController)
}

public class MMAlertSheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var boxView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var dismissView: UIView!
    
    public var delegate:AlertSheetDelegate?
    public var elements:[MMAlert] = [MMAlert]()
    
    public var cancelTitle:String? = "Cancel"
    public var fontCancel:UIFont? = UIFont.systemFont(ofSize: 18.0)
    public var colorCancel:UIColor? = UIColor(displayP3Red:230.0/255.0, green: 97.0/255.0, blue: 84.0/255.0, alpha: 1.000)
    public var colorSeperator:UIColor? = UIColor.black.withAlphaComponent(0.4)
    
    public init() {
        super.init(nibName: "MMAlertSheetViewController", bundle: Bundle(for: MMAlertSheetViewController.classForCoder()))
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
        var heightTableView = CGFloat((self.elements.count)) * 56.0
        let maxHeaightTableView = self.view.frame.size.height - 112.0
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
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.setContentOffset(.zero, animated: false)
        self.view.backgroundColor = .clear
        self.cancelButton.backgroundColor = .white
        self.cancelButton.layer.cornerRadius = 14.0
        self.cancelButton.layer.masksToBounds = true
        self.cancelButton.titleLabel?.font = fontCancel
        self.cancelButton.setTitle(cancelTitle, for: .normal)
        self.cancelButton.setTitleColor(colorCancel, for: .normal)
        self.tableView.backgroundColor = .white
        self.tableView.layer.cornerRadius = 14.0
        self.tableView.layer.masksToBounds = true
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.separatorColor = colorSeperator
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.tableView.register(UINib(nibName: identifireAlertCell, bundle: Bundle(for: MMAlertSheetViewController.classForCoder())), forCellReuseIdentifier: identifireAlertCell)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MMAlertSheetViewController.dismissView(_:)))
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
        
        self.delegate?.userDidTapOnElement(fromController: self, index: indexPath.row, withElements: self.elements)
    }
    
    //MARK:- internal method
    func isEmptyDataSuorce() ->Bool{
        if(self.elements.count != 0){
            return false
        }
        return true
    }
    
    @IBAction public func dismissView(_ sender: AnyObject) {
        self.delegate?.userDidTapOnDismissAlertController(fromController: self)
    }
}
