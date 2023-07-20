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
            case .thumbnail:
                return nil
            case .about:
                return self.generateAboutLayout()
            case .information:
                return self.generateInformationLayout()
            case .screenshots:
                return nil
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
}

extension DetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .information:
            return 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
        case .information:
            guard let detail = detail,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GameDetailInformationCell.reuseIdentifier,
                    for: indexPath) as? GameDetailInformationCell else {
                return UICollectionViewCell()
            }
            cell.configure(information: detail)
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == DetailViewController.headerElementKind,
           let HeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView {
            HeaderView.label.text = Section.allCases[indexPath.section].rawValue
            return HeaderView
        }

        return UICollectionReusableView()
    }
}
