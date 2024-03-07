//
//  SegueController.swift
//  starWars
//
//  Created by Tekup-mac-1 on 24/2/2024.
//

import UIKit
import Foundation

class SegueController: UIViewController{
    
    var film : Film?
    @IBOutlet weak var movie_name: UILabel!
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var opening_craw: UITextView!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var edited: UILabel!

    override func viewDidLoad() {
        opening_craw.text = film?.opening_crawl
        created.text = film?.created
        edited.text = film?.edited
        movie_name.text = film?.title
        release_date.text = film?.release_date
        director.text = film?.director
        producer.text = film?.producer
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("didappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("willdisappear")
    }
    
}
