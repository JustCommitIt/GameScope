//
//  GameDetailInformationCell.swift
//  GameScope
//
//  Created by 박재우 on 2023/07/13.
//

import UIKit

class GameDetailInformationCell: UICollectionViewCell {

    static let reuseIdentifier = "GameDetailInformationCell"

    enum Information: String {
        case genre = "Genre"
        case developer = "Developer"
        case releaseDate = "Release Date"
        case publisher = "Publisher"
    }

    private let genreInformationView: InformationView = {
        let informationView = InformationView()
        informationView.titleLabel.text = Information.genre.rawValue
        return informationView
    }()
    private let developerInformationView: InformationView = {
        let informationView = InformationView()
        informationView.titleLabel.text = Information.developer.rawValue
        return informationView
    }()
    private let releaseDateInformationView: InformationView = {
        let informationView = InformationView()
        informationView.titleLabel.text = Information.releaseDate.rawValue
        return informationView
    }()
    private let publisherInformationView: InformationView = {
        let informationView = InformationView()
        informationView.titleLabel.text = Information.publisher.rawValue
        return informationView
    }()

    override func layoutSubviews() {
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)

        addSubview(genreInformationView)
        addSubview(developerInformationView)
        addSubview(releaseDateInformationView)
        addSubview(publisherInformationView)

        genreInformationView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(snp.centerX).inset(5)
            make.bottom.equalTo(snp.centerY).offset(-5)
        }
        developerInformationView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalTo(snp.centerX).inset(5)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(snp.centerY).offset(-5)
        }
        releaseDateInformationView.snp.makeConstraints { make in
            make.top.equalTo(snp.centerY).offset(5)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(snp.centerX).inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        publisherInformationView.snp.makeConstraints { make in
            make.top.equalTo(snp.centerY).offset(5)
            make.leading.equalTo(snp.centerX).inset(5)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }

    func configure(information: GameDetail) {
        genreInformationView.informationLabel.text = information.genre
        developerInformationView.informationLabel.text = information.developer
        releaseDateInformationView.informationLabel.text = information.releaseDate
        publisherInformationView.informationLabel.text = information.publisher
    }

}
