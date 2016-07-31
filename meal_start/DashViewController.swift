//
//  DashViewController.swift
//  meal_start
//
//  Created by ZZZZeran on 7/28/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

import UIKit
import SnapKit

// 顶部view：包括一个头像和TableView
class DashTopView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let titles = ["Edit Profile", "Payment", "Change Password"]
    
    // 用于传递给ViewController用户修改信息选项
    typealias SelectCellCallBack = (Option: String) -> Void
    var callBack: SelectCellCallBack?
    
    var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profileph")
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.addSubview(profileImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 100, 180, 100))
        }
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(120, 10, 0, 10))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            self.callBack?(Option: "edit")
        case 1:
            self.callBack?(Option: "payment")
        default:
            self.callBack?(Option: "change")
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}

// 底部view：两个可以切换的button，加最下面一个TableView显示当前或历史订单
class DashBotView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    var mealLabel: UILabel = {
        let label = UILabel()
        label.text = "My Meal"
        label.textColor = UIColor.grayColor()
        label.backgroundColor = UIColor.blueColor()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mealLabel)
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        
        self.addSubview(tableView)
        tableView.registerClass(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mealLabel.snp_makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.top.equalTo(self).offset(0)
        }
        leftBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.left.equalTo(self)
            make.top.equalTo(self).offset(50)
        }
        rightBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.right.equalTo(self)
            make.top.equalTo(self).offset(50)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self).offset(0)
            make.top.equalTo(rightBtn.snp_bottom).offset(0)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
        cell.configure(["OrderImage", "Spicy Noodle", "Enjoyed"])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}


// 主ViewController，一个TableView，里面有2个cell
class DashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 顶部和底部view，最好加在主cell里面
    var topView: DashTopView!
    var bottomView: DashBotView!
    
    var mainTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.8, alpha: 1)
        
        let width = view.frame.width
        let height = view.frame.height
        
        topView = DashTopView()
        bottomView = DashBotView()
        
        mainTable = UITableView(frame: self.view.bounds, style: .Plain)
        mainTable.registerClass(MainCell.self, forCellReuseIdentifier: "mainCell")
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.allowsSelection = false
        view.addSubview(mainTable)
        bottomView.rightBtn.addTarget(self, action: #selector(DashViewController.rightTapped(_:)), forControlEvents: .TouchUpInside)
        bottomView.leftBtn.addTarget(self, action: #selector(DashViewController.leftTapped(_:)), forControlEvents: .TouchUpInside)

        // Callback，接受用户修改信息选项
        topView.callBack = ({(Option: String) -> Void in
            print("User choosed: \(Option)")
        })

    }
    
    // 控制用户修改信息
    func leftTapped(sender: UIButton) {
        print("Left tapped")
    }
    
    func rightTapped(sender: UIButton) {
        print("Right tapped")
    }
    
    // MARK: Main TableView delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = MainCell(style: .Default, reuseIdentifier: nil)
            topView.frame = cell.contentView.bounds
            cell.contentView.addSubview(topView)
            return cell
        default:
            let cell = MainCell(style: .Default, reuseIdentifier: nil)
            bottomView.frame = cell.contentView.bounds
            cell.contentView.addSubview(bottomView)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row): \(cell.frame)")
        
        // 不写这个方法，cell内的view不会layout
        switch indexPath.row {
        case 0:
            topView.frame = cell.contentView.bounds
        default:
            bottomView.frame = cell.contentView.bounds
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        default:
            return 500
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}

// 主界面的cell：其实一共2个
class MainCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 底部view里的tableView里的cell
class OrderCell: UITableViewCell {
    
    
    var orderImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.greenColor()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(orderImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(statusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        let imageWidth = height * 4 / 3
        orderImage.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(1, 1, 1, width - imageWidth))
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(orderImage.snp_right).offset(5)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(20)
        }
        
        statusLabel.snp_makeConstraints { (make) in
            make.left.equalTo(orderImage.snp_right).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(20)
        }
    }
    
    func configure(orderInfo: [String]) {
        self.orderImage.image = UIImage(named: orderInfo[0])
        self.titleLabel.text = orderInfo[1]
        self.statusLabel.text = orderInfo[2]
    }

    
    
}
