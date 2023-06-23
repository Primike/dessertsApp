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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var image: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    func configure(viewModel: RecipeCellConfigurable, indexPath: IndexPath) {
        titleLabel.text = viewModel.getCellName(for: indexPath)
        
        let placeholder = UIImage(named: "recipeimage")
        
        if let url = URL(string: viewModel.getCellImageURL(for: indexPath)) {
            image.kf.setImage(with: url, placeholder: placeholder)
        } else {
            image.image = placeholder
        }
        
        layout()
    }
    
    func layout() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(image)


        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            image.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
