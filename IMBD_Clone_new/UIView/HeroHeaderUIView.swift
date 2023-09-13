//
//  HeroHeaderUIView.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 26.08.2023.
//


import UIKit

class HeroHeaderUIView: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
   
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            //MARK: сменить black and systemBackground
            UIColor.black.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()

    }
    
    //https://imdb-api.com/en/API/Images/k_ecmrr273/tt1375666/Full
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://imdb-api.com/API/Images/k_ecmrr273/tt1375666/\(model.posterURL)") else {
            
            return
        }
        
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
