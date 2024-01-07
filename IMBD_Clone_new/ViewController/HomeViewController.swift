//
//  HomeViewController.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 26.08.2023.
//

import UIKit


enum Sections: Int {
    
    case Top250Movies = 0
    case MostPopularMovies = 1
    case ComingSoom = 2
    case InTheaters = 3
   
}


class HomeViewController: UIViewController {
    
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Top 250 Movies", "Most Popular Movies", "Coming Soom", "In Theaters"]
    
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
     
        configureHeroHeaderView()
        
    }
    
    private func configureHeroHeaderView() {
        
        APICaller.shared.getTop250Movies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.originalTitle ?? "", posterURL: selectedTitle?.image ?? ""))
                
                print(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func configureNavBar() {
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
       
    }
    
    // MARK: bounds home Feed Table - photo
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
            
        case Sections.Top250Movies.rawValue:
            
            APICaller.shared.getTop250Movies { result in
                switch result {
                case .success(let titles):
                  
                    cell.configure(with: titles)
                case .failure(let error):
                     print(error)
                    print(error.localizedDescription)
                }
            }
            
        case Sections.MostPopularMovies.rawValue:
            
            APICaller.shared.getMostPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
            
        case Sections.ComingSoom.rawValue:
            
            APICaller.shared.getComingSoom { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
            
            
        case Sections.InTheaters.rawValue:
            
            APICaller.shared.getInTheaters { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    // MARK: height sections
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // MARK: height between sections (между секциями)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //MARK: добавляется шрифт, размер и цвет надписям к заголовкам
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + 20,
            y: header.bounds.origin.y,
            width: 100,
            height: header.bounds.height)
        header.textLabel?.textColor = .white
        
        header.textLabel?.text = header.textLabel?.text?.localizedCapitalized
    }
    
    //MARK: добавили секции с массива к каждому заголовку
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    //MARK: Скрытие верхней панели
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultoffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultoffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

// MARK: transition to view movie characteristics
extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
