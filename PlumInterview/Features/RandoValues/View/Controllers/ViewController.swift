//
//  ViewController.swift
//  PlumInterview
//
//  Created by kashee on 22/07/23.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Variables
    private var viewModel = RandomValueViewModel()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        configuration()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Jokes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get Jokes", style: .done, target: self, action: #selector(initViewModel))
        
    }
    
}

// ViewModel
extension ViewController {
    func configuration() {
        tableView.register(TableCell.self, forCellReuseIdentifier: cellId)
        initViewModel()
        observeEvent()
    }
    
    @objc func initViewModel() {
        viewModel.getRandomValues()
    }
    
    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
        
    }
}


// MARK: - TableViewDatasource
extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.randomValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! TableCell
        cell.randomValue = viewModel.randomValues[indexPath.row]
        return cell
    }
}

