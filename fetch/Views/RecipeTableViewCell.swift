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
    
    func configure(viewModel: RecipesViewModel, indexPath: IndexPath) {
        textLabel?.numberOfLines = 0
        imageView?.contentMode = .scaleAspectFit

        textLabel?.text = viewModel.getCellName(for: indexPath)
        
        let placeholder = UIImage(named: "recipeimage")
        
        if let url = URL(string: viewModel.getCellImageURL(for: indexPath)) {
            imageView?.kf.setImage(with: url, placeholder: placeholder)
        } else {
            imageView?.image = placeholder
        }
    }
}
