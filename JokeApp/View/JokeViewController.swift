//
//  JokeViewController.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import UIKit

class JokeViewController: UIViewController {

    private var jokeViewModel: JokeViewModelType
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.estimatedRowHeight = 60
        tableview.rowHeight = UITableView.automaticDimension
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.register(JokeTableViewCell.self, forCellReuseIdentifier: "JokeTableViewCell")
        return tableview
    }()
  
    init(viewModel: JokeViewModelType) {
        self.jokeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.jokeViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTableView()
        jokeViewModel.fetchJoke()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        self.title = "Unlimit Jokes"
    }
    
    func addTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

extension JokeViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeViewModel.jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeTableViewCell", for: indexPath) as! JokeTableViewCell
        let joke = jokeViewModel.jokes[indexPath.row]
        cell.setData(model: joke)
        return cell
    }
}

extension JokeViewController: JokeViewModelDelegate {
    
    func addJoke(indexPath: IndexPath) {
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func removeJoke(indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
}
