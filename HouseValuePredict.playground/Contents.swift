import CreateML
import Foundation

let url = URL(fileURLWithPath: "/Users/Moon/2swift/self/CreateMLDemo/HouseValueDataset/HouseData.csv")

//1
let houseData = try MLDataTable(contentsOf: url)
let (trainingCSVData, testCSVData) = houseData.randomSplit(by: 0.8, seed: 0)
//2
let pricer = try MLRegressor(trainingData: houseData, targetColumn: "MEDV")
//3
let csvMetadata = MLModelMetadata(author: "Marvin Lin", shortDescription: "A model used to determine the price of a house based on some features. The dataset was from Appcoda", version: "1.0")
try pricer.write(to: URL(fileURLWithPath: "/Users/Moon/2swift/self/CreateMLDemo/HousePricer.mlmodel"), metadata: csvMetadata)


