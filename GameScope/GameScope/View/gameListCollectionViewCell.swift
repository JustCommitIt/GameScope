//
//  gameListCollectionViewCell.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/06/30.
//

import UIKit
import SnapKit

class gameListCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    enum Constants {
        static let gameTitleLabelFontSize: CGFloat = 20
        static let gameDescribsionLabelFontSize: CGFloat = 11
        static let squareThumbnailImageSize: CGFloat = 72
        static let squareBadgeImageSize: CGFloat = 26

        static let firstRankBadgeImageName = "RankBedgeGold"
        static let secondRankBadgeImageName = "RankBedgeSilver"
        static let thirdRankBadgeImageName = "RankBedgeBronze"
        static let defaultThumbnailImageName = "gamecontroller.fill"
    }

    // MARK: - Properties
    private var gameIdNumber: Int?

    // MARK: - UI Components
    private let rankBedge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        return imageView
    }()
    private let gameThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: Constants.defaultThumbnailImageName)
        return imageView
    }()
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.gameTitleLabelFontSize)
        return label
    }()
    private let gameDescribsionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.gameDescribsionLabelFontSize)
        return label
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configure(indexpath: IndexPath, game: Game, thumbnail: UIImage?) {
        gameIdNumber = game.id
        gameTitleLabel.text = game.title
        gameDescribsionLabel.text = game.shortDescription
        if let thumbnail {
            gameThumbnailImageView.image = thumbnail
        }
        setRankBedgeStyle(rank: indexpath.row)
    }

    // MARK: - Private
    private func setRankBedgeStyle(rank: Int) {
        guard rank < 3 else {
            rankBedge.isHidden = true
            return
        }
        rankBedge.isHidden = false
        switch rank {
        case 0:
            rankBedge.image = UIImage(named: Constants.firstRankBadgeImageName)
        case 1:
            rankBedge.image = UIImage(named: Constants.secondRankBadgeImageName)
        case 2:
            rankBedge.image = UIImage(named: Constants.thirdRankBadgeImageName)
        default:
            rankBedge.image = nil
        }
    }

    private func setupLayout() {
        contentView.addSubview(gameThumbnailImageView)
        contentView.addSubview(gameTitleLabel)
        contentView.addSubview(gameDescribsionLabel)
        contentView.addSubview(rankBedge)

        rankBedge.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.squareBadgeImageSize)
            make.top.leading.equalToSuperview()
        }
        gameThumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.squareThumbnailImageSize)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            make.centerY.equalToSuperview()
        }
        gameTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameThumbnailImageView)
            make.top.equalToSuperview()
        }
        gameDescribsionLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameThumbnailImageView)
            make.top.equalTo(gameTitleLabel)
        }
    }

}
