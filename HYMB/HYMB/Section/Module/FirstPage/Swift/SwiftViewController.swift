//
//  SwiftViewController.swift
//  HYMB
//
//  Created by 863Soft on 2019/4/4.
//  Copyright © 2019 hymb. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var tableView:UITableView! //tabelView
    var tableView = UITableView()
    var dataArr = NSArray()
    
    static let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr = [
            [
            "title":"其它",
            "content":["数据持久化", "动画"],
            ],
        ]
        
        print(dataArr)
        
        
        self.setUI()
    }

    func setUI() {
        
        self.title = "Swift"
//        self.view.backgroundColor = UIColor.red
        
        // 添加tableView
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SwiftViewController.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((dataArr[section] as AnyObject)["content"] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 定义一个cell
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: SwiftViewController.cellId, for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.textLabel?.text = ((dataArr[indexPath.section] as AnyObject)["content"] as! NSArray)[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        label.text = (dataArr[section] as AnyObject)["title"] as? String
        label.textAlignment = NSTextAlignment.center
        view .addSubview(label)
        
        return view;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)

        return view;
    }


    
    //cell的点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = AnimationRefreshVC()
        self.navigationController?.pushViewController(VC, animated: true)
    }

    
    
}
