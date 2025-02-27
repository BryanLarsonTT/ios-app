import Foundation

struct MetarFetcher {
    let baseURL = "https://aviationweather.gov/api/data/metar"
    
    func fetchMETAR(for airportICAO: String, completion: @escaping (String?) -> Void) {
        let urlString = "\(baseURL)?ids=\(airportICAO)&format=raw"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching METAR: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let metarString = String(data: data, encoding: .utf8) {
                completion(metarString)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}

// Example usage
let fetcher = MetarFetcher()
fetcher.fetchMETAR(for: "KLAX") { metar in
    if let metar = metar {
        print("METAR Data: \(metar)")
    } else {
        print("Failed to fetch METAR data.")
    }
}

// Keep the script running to receive the response
RunLoop.main.run()
