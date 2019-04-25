//
//  TimerCell.swift
//  SwiftDemo
//
//  Created by eyoung on 2019/4/15.
//  Copyright © 2019年 eyoung. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {
    var _model: MyModel?
    var model: MyModel? {
        get {
            return _model
        }
        set {
            _model = newValue
            self.textLabel?.text = String.init(format: "%d", _model?.second ?? 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
