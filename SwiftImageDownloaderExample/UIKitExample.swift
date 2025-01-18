//
//  UIKitExample.swift
//  SwiftImageDownloaderExample
//
//  Created by Ratnesh Jain on 18/01/25.
//

#if canImport(UIKit)
import Foundation
import AsyncImageView

import UIKit

class ViewController: UIViewController {
    
    var items: [URL] = Array(1...100).compactMap {
        URL(string: "https://picsum.photos/id/\($0)/200/200")
    }
    
    enum Section: Hashable {
        case main
    }
    
    private var layout: UICollectionViewCompositionalLayout = {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2))
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: String(describing: ImageCell.self))
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, URL> = {
        UICollectionViewDiffableDataSource<Section, URL>(collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell
            cell?.configure(url: itemIdentifier)
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        applySnapshot()
    }
    
    private func configureViews() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, URL>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        self.dataSource.apply(snapshot)
    }
    
    class ImageCell: UICollectionViewCell {
        private lazy var imageView: AsyncImageView = {
            let imageView = AsyncImageView()
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureViews()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            configureViews()
        }
        
        private func configureViews() {
            self.contentView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            ])
        }
        
        func configure(url: URL) {
            self.imageView.url = url
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            self.imageView.prepareForReuse()
        }
    }
}

#Preview {
    ViewController()
}

#endif
