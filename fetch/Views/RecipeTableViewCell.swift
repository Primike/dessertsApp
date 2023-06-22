//
//  RecipeTableViewCell.swift
//  fetch
//
//  Created by Prince Avecillas on 6/21/23.
//

import Foundation
import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    static let reuseID = "RecipeCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        let placeholder = UIImage(named: "default")
        
        if let url = URL(string: viewModel.image) {
            imageView.kf.setImage(with: url, placeholder: placeholder)
        } else {
            imageView.image = placeholder
        }
        
        return imageView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    func configure(name: String) {
        label.text = name
        
        layout()
    }
    
    private func layout() {
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }

}
