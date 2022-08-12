//
//  ViewController.swift
//  TrackSearch
//
//  Created by John Doe on 12/08/2022.
//
import UIKit
class MainViewController: UIViewController {
    
    @IBOutlet weak var artistLabel: UILabel!
     
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Roger Waters"
        content.secondaryText = "The Wall"
        content.image = UIImage(named: "IMG_8827")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
     
}
