//
//  DetailScreen.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

import UIKit

class DetailScreen: BaseVC {
    
    init(id: Int, title: String, subtitle: String) {
        viewModel = DetailViewModel(id: id, title: title, subtitle: subtitle)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var viewModel: DetailViewModelProtocol!
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var shortDescriptionLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var descriptionLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupScreen()
    }
    
    private func setupScreen() {
        titleLabel.text = viewModel.newsTitle
        shortDescriptionLabel.text = viewModel.shortDescription
        view.addSubview(titleLabel)
        view.addSubview(shortDescriptionLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        shortDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(shortDescriptionLabel.snp.bottom).offset(12)
        }
    }
    
    private func bindViewModel() {
        viewModel.news.bind { [weak self] news in
            guard let self = self,
                  let _ = news else { return }
            configureDescriptionLabel()
        }
    }
    
    private func configureDescriptionLabel() {
        guard let news = viewModel.news.value else { return }
        self.descriptionLabel.attributedText = news.fullDescription.htmlToAttributedString()
        self.descriptionLabel.textColor = .white
    }
}
