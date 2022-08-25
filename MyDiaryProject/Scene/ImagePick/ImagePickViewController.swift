//
//  ImagePickViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/20.
//

import UIKit
import Kingfisher

class ImagePickViewController: BaseViewController {

    let imageViewVC = ImagePickViewVC()
    let apiManager = UnsplashAPIManger.share
    var selectIndexPath: IndexPath?
    var selectImage: UIImage?
    
    var dataList: [UnSplashDataProtocol] = []
    var currentPage = 1
    
    var delegate: SelectImageDelegate?
        
    override func loadView() {
        self.view = imageViewVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        getImageURL(page: 1)
    }
    
    override func configure() {
        imageViewVC.collectionView.delegate = self
        imageViewVC.collectionView.dataSource = self
        imageViewVC.collectionView.prefetchDataSource = self
        imageViewVC.collectionView.register(ImagePickCollectionViewCell.self, forCellWithReuseIdentifier: ImagePickCollectionViewCell.identifier)
        
        imageViewVC.searchBar.delegate = self
        setNav()
    }

}

// MARK: APIManger
extension ImagePickViewController {
    
    func getImageURL(page: Int) {
        apiManager.fetchImages(page: page) {[weak self] urlList in
            guard let self = self else {return}
            
            self.dataList.append(contentsOf: urlList)
            
            DispatchQueue.main.async {
                self.imageViewVC.collectionView.reloadData()
            }
            
            print(#function, "done")
        }
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ImagePickViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickCollectionViewCell.identifier, for: indexPath) as? ImagePickCollectionViewCell else { return UICollectionViewCell()}
        
        let url = URL(string: dataList[indexPath.item].smallImageURL)!
        
        cell.imageView.kf.setImage(with: url)
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.systemBlue.cgColor : nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        selectIndexPath = indexPath
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagePickCollectionViewCell, let image = cell.imageView.image else { return }
        
        selectImage = image
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        selectImage = nil
        selectIndexPath = nil
        collectionView.reloadData()
    }
    
    
}

// TODO: 검색기능 추가
extension ImagePickViewController: UISearchBarDelegate {
    
    
    
}

//MARK: Pagenation
extension ImagePickViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            print(#function, currentPage, indexPath)
            if dataList.count - 1 == indexPath.item, 100 > currentPage {
                currentPage += 1
                getImageURL(page: currentPage)
            }
        }
    }
    
}

extension ImagePickViewController {
    
    func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(plusBarButtonTapped(_:))
        )
    }
    
    @objc func plusBarButtonTapped(_ sender: UIBarButtonItem) {
        guard let selectImage = selectImage else { return }
        presentAlert(image: selectImage)
    }
    
    func presentAlert(image: UIImage) {
        
        let alert = UIAlertController(title: "사진을 선택하시겠습니까?", message: "", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "선택", style: .default) { _ in
            
//            NotificationCenter.default.post(name: Notification.Name.imagePick, object: nil, userInfo: data)

            self.delegate?.sendImageData(image: image)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소.", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}
