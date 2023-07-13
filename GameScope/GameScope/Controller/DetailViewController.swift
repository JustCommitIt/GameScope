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

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, GameDetail>

    private lazy var dataSource = configureDataSource()
    private lazy var detailCollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: generateLayout())

        view.addSubview(collectionView)

        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: DetailViewController.headerElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier)

        return collectionView
    }()

    private var detail: GameDetail?

    convenience init(gameDetail: GameDetail) {
        self.init()
        detail = gameDetail
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = detail?.title
    }

}

extension DetailViewController {

    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: detailCollectionView) { collectionView, indexPath, item in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .thumbnail:
                return nil
            case .about:
                return nil
            case .information:
                return nil
            case .screenshots:
                return nil
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath
            ) as? HeaderView else {
                fatalError("Cannot create header view")
            }
            supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }

        return dataSource
    }

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .thumbnail:
                return nil
            case .about:
                return nil
            case .information:
                return nil
            case .screenshots:
                return nil
            }
        }
        return layout
    }

}
