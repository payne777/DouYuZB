//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/31.
//

import UIKit
   
private let KItemMargin:CGFloat = 10
private let KItemW = (KScreenW - 3 * KItemMargin) / 2
private let KItemH = KItemW * 3 / 4
private let KHeaderViewH:CGFloat = 50
private let KNormalCell = "KNormalCell"
private let KPrettyCell = "KPrettyCell"
private let KHeaderViewID = "KHeaderViewID"
 

class RecommendViewController: UIViewController {

    // 懒加载
    private lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin) 
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.red
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind:"UICollectionElemetnKindSectionHeader", withReuseIdentifier: KHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forSupplementaryViewOfKind:"UICollectionElemetnKindSectionHeader", withReuseIdentifier: KNormalCell)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forSupplementaryViewOfKind:"UICollectionElemetnKindSectionHeader", withReuseIdentifier: KPrettyCell)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        // 设置UI界面
        setupUI()
        
        
    }
}

// 设置UI界面
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCell, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath)
        headerView.backgroundColor = UIColor.yellow
        return headerView
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KItemW, height: KItemMargin)
        } else {
            return CGSize(width: KItemMargin, height: KItemMargin)
        }
    }

}
