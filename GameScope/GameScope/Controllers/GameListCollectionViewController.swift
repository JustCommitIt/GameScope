//
//  GameListCollectionViewController.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/06/29.
//

import UIKit
import SnapKit

final class GameListCollectionViewController: UIViewController {

    enum ListType {
        case popularity
        case releaseDate
    }

    enum Section {
        case main
    }

    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Game>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Game>

    // MARK: - Properties
    private var listType: ListType = .popularity
    private var gameManager = GameManager()
    private lazy var dataSource: DataSource = configureDataSource()
    private var games: GameList = [] {
        didSet {
            applySnapShot()
        }
    }

    // MARK: - UI Components
    private lazy var gameListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout())
        collectionView.register(
            GameListCollectionViewCell.self,
            forCellWithReuseIdentifier: GameListCollectionViewCell.identifier)

        return collectionView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListType()
        setUI()
    }

    // MARK: - Public

    // MARK: - Private
    private func checkListType() {
        switch listType {
        case .popularity:
            guard let list = gameManager.dispatchPopGames() else { return }
            games = list
        case .releaseDate:
            guard let list = gameManager.dispatchLatestGames() else { return }
            games = list
        }
    }

    private func setUI() {
        view.addSubview(gameListCollectionView)
        setUIlayout()
    }

    private func setUIlayout() {
        gameListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

}

extension GameListCollectionViewController {

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(80)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(80)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)

            return section
        }
        return layout
    }

    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: gameListCollectionView) { collectionView, indexPath, game in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GameListCollectionViewCell.identifier,
                for: indexPath
            ) as? GameListCollectionViewCell

            Task {
                let thumbnailImage = try await self.gameManager.dispatchThumnail(of:game)
                cell?.updateThumbnail(with: thumbnailImage)
            }
            cell?.configure(index: indexPath.item, game: game)

            return cell
        }
        return dataSource
    }

    private func applySnapShot() {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(games)
        dataSource.apply(snapShot)
    }

}