//
//  gameListCollectionViewCell.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/06/30.
//

import UIKit
import SnapKit

final class GameListCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: GameListCollectionViewCell.self)

    // MARK: - Constants
    enum Constants {
        static let gameTitleLabelFontSize: CGFloat = 15
        static let gameDescribsionLabelFontSize: CGFloat = 12
        static let squareThumbnailImageSize: CGFloat = 72
        static let squareBadgeImageSize: CGFloat = 26
        static let sideLayoutGuideInset: CGFloat = 24
        static let labelNumberOfLines: Int = 2

        static let badgeInset: CGFloat = 6
        static let latestDayRange: Int = 30
        static let thumbnailAndInfoContainerInset: CGFloat = 10
        static let titleAndDescribsionInset: CGFloat = 4

        static let firstRankBadgeImageName = "RankBadgeGold"
        static let secondRankBadgeImageName = "RankBadgeSilver"
        static let thirdRankBadgeImageName = "RankBadgeBronze"
        static let newBadgeImageName = "NewBadge"
        static let defaultThumbnailImageName = "gamecontroller.fill"
    }

    // MARK: - Properties
    private var gameIdNumber: Int?

    // MARK: - UI Components
    private let badge: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        return imageView
    }()
    private let skeletonThumbnailImage = UIImage(systemName: Constants.defaultThumbnailImageName)
    private let gameThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.image = UIImage(systemName: Constants.defaultThumbnailImageName)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    private let informationContainerView = UIView()
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

    private let cellSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
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
    func configure(index: Int, game: Game, listSortingType: ListSortingType) {
        gameIdNumber = game.id
        gameTitleLabel.text = game.title
        gameDescribsionLabel.text = game.shortDescription
        setBadgeStyle(index: index, releaseDate: game.releaseDate, listSortingType: listSortingType)
    }

    func updateThumbnail(with thumbnail: UIImage?) {
        if let thumbnail {
            gameThumbnailImageView.contentMode = .scaleAspectFill
            gameThumbnailImageView.image = thumbnail
        }
    }

    override func prepareForReuse() {
        badge.isHidden = true
        gameThumbnailImageView.contentMode = .scaleAspectFit
        gameThumbnailImageView.image = skeletonThumbnailImage
    }

    // MARK: - Private
    private func setBadgeStyle(index: Int, releaseDate: String, listSortingType: ListSortingType) {
        if listSortingType == .popularity,
           index < 3 {
            badge.isHidden = false
            switch index {
            case 0:
                badge.image = UIImage(named: Constants.firstRankBadgeImageName)
                return
            case 1:
                badge.image = UIImage(named: Constants.secondRankBadgeImageName)
                return
            case 2:
                badge.image = UIImage(named: Constants.thirdRankBadgeImageName)
                return
            default:
                return
            }
        }

        if listSortingType == .releaseDate,
           let days = DateHandler().dayCount(to: releaseDate),
           days > -Constants.latestDayRange {
            badge.isHidden = false
            badge.image = UIImage(named: Constants.newBadgeImageName)
        }

    }

    private func setupLayout() {
        informationContainerView.addSubview(gameTitleLabel)
        informationContainerView.addSubview(gameDescribsionLabel)
        contentView.addSubview(gameThumbnailImageView)
        contentView.addSubview(informationContainerView)
        contentView.addSubview(cellSeperator)
        contentView.addSubview(badge)

        badge.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.squareBadgeImageSize)
            make.top.equalTo(gameThumbnailImageView).offset(-Constants.badgeInset)
            make.leading.equalTo(gameThumbnailImageView).offset(-Constants.badgeInset)
        }
        gameThumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.squareThumbnailImageSize)
            make.leading.equalTo(contentView).offset(Constants.sideLayoutGuideInset)
            make.centerY.equalToSuperview()
        }
        informationContainerView.snp.makeConstraints { make in
            make.leading.equalTo(gameThumbnailImageView.snp.trailing).offset(Constants.thumbnailAndInfoContainerInset)
            make.trailing.equalToSuperview().inset(Constants.sideLayoutGuideInset)
            make.centerY.equalToSuperview()
        }
        gameTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        gameDescribsionLabel.snp.makeConstraints { make in
            make.top.equalTo(gameTitleLabel.snp.bottom).offset(Constants.titleAndDescribsionInset)
            make.leading.bottom.trailing.equalToSuperview()
        }
        cellSeperator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.equalToSuperview().inset(Constants.sideLayoutGuideInset)
            make.leading.equalTo(informationContainerView)
            make.bottom.equalToSuperview()
        }
    }

}
