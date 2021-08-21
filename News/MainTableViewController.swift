//
//  TableViewController.swift
//  News
//
//  Created by Andrey Samchenko on 20.08.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func refreshControl(_ sender: Any) {
        fetchArticles {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToArticle", sender: self)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToArticle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? ArticleViewController)?.article = articles[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
