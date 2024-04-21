//
//  ViewController.swift
//  ImageScroller
//
//  Created by madhur bansal on 21/04/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var imageArr: [ApiModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
    }

    private func setUp() {
        collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    private func loadData() {
        Network().getImages { imageArr, message in
            if message != "" {
                self.showAlert(message: message)
            }
            self.imageArr = imageArr
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.loadData()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        cell.configure(imageArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 3
        
        return CGSize(width: width, height: width)
    }
}
