//
//  DetailViewController.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

let SBName_detail = "DetailViewController"

class DetailViewController: UIViewController {

    var data: [[String]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        cell.textLabel?.text = data[indexPath.row][0]
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.text = data[indexPath.row][1]
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: data[indexPath.row][0], message: data[indexPath.row][1], preferredStyle: .alert)
        let action = UIAlertAction(title: "Enter", style: .default) { (action) in
            
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
