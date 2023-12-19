//
//  FeedVC.swift
//  SocialMedia
//
//  Created by bartek on 19/12/2023.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return userEmailArray.count
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
           cell.userEmailLabel.text = userEmailArray[indexPath.row]
           cell.likeLabel.text = String(likeArray[indexPath.row])
           cell.commentLabel.text = userCommentArray[indexPath.row]
//           cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
           cell.documentIdLabel.text = documentIdArray[indexPath.row]
           return cell
       }
}
