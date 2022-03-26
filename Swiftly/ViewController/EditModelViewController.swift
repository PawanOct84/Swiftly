//
//  EditModelViewController.swift
//  ModelGenerator
//
//  Created by pawan kumar on 19/03/22.
//

import UIKit
import SwiftyJSON

class EditModelViewController: UIViewController {

    public var jsonData:JSON!
    public var isRequestModel:Bool = false
    public var isUIModel:Bool = false
    public var baseClassName:String = "BaseClass"

    
    @IBOutlet weak var tableView: UITableView!
    var models = [ModelFile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        generatePropertyComponents()
    }
    
    func defaultConfiguration(library: JSONMappingMethod, optional: Bool) -> ModelGenerationConfiguration {
        return ModelGenerationConfiguration(
            filePath: "/tmp/",
            baseClassName: "BaseClass",
            authorName: "Pawan Kumar",
            companyName: "Comviva",
            prefix: "",
            constructType: .structType,
            modelMappingLibrary: library,
            separateCodingKeys: true,
            variablesOptional: optional,
            shouldGenerateInitMethod: true
        )
    }

    func generatePropertyComponents() {
        var config = defaultConfiguration(library: .swiftNormal, optional: false)
        config.constructType = .classType
        var models = ModelGenerator(jsonData, config)
        var files = models.generate()
        print("Section count",files.count)
        print("*************************")
        for i in 0...(files.count - 1) {
            var file = files[i]
            print("Section:",file.fileName)
            print("*************************")
            var propertyComponents = file.propertyComponents ?? []
            for j in 0...(propertyComponents.count - 1) {
                var data = propertyComponents[j]
                if j % 2 == 0 {
                    data.variablesOptional = false
                }
                else {
                    data.variablesOptional = true
                }
                print("name:",data.name)
                print("type:",data.type)
                print("VariablesOptional:",data.variablesOptional)
            }
            print("*************************")
        }
        print("***********                        **************")
        self.models = files
        self.tableView.reloadData()
    }
     
    
    func generateUIModels()-> String {
        var result = "\n"
        var config = defaultConfiguration(library: .swiftNormal, optional: false)
        config.constructType = .structType
        for i in 0...(self.models.count - 1) {
            var file = self.models[i]
            file.generateAllComponents()
            let content = FileGenerator.generateStructFileContentWith(file, configuration: config)
            result += content
//            print("content",content)
        }
        return result
    }
    
    func generateCodableModels()->String {
        var result = "\n"
        var config = defaultConfiguration(library: .swiftNormal, optional: false)
        config.constructType = .classType
        for i in 0...(self.models.count - 1) {
            var file = self.models[i]
            file.generateAllComponents()
            let content = FileGenerator.generateClassFileContentWith(file, configuration: config)
            result += content
//            print("content",content)
        }
        return result
    }
     
    
    func generateUIViewModels()->String {
        var config = defaultConfiguration(library: .swiftNormal, optional: false)
        config.constructType = .classType
        var result = "\n"
        for i in 0...(self.models.count - 1) {
            var file = self.models[i]
            file.generateAllComponents()
            let content = FileGenerator.generateViewModelFileContentWith(file, configuration: config)
            result += content
//            print("content",content)
        }
        return result
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        var result = "\n"
        result += generateCodableModels()
        result += generateUIModels()
        result += generateUIViewModels()
        print("result",result)

        
      if segue.identifier == "showReportView",
         let viewController = segue.destination as? ReportsViewController {
          viewController.reports = result
      }
    }
}

extension EditModelViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = UIColor(displayP3Red: 28.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        let headerImageView = UIImageView(frame: view.bounds)
        headerImageView.image = UIImage(named: "bg_cell") //bg_cell //headerBG
        view.addSubview(headerImageView)
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = models[section].fileName
        lbl.textColor = UIColor.white
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].propertyComponents?.count ?? 0
    }
         
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AttributeCell = self.tableView.dequeueReusableCell(withIdentifier: "AttributeCell") as! AttributeCell
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var propertyComponents = models[indexPath.section].propertyComponents ?? []
        var data = propertyComponents[indexPath.row]
        //cell.textLabel?.text = data.name
        ///TO DOO needs to show more property like data.name,data.type,data.variablesOptional
        cell.setData(data)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
    }
         
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//           return 40
//    }
}



extension EditModelViewController: AttributeCellDelegate {
    
    func didTappedAt(cell: AttributeCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            var propertyComponents = models[indexPath.section].propertyComponents ?? []
            var data = propertyComponents[indexPath.row]
            data.variablesOptional = data.variablesOptional ? false : true
            propertyComponents[indexPath.row] = data
            
            self.tableView.reloadData()
        }
    }
    
}




//
//
//
//func generateCodableModels()->String {
//    var result = "\n"
//    var config = defaultConfiguration(library: .swiftNormal, optional: false)
//    config.constructType = .classType
//    for i in 0...(self.models.count - 1) {
//        var file = self.models[i]
//        file.generateAllComponents()
////            print("fileName",file.fileName)
////            print("*************************")
////
////            print("component",file.component.initialiserFunctionComponent)
////            print("*************************")
////
////            print("initialisers",file.component.initialisers)
////            print("*************************")
////
////
////            print("stringConstants",file.component.stringConstants)
////            print("*************************")
//
//        let content = FileGenerator.generateClassFileContentWith(file, configuration: config)
//        result += result
//        print("content",content)
//    }
//}
//
