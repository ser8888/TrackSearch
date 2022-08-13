//
//  ViewController.swift
//  TrackSearch
//
//  Created by John Doe on 12/08/2022.
//
import UIKit
class MainViewController: UIViewController {
        
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var reply: Reply? = nil
        
    @IBAction func searchButtonPressed() {
        guard let str = textField.text else { return }
        let searchString = str.replacingOccurrences(of: " ", with: "+")
        print(str, searchString)
        let urlString = "https://itunes.apple.com/search?term=\(searchString)&limit=5"
        print("URL \(urlString)")
       
        NetworkManager.shared.fetchRequest(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let reply):
                reply.results.map{ track in
                    print(track.trackName)
                    self?.reply = reply
                    self?.table.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

    
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reply?.results.count ?? 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
//        content.image = UIImage(named: "IMG_8827")
        content.text = reply?.results[indexPath.row].trackName
        content.secondaryText = reply?.results[indexPath.row].artistName
 //       let title = reply?.results[indexPath.row].artworkUrl30
//        content.image = UIImage(named: title ?? "")
        NetworkManager.shared.fetchImage(from: reply?.results[indexPath.row].artworkUrl60) { [weak self] result in
            switch result {
            case .success(let imageData):
                print("ПОЛУЧИЛИ КВРТИНКY")
                content.image = UIImage(data: imageData)
                self!.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
     
}

