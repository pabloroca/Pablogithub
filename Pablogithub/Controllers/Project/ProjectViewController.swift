//
//  ProjectViewController.swift
//  Pablogithub
//
//  Created by Pablo Roca on 27/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit
import Kingfisher
import MarkdownView

private struct LayoutConstants {
    static let imageWidth: CGFloat = 60.0
}

final class ProjectViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: ProjectViewModel!

    // MARK: - UI Elements

    private let waitingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var viewAvatar: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = LayoutConstants.imageWidth/2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lblUserName: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorOrange
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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var segStarsForks: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: viewModel.segmentedControlItems)
        segmentedControl.tintColor = UIColor.pr2ColorMain
        segmentedControl.isUserInteractionEnabled = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private lazy var viewMarkDown: MarkdownView = {
        let view = MarkdownView()
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init

    init(viewModel: ProjectViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        refreshData()
    }

    // MARK: - Private

    private func configureUI() {
        title = viewModel.project?.name
        view.backgroundColor = UIColor.pr2White

        view.addSubview(waitingIndicator)
        view.addSubview(viewAvatar)
        view.addSubview(lblUserName)
        view.addSubview(lblDescription)
        view.addSubview(segStarsForks)
        view.addSubview(viewMarkDown)

        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (navigationController?.navigationBar.frame.height ?? 0.0)

        NSLayoutConstraint.activate([
            waitingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waitingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight+Constants.kMarginBig),
            viewAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewAvatar.widthAnchor.constraint(equalToConstant: LayoutConstants.imageWidth),
            viewAvatar.heightAnchor.constraint(equalToConstant: LayoutConstants.imageWidth),
            lblUserName.topAnchor.constraint(equalTo: viewAvatar.bottomAnchor, constant: Constants.kMarginBig),
            lblUserName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblDescription.topAnchor.constraint(equalTo: lblUserName.bottomAnchor, constant: Constants.kMarginBig),
            lblDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.kMarginBig),
            lblDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.kMarginBig),
            segStarsForks.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 3*Constants.kMarginBig),
            segStarsForks.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewMarkDown.topAnchor.constraint(equalTo: segStarsForks.bottomAnchor, constant: Constants.kMarginBig),
            viewMarkDown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewMarkDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.kMarginSmall),
            viewMarkDown.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.kMarginSmall),
            viewMarkDown.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -Constants.kMarginSmall)
            ])
    }

    private func refreshData() {
        waitingIndicator.isHidden = false
        waitingIndicator.startAnimating()

        // refresh data we already know
        lblUserName.text = viewModel.project.author
        lblDescription.text = viewModel.project.description

        viewModel.readUserInfoAndReadme { [weak self] (success) in
            guard let self = self else { return }
            self.waitingIndicator.isHidden = true
            self.waitingIndicator.stopAnimating()
            if success {
                // avatar
                guard let avatarURLString = self.viewModel.userInfo?.avatar_url else { return }
                let url = URL(string: avatarURLString)

                // download image with KingFisher
                self.viewAvatar.kf.indicatorType = .activity
                self.viewAvatar.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "person"),
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                // readme
                // called when rendering finished
                self.viewMarkDown.onRendered = { _ in
                    self.view.setNeedsLayout()
                }
                self.viewMarkDown.load(markdown: self.viewModel.readme)
            }
        }

    }

}
