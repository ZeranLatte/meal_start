//
//  OrderCell.swift
//  meal_start
//
//  Created by ZZZZeran on 7/31/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

// 底部view里的tableView里的cell,显示历史订单

import UIKit

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
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.greenColor()
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grayColor()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayColor()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(orderImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(timeLabel)
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
            make.right.equalTo(contentView).offset(-15)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(20)
        }
        
        statusLabel.snp_makeConstraints { (make) in
            make.left.equalTo(orderImage.snp_right).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
            make.right.equalTo(contentView).offset(-15)
            make.height.equalTo(20)
        }
        
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(orderImage.snp_right).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(50)
            make.centerY.equalTo(contentView)
        }
        
        timeLabel.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.right.equalTo(contentView).offset(-20)
            make.left.equalTo(orderImage.snp_right).offset(65)
            make.centerY.equalTo(contentView)
        }
        
        
    }
    
    func configure(orderInfo: [String]) {
        self.orderImage.image = UIImage(named: orderInfo[0])
        self.titleLabel.text = orderInfo[1]
        self.statusLabel.text = orderInfo[2]
        self.priceLabel.text = orderInfo[3]
        self.timeLabel.text = orderInfo[4]
    }
    
    
    
}