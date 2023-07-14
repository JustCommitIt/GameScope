//
//  GameListCollectionViewController.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/06/29.
//

import UIKit
import SnapKit

final class GameListCollectionViewController: UIViewController {

    enum ListType: CaseIterable {
        case popularity
        case releaseDate
    }

    enum Section {
        case main
    }

    // MARK: - Constants
    enum Constants {
        static let additionalSafeAreaTopInsets: CGFloat = 70
        static let sideLayoutGuideInset: CGFloat = 24
        static let subjectButtonFontSize: CGFloat = 30
        static let seperatorLineViewTopOffset: CGFloat = 5
    }

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
    private lazy var subjectButton: UIButton = {
        let button = UIButton()
        button.setTitle("ALL", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(subjectButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: Constants.subjectButtonFontSize, weight: .heavy)
        return button
    }()

    private lazy var seperatorLineView: UIView = {
        let seperatorView = UIView()
        seperatorView.backgroundColor = .separator
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return seperatorView
    }()
    private lazy var segmentControl: UISegmentedControl = {
        let segmentItems = ListType.allCases.map { String(describing: $0) }
        let segmentControl = UISegmentedControl(items: segmentItems)
        segmentControl.selectedSegmentIndex = .zero
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = .init(hex: "9FEBD9")

        for index in .zero...segmentItems.count-1 {
            segmentControl.setWidth(view.frame.width*0.4, forSegmentAt: index)
        }

        return segmentControl
    }()

    private lazy var gameListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout())
        collectionView.register(
            GameListCollectionViewCell.self,
            forCellWithReuseIdentifier: GameListCollectionViewCell.identifier)
        collectionView.clipsToBounds = false
        return collectionView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListType()
        setUI()
    }

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
        navigationController?.view.addSubview(subjectButton)
        navigationController?.view.addSubview(seperatorLineView)
        navigationItem.titleView = segmentControl
        navigationController?.additionalSafeAreaInsets.top = Constants.additionalSafeAreaTopInsets
        setUIlayout()
    }

    private func setUIlayout() {
        guard let navigationController else { return }

        subjectButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.sideLayoutGuideInset)
        }
        seperatorLineView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Constants.sideLayoutGuideInset)
            make.centerX.equalToSuperview()
            make.top.equalTo(subjectButton.snp.bottom).offset(Constants.seperatorLineViewTopOffset)
            make.bottom.equalTo(navigationController.navigationBar.snp.top)
        }

        gameListCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

    @objc
    private func subjectButtonTapped() {
        print(#function)
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
