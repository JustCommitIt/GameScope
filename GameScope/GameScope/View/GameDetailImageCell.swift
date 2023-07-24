//
//  GameDetailImageCell.swift
//  GameScope
//
//  Created by 박재우 on 2023/07/24.
//

import UIKit

class GameDetailImageCell: UICollectionViewCell {

    static let reuseIdentifier = "GameDetailImageCell"

    private let imageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7496843338, green: 0.7496843338, blue: 0.7496843338, alpha: 1)
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        layer.cornerRadius = 20
        layer.masksToBounds = true

        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(urlString: String) {
        Task {
            let image = try await GameManager().dispatchImage(of: urlString)
            imageView.image = image
        }
    }
}
