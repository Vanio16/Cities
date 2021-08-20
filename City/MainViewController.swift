//
//  ViewController.swift
//  Cities
//
//  Created by Ivan Zakharov on 19/8/21.
//

import UIKit
import Framezilla

protocol MainViewControllerOutput {
    func showDetailScreen(_ image: UIImage, _ name: String)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = .init()
    var output: MainViewControllerOutput?
    var selectCity: City?
    var cities = [City(name: "Omsk", picture: "omsk"),
                  City(name: "Moscow", picture: "moscow"),
                  City(name: "St. Petersburg", picture: "piter"),
                  City(name: "Novosibirsk", picture: "novosib"),
                  City(name: "Samara", picture: "samara"),
                  City(name: "Irkutsk", picture: "irkutsk"),
                  City(name: "Omsk", picture: "omsk"),
                  City(name: "Moscow", picture: "moscow"),
                  City(name: "St. Petersburg", picture: "piter"),
                  City(name: "Novosibirsk", picture: "novosib"),
                  City(name: "Samara", picture: "samara"),
                  City(name: "Irkutsk", picture: "irkutsk"),
                  City(name: "Omsk", picture: "omsk"),
                  City(name: "Moscow", picture: "moscow"),
                  City(name: "St. Petersburg", picture: "piter"),
                  City(name: "Novosibirsk", picture: "novosib"),
                  City(name: "Samara", picture: "samara"),
                  City(name: "Irkutsk", picture: "irkutsk")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top)
                .bottom(to: view.nui_safeArea.bottom)
                .left()
                .right()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.commonInit(cities[indexPath.row].picture, title: cities[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCity = cities[indexPath.row]
        output?.showDetailScreen(cities[indexPath.item].picture, cities[indexPath.item].name)
        self.tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectCity = cities[indexPath.row]
        return indexPath
    }
}


