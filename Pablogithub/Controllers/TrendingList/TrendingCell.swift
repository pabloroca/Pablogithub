//
//  TrendingCell.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

class TrendingCell: UITableViewCell {
    
    static let designatedHeight: CGFloat = 60

    private struct LayoutConstants {
        static let verticalSpacing: CGFloat = 5.0
    }

    // MARK: - UI Elements

    private let lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorMain
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblStars: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontSubtitle()
        label.textColor = UIColor.pr2ColorMain
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontSubtitle()
        label.textColor = UIColor.pr2ColorMain
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(lblName)
        contentView.addSubview(lblStars)
        contentView.addSubview(lblDescription)

        contentView.backgroundColor = UIColor.pr2White
        contentView.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {

        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.kMarginNormal),
            lblName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.kMarginNormal),
            lblName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.kMarginNormal),
            //
            lblStars.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: LayoutConstants.verticalSpacing),
            lblStars.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.kMarginNormal),
            lblStars.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.kMarginNormal),
            //
            lblDescription.topAnchor.constraint(equalTo: lblStars.bottomAnchor, constant: LayoutConstants.verticalSpacing),
            lblDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.kMarginNormal),
            lblDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.kMarginNormal),
            lblDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.verticalSpacing)
            ])

        super.updateConstraints()

    }

    override func prepareForReuse() {
        self.contentView.backgroundColor = UIColor.pr2White
        lblName.text = nil
        lblName.textColor = UIColor.pr2ColorMain

        lblStars.text = nil
        lblStars.textColor = UIColor.pr2ColorMain

        lblDescription.text = nil
        lblDescription.textColor = UIColor.pr2ColorMain
        super.prepareForReuse()

    }

    func configure(viewModel: Trending) {
        lblName.text = viewModel.name
        lblStars.text = "\(viewModel.currentPeriodStars) stars"
        lblDescription.text = viewModel.description
    }
}
