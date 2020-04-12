//
//  ViewController.swift
//  WiproCodingTest
//
//  Created by AjeetZone on 11/04/20.
//  Copyright © 2020 AjeetZone. All rights reserved.
//

import UIKit
import ImageViewer_swift


class ViewController: UIViewController {
    @IBOutlet weak var tblvw: UITableView!
    var dashbdViewmodel = DashboardViewModel.init()

    var model = CanadaInfo()
    var arrInfo = [Row]()
    
    
    lazy var refresherForDashboard: UIRefreshControl = {
        let refreshContol = UIRefreshControl()
        refreshContol.tintColor = .red
        refreshContol.addTarget(self, action: #selector(getAboutCanada), for: .valueChanged)
        return refreshContol
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tblvw.estimatedRowHeight = UITableView.automaticDimension

        tblvw.refreshControl = refresherForDashboard
        tblvw.separatorColor = .clear
        tblvw.register(UINib(nibName: DashboardCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DashboardCell.cellIdentifier)
        dashbdViewmodel.refreshCtrl = refresherForDashboard
        dashbdViewmodel.delegate = self as? DashboardDelegate
        getAboutCanada()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblvw.layoutSubviews()
    }

}

private typealias APIConfiguration = ViewController
extension APIConfiguration {
    @objc func getAboutCanada() {
        dashbdViewmodel.apiCallForDashboard(true) { (isSuccess) in
            if isSuccess {
                let fullmodel = self.dashbdViewmodel.canadaInfoModel
                
                DispatchQueue.main.async {[weak self] in
                    guard let selfS = self else {return}
                    
                    selfS.navigationItem.title = fullmodel.title
                    if let temparr = fullmodel.rows, temparr.count > 0 {
                        selfS.arrInfo = temparr
                        
                        selfS.refresherForDashboard.endRefreshing()
                        selfS.tblvw.reloadData()
                    }
                }
            }
        }
    }
    
}

private typealias TableviewConfiguration = ViewController
//MARK: Tableview datasource
extension TableviewConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DashboardCell.cellIdentifier) as! DashboardCell
        if arrInfo.count > 0 {
            let item = arrInfo[indexPath.row]
            cell.configureCell(with: item)
            return cell
        }
        return UITableViewCell()
    }
    
}



