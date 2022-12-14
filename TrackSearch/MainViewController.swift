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
       
        AF.request(urlString)
            .responseJSON { [weak self] dataResponse in
            print(dataResponse)
            guard let statusCode = dataResponse.response?.statusCode else { return }
            if (200...299).contains(statusCode) {
                guard let value = dataResponse.value else { return }
                print("VALUE:", value)
            } else {
                guard let error = dataResponse.error else { return }
                print("ERROR:", error)
            }
                print("STATUS CODE:", statusCode)
                switch dataResponse.result {
                case .success(let value):
                    self?.results = Reply.getTracks(from: value)
                    self?.table.reloadData()

                case .failure(let error):
                    print(error)
                }
        }
        
        
//        NetworkManager.shared.fetchRequest(urlString: urlString) { [weak self] result in
//            switch result {
//            case .success(let reply):
//                self?.results = reply.results
//                self?.table.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
        
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

        NetworkManager.shared.fetchImage(from: results[indexPath.row].artworkUrl100) { result in
            switch result {
            case .success(let imageData):
                print("???????????????? ??A????????????")
                content.image = UIImage(data: imageData)
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
     
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(textField.text!)
        guard let str = textField.text else { return false }
        searchInitiated(for: str)
        return true
    }
}
 //       guard let str = textField.text else { return }
//        let searchString = str.replacingOccurrences(of: " ", with: "+")
//        print(str, searchString)
//        let urlString = "https://itunes.apple.com/search?term=\(searchString)&limit=5"
//        print("URL \(urlString)")
//
//        NetworkManager.shared.fetchRequest(urlString: urlString) { [weak self] result in
//            switch result {
//            case .success(let reply):
//                self?.results = reply.results
//                self?.table.reloadData()
////                reply.results.map{ track in
////                    print(track.trackName)
////                    self?.reply = reply
////                    self?.table.reloadData()
////                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//        return true
//    }
//}
