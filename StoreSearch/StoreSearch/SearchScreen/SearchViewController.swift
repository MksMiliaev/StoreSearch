import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let searchBarHeight = searchBar.bounds.size.height
        tableView.contentInset = UIEdgeInsets(top: searchBarHeight,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        //cell register
        var cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Properties.searchResultCellIdentifier)
        cellNib = UINib(nibName: "NothingFoundCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Properties.emptyCell)
        cellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Properties.loadingCell)
        
        searchBar.becomeFirstResponder()
    }
    //----------------------------------------------------------------------------------------
    // MARK: - Helper
    //----------------------------------------------------------------------------------------
    func iTunesURL(searchText: String) -> URL{
        let urlString = String(format: "https://itunes.apple.com/search?term=%@&limit=200", searchText)
        let url = URL(string: urlString)
        return url!
    }
    
    func parce(data: Data) -> [SearchResult]{
        let decoder = JSONDecoder()
        do{
        let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        } catch{
            print("Error JSON decoding: \(error.localizedDescription)")
            debugPrint(error)
            return []
        }
    }
    
    //----------------------------------------------------------------------------------------
    // MARK: - Alerts
    //----------------------------------------------------------------------------------------
    func showNetworkAlert(){
        let alert = UIAlertController(title: "Whoops...",
                                      message: "There was an error accessing the iTunes Store.\nPlease try again.",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

