//
//  ViewController.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

/// 編號、最大震度、詳細Data
class EarthquakeViewController: UIViewController, EarthquakeDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: EarthquakeViewModel!
    private var earthQuake: [EarthquakeValue] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地震觀測站"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        viewModel = EarthquakeViewModel()
        viewModel.delegate = self
    }
    
    func EarthquakeServerRequest(resquest: Earthquake) {
        earthQuake = resquest.value
    }
}

extension EarthquakeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthQuake.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel.getName(row: indexPath.row)
        cell.detailTextLabel?.text = viewModel.getID(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: SBName_detail) as! DetailViewController
        vc.data = viewModel.getDetailData(row: indexPath.row)
        vc.title = viewModel.getName(row: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}
