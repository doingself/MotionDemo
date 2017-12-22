//
//  TabViewController.swift
//  MotionDemo
//
//  Created by rigour on 2017/12/7.
//  Copyright © 2017年 testName. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {

    private var tabView: UITableView!
    private let cellIdentifices = "cell"
    private lazy var datas: [String] = {
        let arr = ["弹球(加速器)","距离传感器（非motion）+ 摇一摇","motion(加速 陀螺 磁力 海拔)"]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.title = "core motion"
        
        tabView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tabView.delegate = self
        tabView.dataSource = self
        
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifices)
        tabView.tableFooterView = UIView()
        
        tabView.rowHeight = UITableViewAutomaticDimension
        tabView.estimatedRowHeight = 44.0
        
        self.view.addSubview(tabView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TabViewController: UITableViewDataSource{
    // MARK: table data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifices, for: indexPath)
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        
        let data = self.datas[indexPath.row]
        cell.textLabel?.text = data
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TabViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var v: UIViewController?
        
        switch indexPath.row {
        case 0:
            v = ViewController()
        case 1:
            v = ViewController1()
        case 2:
            v = ViewController2()
        default:
            break
        }
        if v != nil{
            self.navigationController?.pushViewController(v!, animated: true)
        }
        
    }
}
