//
//  ViewController.swift
//  Planets
//
//  Created by Gisonmon George on 12/05/23.
//

import UIKit

/*
 Main view controller with one TableView.
 */
class PlanetsViewController: UIViewController {

    @IBOutlet weak var planetsTableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    lazy var viewModel = {
        PlanetsViewModel(planetsService: PlanetsService(apiHandler: ApiHandler.shared), planetsDBService: PlanetsDBService(stack: CoreDataStack()))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
        getPlanets()
    }

    // Initial UI setup
    private func setupView() {
        //TableView setup
        planetsTableView.separatorStyle = .singleLine
        planetsTableView.allowsSelection = false
        planetsTableView.registerCell(identifier: PlanetsTableViewCell.identifier)
    }
    
    // Making the view model data request
    private func getPlanets() {
        handleApiLoader(isAnimating: true)
        viewModel.getPlanets(completion: { [weak self] in
            self?.handleApiLoader(isAnimating: false)
        })
    }
    
    // Binding the results to view
    private func setupBindings() {
        viewModel.refreshUI = { [weak self] infoMessage in
            self?.handleApiLoader(isAnimating: false)
            if let infoMessage = infoMessage {
                self?.infoLabel.isHidden = false
                self?.infoLabel.text = infoMessage
            } else {
                self?.infoLabel.isHidden = true
            }
            self?.planetsTableView.reloadData()
        }
    }
    
    // Show/Hide the loader
    // When isAnimating is false, will hide the loader else will show the loader
    func handleApiLoader(isAnimating: Bool) {
        self.loader.isHidden = !isAnimating
    }
}

// MARK: UITableView DataSource
extension PlanetsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetsTableViewCell.identifier, for: indexPath) as? PlanetsTableViewCell else { fatalError(Messages.xibLoadingError) }
        cell.planet = viewModel.getPlanetsCellModel(at: indexPath)
        return cell
    }
}

// MARK: UITableView Delegate
extension PlanetsViewController: UITableViewDelegate {
    
    //Setting the tableview height to auto dimension.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
