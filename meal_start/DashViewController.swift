//
//  DashViewController.swift
//  meal_start
//
//  Created by ZZZZeran on 7/28/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

import UIKit
import SnapKit


// 主ViewController，一个TableView，里面有2个cell
class DashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profileph")
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        iv.userInteractionEnabled = true
        return iv
    }()
    
    var  myMealLabel: UILabel = {
        let label = UILabel()
        label.text = "My Meals"
        label.textColor = UIColor.grayColor()
        //label.backgroundColor = UIColor.clearColor()
        return label
    }()
    var leftBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Left", forState: .Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        return btn
    }()
    
    var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Right", forState: .Normal)
        btn.backgroundColor = UIColor.orangeColor()
        return btn
    }()
    
    var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.8, alpha: 1)
        
        let width = view.frame.width
        let height = view.frame.height
        
        rightBtn.addTarget(self, action: #selector(DashViewController.rightTapped(_:)), forControlEvents: .TouchUpInside)
        leftBtn.addTarget(self, action: #selector(DashViewController.leftTapped(_:)), forControlEvents: .TouchUpInside)
        
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.registerClass(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableHeader = UIView()
        tableHeader.addSubview(profileImage)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DashViewController.handleProfileTap(_:)))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.snp_makeConstraints { (make) in
            make.edges.equalTo(tableHeader).inset(UIEdgeInsetsMake(10, 125, 10, 125))
        }
        tableHeader.frame.size.height = 160
        tableView.tableHeaderView = tableHeader
        view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = MainCell(style: .Default, reuseIdentifier: nil)
            cell.textLabel?.text = "Edit Profile"
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
            cell.configure(["OrderImage", "Spicy Noodle", "Enjoyed", "$12", "@9pm"])
            return cell
        }
    }
    
    
    // MARK: Main TableView delegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 10
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row): \(cell.frame)")
//        
//        // 不写这个方法，cell内的view不会layout
//        switch indexPath.row {
//        case 0:
//            topView.frame = cell.contentView.bounds
//        default:
//            bottomView.frame = cell.contentView.bounds
//        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        default:
            return 80
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 100
        }
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        default:
            return "My Meals"
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            return nil
        default:
            let view = UIView()
            view.frame.size.height = 100
            view.backgroundColor = UIColor(red: 1, green: 0.82, blue: 0.82, alpha: 1)
            view.addSubview(myMealLabel)
            view.addSubview(leftBtn)
            view.addSubview(rightBtn)
            myMealLabel.frame = CGRectMake(20, 20, 100, 20)
            leftBtn.frame = CGRectMake(0, 70, 180, 30)
            rightBtn.frame = CGRectMake(180, 70, 180, 30)
    
            return view
        }
        
    }
    
    // 控制用户修改信息
    func leftTapped(sender: UIButton) {
        print("Left tapped")
    }
    
    func rightTapped(sender: UIButton) {
        print("Right tapped")
        
    }
    
    func handleProfileTap(sender: AnyObject) {
        print("Profile Image Tapped")
        print(tableView.tableHeaderView?.frame)
    }

    
}

// 主界面的cell：一共2个
class MainCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



