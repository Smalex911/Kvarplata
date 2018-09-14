//
//  ViewController.swift
//  Kvarplata
//
//  Created by Александр Смородов on 22.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class MainVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayData: [MetersData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func heightBlurHeaderView() -> CGFloat {
        return 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MainCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MainCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrayData = MetersDataInteractor.getAll()
    }
    
    override func style() {
        super.style()
        
        title = TextProvider.titleMainVC()
    }
    
    @IBAction func addHandler(_ sender: Any) {
        _ = showDetailMeterVC()
    }
    
// Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.metersData = arrayData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Router.shared.detailMeters(self, metersData: arrayData[indexPath.row])
    }
}

