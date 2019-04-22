//
//  TimerCellsController.swift
//  SwiftDemo
//
//  Created by eyoung on 2019/4/15.
//  Copyright © 2019年 eyoung. All rights reserved.
//

import UIKit

class TimerCellsController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let cellid: String = "TimerForCellsIdentify"
    let cellHeight: CGFloat = 44
    lazy var mainTableView: UITableView = {
        let mainTable = UITableView.init(frame: CGRect.init(x: 0, y: UIHelper.safeAreaTopHeight, width: UIHelper.kWidth, height: UIHelper.kHeight-UIHelper.safeAreaTopHeight))
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(TimerCell.classForCoder(), forCellReuseIdentifier: cellid)
        return mainTable;
    }()
    
    lazy var dataSourceArr: NSArray = {
        let test1 = MyModel.init()
        test1.second = 9999
        let test2 = MyModel.init()
        test2.second = 2846
        let test3 = MyModel.init()
        test3.second = 927473
        let test4 = MyModel.init()
        test4.second = 93273
        let test5 = MyModel.init()
        test5.second = 198372
        let test6 = MyModel.init()
        test6.second = 23038
        let dataSource = NSMutableArray.init(array: [test1,test2,test3,test4,test5,test6])
        return dataSource;
    }()
    
    lazy var timer: Timer = {
        let timer = Timer.init(timeInterval: 1, target: self, selector: #selector(timerAction(sender:)), userInfo: nil, repeats: true)
        return timer;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TimerCells"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.mainTableView)
        self.timer.fire()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimerCell = tableView.dequeueReusableCell(withIdentifier: self.cellid, for: indexPath) as! TimerCell
        cell.model = self.dataSourceArr[indexPath.row] as? MyModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func timerAction(sender: Timer){
        for obj in self.dataSourceArr {
            let myMode = obj as! MyModel
            myMode.second -= 1
        }
        self.mainTableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
