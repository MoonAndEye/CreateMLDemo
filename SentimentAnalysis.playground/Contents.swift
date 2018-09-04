import CreateML
import Foundation

//1
//
//let url = URL(fileURLWithPath: "/Users/Moon/2swift/self/CreateMLDemo/SentimentDataset")
//
//print("Start loading data")
//let sentimentClassifier = try MLTextClassifier(trainingData: .labeledDirectories(at: url))
//
////4
//let metadata = MLModelMetadata(author: "Marvin Lin", shortDescription: "Using mazon's cell data to make sentiment classifer", version: "1.0")
//try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/Moon/2swift/self/CreateMLDemo/SentimentClassifer.mlmodel"), metadata: metadata)



//1

let url = URL(fileURLWithPath: "/Users/Moon/2swift/self/CreateMLDemo/SentimentJSONData/sentiment.json")

print("Start loading data")
let data = try MLDataTable(contentsOf: url)

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

print("Classifier is training")
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")

//2
let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100

//3
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

//4
let metadata = MLModelMetadata(author: "Marvin Lin", shortDescription: "Using Appcoda's spam json file to train ML model", version: "1.0")
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/Moon/2swift/self/CreateMLDemo/SentimentClassifer.mlmodel"), metadata: metadata)

