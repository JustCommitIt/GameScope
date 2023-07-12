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

    var dataSource: UICollectionViewDiffableDataSource<Section, GameDetail>! = nil
    var detailCollectionView: UICollectionView! = nil

    var detail: GameDetail?
    var thumbnailImage: UIImage?

    convenience init(gameDetail: GameDetail, withThumbnail thumbnail: UIImage) {
        self.init()
        detail = gameDetail
        thumbnailImage = thumbnail
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = detail?.title
        configureCollectionView()
        configureDataSource()
    }
}

extension DetailViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: DetailViewController.headerElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        detailCollectionView = collectionView
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, GameDetail>(collectionView: detailCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: GameDetail) -> UICollectionViewCell? in
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

        dataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
                fatalError("Cannot create header view")
            }
            supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }
    }

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
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
