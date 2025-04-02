//
//  BaseVC.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

import UIKit

class BaseVC: UIViewController {
    
    var gradient: CAGradientLayer!
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Здесь пока ничего нет..."
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackGradient()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureTableView() {}
    
    func setupBackGradient() {
        gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1).cgColor, #colorLiteral(red: 0.1622289541, green: 0.239389881, blue: 1, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func commonInit() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.bottom.equalToSuperview()
        }
    }
    
    func showEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
}
