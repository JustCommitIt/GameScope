//
//  DetailViewController.swift
//  GameScope
//
//  Created by 박재우 on 2023/07/01.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, UICollectionViewDelegate {

    static let headerElementKind = "header-element-kind"

    enum Section: String, CaseIterable {
        case thumbnail
        case about = "About"
        case information = "Information"
        case screenshots = "ScreenShots"
    }

    private lazy var detailCollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: generateLayout())

        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: DetailViewController.headerElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(
            GameDetailInformationCell.self,
            forCellWithReuseIdentifier: GameDetailInformationCell.reuseIdentifier)
        collectionView.register(
            GameDetailDescriptionCell.self,
            forCellWithReuseIdentifier: GameDetailDescriptionCell.reuseIdentifier)
        collectionView.register(
            GameDetailImageCell.self,
            forCellWithReuseIdentifier: GameDetailImageCell.reuseIdentifier)
        return collectionView
    }()
    private let boundarySupplementaryHeader = {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: DetailViewController.headerElementKind,
            alignment: .top)
        return sectionHeader
    }()

    private var detail: GameDetail?

    convenience init(gameDetail: GameDetail) {
        self.init()
        detail = gameDetail
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = detail?.title

        view.addSubview(detailCollectionView)
    }

}

extension DetailViewController {

    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .thumbnail, .screenshots:
                return self.generateImageLayout()
            case .about:
                return self.generateAboutLayout()
            case .information:
                return self.generateInformationLayout()
            }
        }
        return layout
    }

    private func generateAboutLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [boundarySupplementaryHeader]
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    private func generateInformationLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [boundarySupplementaryHeader]
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    private func generateImageLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [boundarySupplementaryHeader]
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }
}

extension DetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let detail else {
            return 0
        }

        switch Section.allCases[section] {
        case .thumbnail, .about, .information:
            return 1
        case .screenshots:
            return detail.screenshots.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detail else {
            return UICollectionViewCell()
        }

        switch Section.allCases[indexPath.section] {
        case .thumbnail:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GameDetailImageCell.reuseIdentifier,
                for: indexPath) as? GameDetailImageCell else {
                return UICollectionViewCell()
            }
            cell.configure(urlString: detail.thumbnail)
            return cell
        case .about:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GameDetailDescriptionCell.reuseIdentifier,
                    for: indexPath) as? GameDetailDescriptionCell else {
                return UICollectionViewCell()
            }
            cell.configure(description: detail.description)
            cell.delegate = self
            return cell
        case .information:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GameDetailInformationCell.reuseIdentifier,
                    for: indexPath) as? GameDetailInformationCell else {
                return UICollectionViewCell()
            }
            cell.configure(information: detail)
            return cell
        case .screenshots:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GameDetailImageCell.reuseIdentifier,
                for: indexPath) as? GameDetailImageCell else {
                return UICollectionViewCell()
            }
            cell.configure(urlString: detail.screenshots[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == DetailViewController.headerElementKind,
           let HeaderView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath) as? HeaderView {
            HeaderView.label.text = Section.allCases[indexPath.section].rawValue
            return HeaderView
        }

        return UICollectionReusableView()
    }

}

extension DetailViewController: GameDetailDescriptionCellDelegate {
    func gameDetailDescriptionCell(
        _ gameDetailDescriptionCell: GameDetailDescriptionCell,
        didButtonTapped sender: UIButton
    ) {
        gameDetailDescriptionCell.expandDetailDescription()
        self.detailCollectionView.reloadData()
    }
}
