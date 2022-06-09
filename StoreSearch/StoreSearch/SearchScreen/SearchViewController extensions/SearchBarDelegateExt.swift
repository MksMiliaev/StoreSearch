import UIKit

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if !text.isEmpty {
            let prepearedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            searchBar.resignFirstResponder()
            hasSearched = true
            isLoading = true
            tableView.reloadData()
            searchResults = []
            let url = iTunesURL(searchText: prepearedText)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, responce, error in
                if let error = error {
                    print("Failure! \(error.localizedDescription)")
                }else if let httpResponse = responce as? HTTPURLResponse,
                         httpResponse.statusCode == 200,
                         let data = data{
//                    print("Success! \(data)")
                    self.searchResults = self.parce(data: data)
                    self.searchResults.sort(by: <)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                    self.isLoading = false
                    self.hasSearched = false
                    self.tableView.reloadData()
                    self.showNetworkAlert()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    //UI
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
