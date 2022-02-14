//
//  ViewController.swift
//  WeatherApp
//
//  Created by Fedor Sychev on 27.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    var locationLabel: UILabel?
    var dateLabel: UILabel?
    var summaryLabel: UILabel?
    var forecastLabel: UILabel?
    var searchTextField: UITextField?
    var cityTable: UITableView?
    var searchButton: UIButton?
    
    private let viewModel = WeatherViewModel()

    var testData: [String] = ["Augsburg", "Odessa", "Munchen", "Frankfurt", "Dusseldorf", "Kiev", "Hamburg", "Munster"]
    let standartData: [String] = ["Augsburg", "Odessa", "Munchen", "Frankfurt", "Dusseldorf", "Kiev", "Hamburg", "Munster"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testData.sort()
        
        createTextField()
        createTableView()
        createLocationLabel()
        createDateLabel()
        createSummaryLabel()
        createForecastLabel()
        createLocationIcon()
        createSearchButton()
        
        self.view.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 1, alpha: 1)
        self.cityTable!.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 1, alpha: 1)
        
        viewModel.locationName.bind { [weak self] locationName in
          self?.locationLabel!.text = locationName
        }
        
        viewModel.date.bind { [weak self] date in
          self?.dateLabel!.text = date
        }
        
        viewModel.summary.bind { [weak self] summary in
          self?.summaryLabel!.text = summary
        }
        
        viewModel.forecastSummary.bind { [weak self] forecast in
          self?.forecastLabel!.text = forecast
        }
        
        // Do any additional setup after loading the view.
    }
    
    func createLocationLabel() {
        self.locationLabel = UILabel(frame: CGRect(x: 100, y: 20, width: 100, height: 60))
        
        locationLabel!.text = "Searching location..."
        locationLabel!.center = CGPoint(x: 100, y: 20)
        
        self.view.addSubview(locationLabel!)
        
        locationLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            locationLabel!.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            locationLabel!.heightAnchor.constraint(equalToConstant: 60),
            locationLabel!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            locationLabel!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ]
        view.addConstraints(constraints)
    }
    
    func createLocationIcon() {
        let icon = UIImage(systemName: "location")!.withTintColor(UIColor.blue)
        let imageView = UIImageView(image: icon)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.rightAnchor.constraint(equalTo: self.locationLabel!.leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.centerYAnchor.constraint(equalTo: self.locationLabel!.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        self.view.addConstraints(constraints)
    }
    
    func createDateLabel() {
        self.dateLabel = UILabel(frame: CGRect(x: 100, y: 20, width: 100, height: 60))
        
        dateLabel!.text = "Sample Date"
        dateLabel!.center = CGPoint(x: 100, y: 20)
        
        self.view.addSubview(dateLabel!)
        
        dateLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            dateLabel!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
            dateLabel!.heightAnchor.constraint(equalToConstant: 60),
            dateLabel!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40),
            dateLabel!.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ]
        
        self.view.addConstraints(constraints)
    }
    
    func createSummaryLabel() {
        self.summaryLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
        
        summaryLabel!.text = "Sample Summary"
        summaryLabel!.center = CGPoint(x: 100, y: 20)
        
        self.view.addSubview(summaryLabel!)
        
        summaryLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            summaryLabel!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            summaryLabel!.heightAnchor.constraint(equalToConstant: 100),
            summaryLabel!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40),
            summaryLabel!.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ]
        
        self.view.addConstraints(constraints)
        
    }
    
    func createForecastLabel() {
        self.forecastLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
        
        forecastLabel!.text = "Sample Forecast"
        forecastLabel!.center = CGPoint(x: 100, y: 20)
        
        self.view.addSubview(forecastLabel!)
        
        forecastLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            forecastLabel!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160),
            forecastLabel!.heightAnchor.constraint(equalToConstant: 100),
            forecastLabel!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40),
            forecastLabel!.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ]
        
        self.view.addConstraints(constraints)
    }
    
    func createTextField() {
        self.searchTextField = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        searchTextField!.placeholder = "Search city"
        searchTextField!.center = CGPoint(x: 100, y: 100)
        searchTextField!.borderStyle = UITextField.BorderStyle.line
        searchTextField!.textColor = .black
        searchTextField!.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        
        self.view.addSubview(searchTextField!)
        
        searchTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            searchTextField!.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            searchTextField!.heightAnchor.constraint(equalToConstant: 50),
            searchTextField!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            searchTextField!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80)
        ]
        view.addConstraints(constraints)
        self.searchTextField!.isHidden = true
    }
    
    func createSearchButton() {
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: UIControl.Event.touchUpInside)
        //searchButton.backgroundColor = .black
        searchButton.layer.borderWidth = 4
        searchButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor.blue), for: UIControl.State.normal)
        
        self.view.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            searchButton.centerYAnchor.constraint(equalTo: self.searchTextField!.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 55),
            searchButton.rightAnchor.constraint(equalTo: self.searchTextField!.leftAnchor, constant: -5),
            searchButton.widthAnchor.constraint(equalToConstant: 55)
        ]
        
        self.view.addConstraints(constraints)
    }
    
    @objc func searchButtonPressed(sender: UIButton) {
        print("SOMETHINS")
        if self.searchTextField!.isHidden == false {
            self.searchTextField!.isHidden = true
            self.testData = self.standartData
            self.testData.sort()
            self.cityTable!.reloadData()
        } else {
            if self.searchTextField!.isHidden == true {
                self.searchTextField!.isHidden = false
                self.searchTextField!.text = ""
                self.searchTextField!.placeholder = "Search city"
            }
        }
    }
    
    //MARK: - textField Function
    @objc func textFieldDidChanged(sender: UITextField) {
        if sender.text?.isEmpty == false {
            print("CHANGED")
            print(sender.text!)
            var newArray: [String] = []
            
            for i in self.standartData {
                var newSearchString = ""
                for j in 0...sender.text!.count - 1 {
                    newSearchString += i[j]
                }
                if newSearchString == sender.text! {
                    newArray.append(i)
                }
            }
            self.testData = newArray
            self.cityTable!.reloadData()
        } else {
            self.testData = standartData
            self.testData.sort()
            self.cityTable!.reloadData()
        }
    }
    
    func createTableView() {
        self.cityTable = UITableView(frame: CGRect(x: 100, y: 200, width: 300, height: 300))
        
        cityTable!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(cityTable!)
        
        cityTable!.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            cityTable!.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            cityTable!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cityTable!.leftAnchor.constraint(equalTo: view.leftAnchor),
            cityTable!.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        
        view.addConstraints(constraints)
        
        cityTable!.delegate = self
        cityTable!.dataSource = self
        
    }
}

//MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = testData[indexPath.row]
        cell.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 1, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        
        viewModel.changeLocation(to: cell!.textLabel!.text!)
        
    }
    
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
