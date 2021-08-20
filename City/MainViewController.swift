//
//  ViewController.swift
//  City
//
//  Created by Ivan Zakharov on 19/8/21.
//

import UIKit
import Framezilla

protocol MainViewControllerOutput {
    func showDetailScreen(_ city: City)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellHight: CGFloat = 110
    var output: MainViewControllerOutput?
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
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell
        cell?.refreshContent(cities[indexPath.row])
        return cell ?? TableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.showDetailScreen(cities[indexPath.item])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
