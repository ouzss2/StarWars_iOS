//
//  ViewController.swift
//  starWars
//
//  Created by Tekup-mac-1 on 3/2/2024.
//

import UIKit
import Foundation

struct FilmResponse: Codable {
    let results: [Film]
}

class CustomCell:UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var daterel: UILabel!
    @IBOutlet weak var dir: UILabel!
    @IBOutlet weak var prod: UILabel!
    @IBOutlet weak var desc: UITextView!
    
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var films: [Film] = []
    var currentFilm: Film?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        fetchDataFromAPI()
    }
    //Fetching
    func fetchDataFromAPI() {
        fetchFilms { result in
            switch result {
            case .success(let films):
                self.films = films
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch films: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mv", for: indexPath) as! CustomCell
        
        let film = films[indexPath.row]
        
        cell.title.text = film.title
        cell.daterel.text = film.release_date
        cell.dir.text = film.director
        cell.prod.text = film.producer
        cell.desc.text = film.opening_crawl
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentFilm = films[indexPath.row]
        print("didselect")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "seg1"{
            let controller = segue.destination as! SegueController
            controller.film = sender as? Film
        }*/
        if let destinationVC = segue.destination as? SegueController{
            
            destinationVC.film = currentFilm
       
        }
    }
}
extension ViewController {
    func fetchFilms(completion: @escaping (Result<[Film], Error>) -> Void) {
        guard let url = URL(string: "https://swapi.dev/api/films/") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let filmResponse = try JSONDecoder().decode(FilmResponse.self, from: data)
                completion(.success(filmResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

/*extension ViewController{
    func fetchFilms(completion: @escaping (Result<[Film], Error>) -> Void) {
            guard let url = URL(string: "https://swapi.dev/api/films/") else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }
        let session = URLSession.shared
                
                let task = session.dataTask(with: url) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                        return
                    }
                    
                    do {
                        let films = try JSONDecoder().decode([Film].self, from: data)
                        completion(.success(films))
                    } catch {
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            }
}*/
