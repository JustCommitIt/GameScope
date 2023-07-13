//
//  InformationView.swift
//  GameScope
//
//  Created by 박재우 on 2023/07/13.
//

import UIKit

class InformationView: UIStackView {

    let titleLabel = UILabel()
    let informationLabel = UILabel()

    override func layoutSubviews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(informationLabel)

        axis = .vertical
        distribution = .fillEqually
        
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.textColor = #colorLiteral(red: 0.3450980392, green: 0.3450980392, blue: 0.3450980392, alpha: 1)

        informationLabel.font = .preferredFont(forTextStyle: .title3)
    }

}
