//
//  WarningViewController.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

/// 颱風(中央氣象局)、淹水(水利署)、地震(中央氣象局)、土石流(農委會水土保持局)、海嘯(中央氣象局)
class WarningViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "警示"
        
    }
}
