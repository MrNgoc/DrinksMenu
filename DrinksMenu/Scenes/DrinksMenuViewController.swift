//
//  DrinksMenuViewController.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 03/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class DrinksMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DrinksMenuViewModel!
    lazy var refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTableView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
            .mapToVoid()
            .startWith(())
        
        let input = DrinksMenuViewModel.Input(trigger: pull)
        let output = viewModel.transform(input: input)
        
        output.drinks.drive(tableView.rx.items(cellIdentifier: "cell", cellType: DrinkTableViewCell.self)) { row, viewModel, cell in
            cell.configData(viewModel)
        }
        .disposed(by: disposeBag)
        
        output.error.drive { error in
            debugPrint(error)
        }
        .disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    private func configureViews() {
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        navigationController?.navigationBar.barTintColor =  UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "DrinkTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.refreshControl = refreshControl
    }
}
