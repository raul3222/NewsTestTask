//
//  NewsCell.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

import UIKit
 
class NewsCell: UITableViewCell {
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(dateLabel)
        container.addSubview(descriptionLabel)
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            
        }
    }
    
    func configureCell(with news: NewsArray) {
        titleLabel.text = news.title
        dateLabel.text = formatDate(from: news.date)
        descriptionLabel.text = news.shortDescription
    }
    
    func formatDate(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoDate) else {
            return "Wrong format"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
