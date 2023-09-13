//
//  APICaller.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 01.09.2023.
//

import Foundation

struct Constants {
    
    static let identifier = "tt1375666"
    static let API_KEY = "k_h4fp8i39"
    static let  baseURL = "https://imdb-api.com/API"
    
    static let YoutubeAPI_KEY = "AIzaSyAXZu1vmZ2RNi3ANs0OkiFtDi4W97QTNgs"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    //https://imdb-api.com/en/API/Title/k_ecmrr273/cell
    // https://imdb-api.com/en/API/ Top250Movies/k_ecmrr273
    
    
    //https://imdb-api.com/API/Top250Movies/k_ecmrr273
    
    func getTop250Movies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/Top250Movies/\(Constants.API_KEY)") else {return}
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
               print(results)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        print(task)
    }
    
    // https://imdb-api.com/API/MostPopularMovies/k_ecmrr273
    
    func getMostPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/MostPopularMovies/\(Constants.API_KEY)") else {return}
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
               print(results)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        print(task)
    }
    
// https://imdb-api.com/API/ComingSoon/k_ecmrr273
    
    func getComingSoom(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/ComingSoon/\(Constants.API_KEY)") else {return}
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
               print(results)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        print(task)
    }

//https://imdb-api.com/API/InTheaters/k_ecmrr273
    
    func getInTheaters(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/InTheaters/\(Constants.API_KEY)") else {return}
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
               print(results)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        print(task)
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
       guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                print(results)
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
        print(task)
    }
    
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
       
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        print(task)
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en=US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        print(task)
    }
    
}




