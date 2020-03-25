//
//  ViewController.swift
//  VideoCollection
//
//  Created by Дмитрий Тараканов on 23.03.2020.
//  Copyright © 2020 Dmitry Angarsky. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cardCellIdentifier = "CardCell"
    let videos = Video.fetchVideo()
    var player = AVPlayer()
    let playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scaleReturn(at: collectionView.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0))
    }
    
    //MARK:-- UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! CollectionViewCell
        let video = videos[indexPath.row]
        cell.video = video
        
        return cell
    }
    
    //MARK:-- UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.layer.setAffineTransform(CGAffineTransform(scaleX: 0.85, y: 0.85))
            }
        }
        playVideo(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -200, 100, 0)
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    //MARK:-- Return scale animation
    
    private func scaleReturn(at indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5) {
            if let cell = self.collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))
            }
        }
    }
    
    //MARK:-- Play video configuration
    
    private func playVideo(at indexPath: IndexPath) {
        
        let selectedVideo = videos[indexPath.row]
        guard let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4") else { return }
        let videoPathURL = URL(fileURLWithPath: videoPath)
        player = AVPlayer(url: videoPathURL)
        self.playerViewController.player = player

        self.present(self.playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
    }
    
    //MARK: -- ContextMenuConfiguration
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
        let action1 = UIAction(title: "Archive",
                                image: UIImage(systemName: "archivebox.fill"),
                                identifier: .none,
                                state: .off) { action in
                                print("Refresh")
            }
        
        let action2 = UIAction(title: "Delete",
                               image: UIImage(systemName: "trash.fill"),
                               identifier: .none,
                               discoverabilityTitle: "delete",
                               attributes: .destructive,
                               state: .off) { action in
                                print("red")
            }
        
        return UIMenu(title: "", children: [action1, action2])
        }
        
        return configuration
    }
}
