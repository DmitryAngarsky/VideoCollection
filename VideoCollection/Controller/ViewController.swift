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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let videos = Video.fetchVideo()
    let cardCellIdentifier = "CardCell"
    var player = AVPlayer()
    let playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    //MARK: --UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! CollectionViewCell
        let video = videos[indexPath.row]
        cell.video = video
        
        return cell
    }
    
    //MARK: --UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        playVideo(at: indexPath)
    }
    
    func playVideo(at indexPath: IndexPath) {
        
        let selectedVideo = videos[indexPath.row]
        guard let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4") else { return }
        let videoPathURL = URL(fileURLWithPath: videoPath)
        player = AVPlayer(url: videoPathURL)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
    }
}

