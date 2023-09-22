//
//  JokeTableViewCell.swift
//  JokeApp
//
//  Created by Nitin Jain on 22/09/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    private let containerView: UIView = UIView()
    private let jokeLabel: UILabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpConstraints()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(jokeLabel)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            jokeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            jokeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            jokeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }
    
    private func setUpView() {
    
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor.yellow
        
        jokeLabel.numberOfLines = 0
    }
    
    func setData(model: JokeModel) {
        self.jokeLabel.text = model.joke
    }
}
