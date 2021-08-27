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
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let result = game{
            let data = try! Data(contentsOf: ((URL(string: result.imageGame)))!)
            
            imageGame.image = Helper.cropToBounds(image: UIImage(data: data)!,width: 382,height: 240)
            nameGame.text = result.nameGame
            ratingGame.text = String(result.rating)
            reviewGame.text = String(result.reviewCount)
            playtimeGame.text = String(result.playtime)
            releaseDateGame.text = Helper.formatDate(dateInput: result.releaseDate)
            
            var genre = String()
            for item in result.genres {
                genre += "\(item.name) "
            }
            
            genreGame.text = genre
        }
    }

}
