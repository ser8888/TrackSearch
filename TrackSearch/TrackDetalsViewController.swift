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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewTrack.image = UIImage(data: imageData)
        trackLabel.text = track.artistName
    }
    
    
    
    
}
