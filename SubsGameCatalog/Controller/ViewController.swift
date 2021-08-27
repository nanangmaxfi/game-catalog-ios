//
//  ViewController.swift
//  SubsGameCatalog
//
//  Created by Nanang Makfi Mubarok on 20/08/21.
//

import UIKit

class ViewController: UIViewController {
    var listGames: [Game] = []
    let child = SpinnerViewController()

    @IBOutlet weak var gameTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Game Catalog"
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        gameTableView.dataSource = self
        gameTableView.delegate = self
        gameTableView.register(
            UINib(nibName: "GameTableViewCell", bundle: nil),
            forCellReuseIdentifier: "GameCell"
        )
        
        let service = ApiService()
        service.getData{ result in
            self.listGames = result
            
            DispatchQueue.main.async {
                self.gameTableView.reloadData()
                
                self.child.willMove(toParent: nil)
                self.child.view.removeFromSuperview()
                self.child.removeFromParent()
            }
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameTableViewCell{
            let game = listGames[indexPath.row]
            
            let data = try! Data(contentsOf: ((URL(string: game.imageGame)))!)
            
            cell.cellView.layer.cornerRadius = 12
            
            cell.nameGame.text = game.nameGame
            cell.releaseDateGame.text = Helper.formatDate(dateInput: game.releaseDate) 
            cell.ratingGame.text = String(game.rating)
            cell.imageGame.image = Helper.cropToBounds(image: UIImage(data: data)!,width: 64,height: 64)
            
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailGameViewController(nibName: "DetailGameViewController", bundle: nil)
        
        detail.game = listGames[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
