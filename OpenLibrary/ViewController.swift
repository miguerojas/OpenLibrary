//
//  ViewController.swift
//  OpenLibrary
//
//  Created by MIGUEL on 4/05/16.
//  Copyright © 2016 Miguel Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var Busqueda: UITextField!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var Autor: UILabel!
    @IBOutlet weak var Portada: UILabel!
    @IBAction func Buscar(sender: UIButton) {
    
        self.titulo.text = ""
        self.Autor.text = ""
        self.Portada.text = ""
        
        let url = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let urlComplete = "\(url)\(self.Busqueda.text!)"
        let urlFull = NSURL(string: urlComplete)
        if let datos = NSData(contentsOfURL: urlFull!){
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(datos, options: NSJSONReadingOptions.MutableLeaves)
                if json.count>0{
                    let response = json as! NSDictionary
                    let libro = response["ISBN:"+self.Busqueda.text!] as! NSDictionary
                    let nombre = libro["title"] as! NSString as String
                    self.titulo.text = nombre
                    
                    
                    let autores = libro["authors"] as! NSArray
                    for item in autores{
                       // print(item["name"] as! NSString as String)
                        
                        self.Autor.text = self.Autor.text! + (item["name"] as! NSString as String)
                        
                    }
                    self.Portada.text = "La portada no esta disponible"
                }else{
                    let alertController = UIAlertController(title: "OpenLibrary Request", message:
                        "Nn se han encontrado resultados", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                
                
                
                
            }catch _{
            }
        }else{
            let alertController = UIAlertController(title: "OpenLibrary Request", message:
                "Error verifica tu conexion de internet", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func ButtonClear(sender: UIButton) {
        self.Busqueda.text = ""
        self.titulo.text = ""
        self.Autor.text = ""
        self.Portada.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


    