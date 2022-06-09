import UIKit
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        }
        else if !hasSearched {
            return 0
        } else if searchResults.count == 0{
            return 1
        }else{
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isLoading{
            if searchResults.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Properties.emptyCell, for: indexPath)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: Properties.searchResultCellIdentifier, for: indexPath) as! SearchResultCell
                let searchResult = searchResults[indexPath.row]
                cell.nameLabel.text = searchResult.name
                if searchResult.artist.isEmpty{
                    cell.artistNameLabel.text = "Unknown"
                }else{
                    cell.artistNameLabel.text = String(format: "%@ (%@)", searchResult.artist, searchResult.type)
                }
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Properties.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(1000) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
}


