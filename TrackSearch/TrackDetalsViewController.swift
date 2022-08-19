//
//  TrackDetalsViewController.swift
//  TrackSearch
//
//  Created by John Doe on 19/08/2022.
//

import Foundation
import UIKit

class TrackDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageViewTrack: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    
    var track: Track!
    var trackTitleDetails: UIImage! = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchImage(from: track.artworkUrl100 ?? "") { [weak self] result in
            switch result {
            case .success(let imageData):
                print("СНОВА ПОЛУЧИЛИ КAРТИНКУ")
                self?.imageViewTrack.image =  UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    
        trackLabel.text = track.artistName
//        imageViewTrack.image = trackTitleDetails
        
    }
}
