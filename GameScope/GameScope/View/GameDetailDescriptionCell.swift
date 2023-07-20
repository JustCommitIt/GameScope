//
//  GameDetailDescriptionCell.swift
//  GameScope
//
//  Created by 박재우 on 2023/07/16.
//

import UIKit

class GameDetailDescriptionCell: UICollectionViewCell {

    static let reuseIdentifier = "GameDetailDescriptionCell"

    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.sizeToFit()
        return label
    }()
    private let readMoreButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("+ Read More", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2980392157, green: 0.8196078431, blue: 0.6980392157, alpha: 1), for: .normal)
        return button
    }()
    private let descriptionStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    private var isHiddenReadMoreButton = false {
        willSet {
            readMoreButton.isHidden = newValue
        }
    }

    weak var delegate: GameDetailDescriptionCellDelegate?

    override func layoutSubviews() {
        setupHiddenReadMoreButtonIfNeeded()
    }

    func configure(description: String) {
        addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(readMoreButton)
        descriptionStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }

        descriptionLabel.text = description
        readMoreButton.addTarget(self,
                                 action: #selector(tappedReadMoreButton),
                                 for: .touchDown)
    }

    @objc private func tappedReadMoreButton(_ sender: UIButton) {
        delegate?.gameDetailDescriptionCell(self, didButtonTapped: sender)
    }

    private func setupHiddenReadMoreButtonIfNeeded() {
        guard isHiddenReadMoreButton == false,
              descriptionLabel.maxNumberOfLines > 3 else {
            return
        }

        readMoreButton.isHidden = false
    }

    func expandDetailDescription() {
        isHiddenReadMoreButton = true
        descriptionLabel.numberOfLines = 0
    }
}

private extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: .infinity)
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize,
                                           options: .usesLineFragmentOrigin,
                                           attributes: [.font: font as Any],
                                           context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

protocol GameDetailDescriptionCellDelegate: NSObject {
    func gameDetailDescriptionCell(
        _ gameDetailDescriptionCell: GameDetailDescriptionCell,
        didButtonTapped sender: UIButton
    )
}
