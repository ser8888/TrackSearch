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
    
    let networkManager = NetworkManager()
    var reply: Reply? = nil
    
  //  @IBOutlet weak var artistLabel: UILabel!
     
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

    
    @IBAction func searchButtonPressed() {
        guard let str = textField.text else { return }
        let searchString = str.replacingOccurrences(of: " ", with: "+")
        print(str, searchString)
        let urlString = "https://itunes.apple.com/search?term=\(searchString)"
        print("URL \(urlString)")
        networkManager.fetchRequest(urlString: urlString) { [weak self] result in
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
        
//        NetworkManager.shared.fetchImage(from: course.imageUrl) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.courseImage.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
    }
        
        
        
    }
    




extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reply?.results.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = reply?.results[indexPath.row].trackName
        content.secondaryText = reply?.results[indexPath.row].artistName
        let title = reply?.results[indexPath.row].artworkUrl30
        content.image = UIImage(named: title ?? "")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
     
}
