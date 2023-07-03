//
//  gameListCollectionViewCell.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/06/30.
//

import UIKit
import SnapKit

final class gameListCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    enum Constants {
        static let gameTitleLabelFontSize: CGFloat = 15
        static let gameDescribsionLabelFontSize: CGFloat = 12
        static let squareThumbnailImageSize: CGFloat = 72
        static let squareBadgeImageSize: CGFloat = 26
        static let labelNumberOfLines: Int = 2

        static let rankBedgeInset: CGFloat = 6
        static let thumbnailAndInfoContainerInset: CGFloat = 10
        static let TitleAndDescribsionInset: CGFloat = 4

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
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.image = UIImage(systemName: Constants.defaultThumbnailImageName)
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let InformationContainerView = UIView()
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.gameTitleLabelFontSize, weight: .semibold)
        label.numberOfLines = Constants.labelNumberOfLines
        return label
    }()
    private let gameDescribsionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: Constants.gameDescribsionLabelFontSize)
        label.numberOfLines = Constants.labelNumberOfLines
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
    func configure(index: Int, game: Game, thumbnail: UIImage?) {
        gameIdNumber = game.id
        gameTitleLabel.text = game.title
        gameDescribsionLabel.text = game.shortDescription
        if let thumbnail {
            gameThumbnailImageView.image = thumbnail
        }
        setRankBedgeStyle(rank: index)
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
        InformationContainerView.addSubview(gameTitleLabel)
        InformationContainerView.addSubview(gameDescribsionLabel)
        
        contentView.addSubview(gameThumbnailImageView)
        contentView.addSubview(InformationContainerView)
        contentView.addSubview(rankBedge)

        rankBedge.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.squareBadgeImageSize)
            make.top.equalTo(gameThumbnailImageView).offset(-Constants.rankBedgeInset)
            make.leading.equalTo(gameThumbnailImageView).offset(-Constants.rankBedgeInset)
        }
        gameThumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.height)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(Constants.rankBedgeInset)
            make.centerY.equalToSuperview()
        }
        InformationContainerView.snp.makeConstraints { make in
            make.leading.equalTo(gameThumbnailImageView.snp.trailing).offset(Constants.thumbnailAndInfoContainerInset)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        gameTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        gameDescribsionLabel.snp.makeConstraints { make in
            make.top.equalTo(gameTitleLabel.snp.bottom).offset(Constants.TitleAndDescribsionInset)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

}
