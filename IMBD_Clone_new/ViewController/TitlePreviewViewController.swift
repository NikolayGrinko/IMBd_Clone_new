//
//  TitlePreviewViewController.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 26.08.2023.
//

/*
releaseDate

 */

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = " "
        return label
    }()
    
    private let overviewLabel: UILabel = {
    
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the description of the movie"
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = " "
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = " "
        return label
    }()
    
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    private let webView: WKWebView = {
    let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(yearLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(downloadButton)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
        
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ]
        
        let overviewLabelConstraints = [
        
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        
        let yearLabelConstraints = [
        
            yearLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ]
        
        let releaseDateLabelConstraints = [
        
            releaseDateLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 20),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ]
        
        let downloadbuttonconstraints = [
        
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(yearLabelConstraints)
        NSLayoutConstraint.activate(releaseDateLabelConstraints)
        NSLayoutConstraint.activate(downloadbuttonconstraints)
    }
   
    func configure(with model: TitlePreviewViewModel) {
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        yearLabel.text = model.titleYear
        releaseDateLabel.text = model.titleReleaseDate
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
        
    }
}
// https://imdb-api.com/API/YouTubeTrailer/k_ecmrr273/tt1375666
