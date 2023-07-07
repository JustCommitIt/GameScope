//
//  HeaderView.swift
//  GameScope
//
//  Created by 박재우 on 2023/07/07.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let reuseIdentifier = "HeaderView"

    let label = UILabel()

    override func layoutSubviews() {
        addSubview(label)

        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }

        label.font = .preferredFont(forTextStyle: .title2)
    }
}
