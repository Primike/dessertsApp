//
//  RecipesListViewController.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation
import UIKit

class RecipesListViewController: UIViewController, RecipeViewModelDelegate {
    
    weak var coordinator: RecipesCoordinator?
    let viewModel: RecipesViewModel
    
    init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = searchBar
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        viewModel.fetchData()
    }
    
    func didFinishFetch() {
        setup()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = "Recipe List"
        

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.reuseID)
    }
    
    private func layout() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reuseID, for: indexPath) as? RecipeTableViewCell else {
            print(CustomError.cellReuse)
            
            return UITableViewCell()
        }
        
        recipeCell.configure(viewModel: viewModel, indexPath: indexPath)
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.bounds.height/10)
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let recipeID = viewModel.getRecipeID(for: indexPath), let coordinator = coordinator else {
            return
        }
        
        coordinator.goToRecipeDetails(id: recipeID)
    }
}

extension RecipesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSearchResults(searchText: searchText)
        
        tableView.reloadData()
    }
}
