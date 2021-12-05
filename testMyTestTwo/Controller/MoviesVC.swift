//
//  MoviesVC.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 07/11/2021.
//

import UIKit
import AVKit
import AVFoundation

class MoviesVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var emptyPaper: UIImageView!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    //MARK: - Variables
    var arrOfMedia: [Media] = []
    var resultSegment: String! = "all"
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: userDefultsKeys.isLoggedIn)
        SetUp()
        setupNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        getTheLastMedia()
    }
    
    //MARK: - functions
    private func SetUp(){
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.register(UINib(nibName: Cells.movieCell, bundle: nil), forCellReuseIdentifier: Cells.movieCell)
        searchBar.delegate = self
    }
    
    private func setMovieData(searchName: String , type: String){
        ApiManager.loadMediaArr(term: searchName, media: type) { error, mediaArr in
            if let  error = error{
                print(error.localizedDescription)
            } else if let mediaArr = mediaArr {
                self.arrOfMedia = mediaArr
                self.tabelView.reloadData()
            }
        }
    }
    
    private func setupNavBar(){
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "Search"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    @objc private func goToProfileVC(){
        let sb = UIStoryboard(name: ViewContollers.main, bundle: nil)
        let profileVC = sb.instantiateViewController(withIdentifier: ViewContollers.profileVC)as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    //MARK: - Actions
    @IBAction func mediaSegmentBarTapped(_ sender: UISegmentedControl) {
        switch mediaSegmentedControl.selectedSegmentIndex {
        case 0:
            resultSegment =  mediaSegmentedControl.titleForSegment(at: mediaSegmentedControl.selectedSegmentIndex)!
        case 1:
            resultSegment =  mediaSegmentedControl.titleForSegment(at: mediaSegmentedControl.selectedSegmentIndex)!
        case 2:
            resultSegment =  mediaSegmentedControl.titleForSegment(at: mediaSegmentedControl.selectedSegmentIndex)!
        case 3:
            resultSegment =  mediaSegmentedControl.titleForSegment(at: mediaSegmentedControl.selectedSegmentIndex)!
        default:
            resultSegment = ResultSegment.all
        }
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension MoviesVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell, for: indexPath)as! MovieCell
        let media = arrOfMedia[indexPath.row]
        cell.resultOfSegment(result: resultSegment, media: media)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = arrOfMedia[indexPath.row].trailer!
        let mediaUrl = URL(string: media)
        self.playVideo(url: mediaUrl!)
    }
}

//MARK: - UISearchBarDelegate
extension MoviesVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text , search != "" {
            if !resultSegment.isEmpty{
                emptyPaper.isHidden = true
                tabelView.isHidden = false
                searchBar.endEditing(true)
                self.setMovieData(searchName: search, type: self.resultSegment)
                SqlManager.shared().lastSearch(name: search, type: self.resultSegment)
            }
        }else{
            emptyPaper.isHidden = false
            tabelView.isHidden = true
            searchBar.endEditing(true)
        }
    }
    
    func getTheLastMedia(){
        let name = SqlManager.shared().getLastSearch().name
        let type = SqlManager.shared().getLastSearch().type
        if type == "" || name == ""{
            self.resultSegment = ResultSegment.all
            tabelView.isHidden = true
            emptyPaper.isHidden = false
        }else{
            self.resultSegment = type
            self.setMovieData(searchName: name, type: type)
        }
        setSegmanet()
    }
    
    private func setSegmanet() {
        switch self.resultSegment {
        case "tvShow":
            mediaSegmentedControl.selectedSegmentIndex = 2
        case "movie":
            mediaSegmentedControl.selectedSegmentIndex = 3
        case "music":
            mediaSegmentedControl.selectedSegmentIndex = 1
        default:
            mediaSegmentedControl.selectedSegmentIndex = 0
        }
    }
}
