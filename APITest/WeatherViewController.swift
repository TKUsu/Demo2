//
//  MeteorologicalViewController.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

/// 日期、時間、縣市、現在氣溫、降雨機率、未來一周天氣（氣溫、天氣圖、時間）、空氣品質、紫外線
class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var weather: [WeatherValue] = []
    private let server: APIServer = APIServer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "氣象觀測站"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        server.call(.wearth) { (isSuccess, res) in
            guard let res = res as? Weather else {return}
            self.weather = res.value
            self.tableView.reloadData()
        }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        cell.textLabel?.text = weather[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.text = weather[indexPath.row].phenomenonTime
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let earthQuakeValue = weather[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: SBName_detail) as! DetailViewController
        
        let valueDic = earthQuakeValue.encodeDic!
        var values: [[String]] = []
        for (key, value) in valueDic{
            values.append([key, value.description])
        }
        
        vc.data = values
        navigationController?.pushViewController(vc, animated: true)
    }
}

