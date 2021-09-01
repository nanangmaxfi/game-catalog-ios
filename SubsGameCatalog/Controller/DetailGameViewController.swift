//
//  DetailGameViewController.swift
//  SubsGameCatalog
//
//  Created by Nanang Makfi Mubarok on 26/08/21.
//

import UIKit

class DetailGameViewController: UIViewController {

    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var genreGame: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    @IBOutlet weak var reviewGame: UILabel!
    @IBOutlet weak var playtimeGame: UILabel!
    @IBOutlet weak var releaseDateGame: UILabel!
    @IBOutlet weak var descriptionGame: UILabel!
    
    var game: Game?
    let child = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        if let results = game{
            let service = ApiService()
            service.getDetailGame(id: String(results.id), completion: { result in
                //self.game = result
                
                DispatchQueue.main.async {
                    let data = try! Data(contentsOf: ((URL(string: result.imageGame)))!)
        
                    self.imageGame.image = Helper.cropToBounds(image: UIImage(data: data)!,width: 382,height: 240)
                    self.nameGame.text = result.nameGame
                    self.ratingGame.text = String(result.rating)
                    self.reviewGame.text = String(result.reviewCount)
                    self.playtimeGame.text = String(result.playtime)
                    self.releaseDateGame.text = Helper.formatDate(dateInput: result.releaseDate)
        
                    var genre = String()
                    for item in result.genres {
                        genre += "\(item.name) "
                    }
        
                    self.genreGame.text = genre
                    self.descriptionGame.text = result.description
                    
                    self.child.willMove(toParent: nil)
                    self.child.view.removeFromSuperview()
                    self.child.removeFromParent()
                }
            })
        
        }
    }

}
