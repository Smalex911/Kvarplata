//
//  ViewController.swift
//  Kvarplata
//
//  Created by Александр Смородов on 22.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayData: [MetersData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MainCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MainCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrayData = MetersDataInteractor.getAll()
    }
    
    func style() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = headerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerView.insertSubview(blurEffectView, at: 0)
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
}

