//
//  ViewController.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/06/29.
//

import UIKit
import SnapKit

enum ListType {
    case popularity
    case releaseDate
}

final class ViewController: UIViewController {

    // MARK: - Constants
    private typealias DataSource = UICollectionViewDiffableDataSource<ListType, Game>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ListType, Game>

    // MARK: - Properties
    private var listType: ListType = .popularity

    // MARK: - UI Components

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public

    // MARK: - Private

}
