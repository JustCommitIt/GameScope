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

extension DetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
        default:
            return UICollectionViewCell()
        }
    }

}
