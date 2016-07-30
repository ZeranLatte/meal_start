//
//  OrderTableView.swift
//  meal_start
//
//  Created by ZZZZeran on 7/28/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

import UIKit

class OrderTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
    
    
    
}
