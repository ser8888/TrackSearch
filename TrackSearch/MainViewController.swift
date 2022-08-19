//
//  ViewController.swift
//  TrackSearch
//
//  Created by John Doe on 12/08/2022.
//
import UIKit
import Alamofire

class MainViewController: UIViewController {
        
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var numberOfTracksLabel: UILabel!
    
//    private var reply: Reply?
    private var results: [Track] = []
//    var trackTitle: UIImage! = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
        
    @IBAction func searchButtonPressed() {
        guard let str = textField.text else { return }
        searchInitiated(for: str)
    }
    
    private func searchInitiated( for str:String ) {
        let searchString = str.replacingOccurrences(of: " ", with: "+")
        print(str, searchString)
        let urlString = "https://itunes.apple.com/search?term=\(searchString)&limit=5"
        print("URL \(urlString)")
        NetworkManager.shared.fetchRequest(urlString: urlString) { [weak self] results in
            switch results {
            case .success(let results):
                self?.results = results
                self?.table.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - DELEGATES

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = results[indexPath.row].trackName
        content.secondaryText = results[indexPath.row].artistName

        NetworkManager.shared.fetchImage(from: results[indexPath.row].artworkUrl100 ?? "") { result in
            switch result {
            case .success(let imageData):
                print("ПОЛУЧИЛИ КAРТИНКУ")
                content.image = UIImage(data: imageData)
//                self.trackTitle = UIImage(data: imageData)
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = results[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: track )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TrackDetailsViewController else { return }
        destination.track = sender as? Track
//        destination.trackTitleDetails = trackTitle
        
        
    }
    

}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let str = textField.text else { return false }
        searchInitiated(for: str)
        return true
    }
}
