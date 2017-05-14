

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        let dml = DMLOperation()
        let u = UserDefaults()
        let s = String(format:"SELECT * FROM restro_menu WHERE restro_id=%@",(u.value(forKey: "rId") as! String))
        data = dml.menuData(query: s)
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBook(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "book") as! BookViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var mycell=MenuTableViewCell()
        mycell=tableView.dequeueReusableCell(withIdentifier: "cell2") as! MenuTableViewCell
        
        let d = data.object(at: indexPath.row) as! NSDictionary
        
        mycell.lblName.text=d.value(forKey: "name") as! String?
        mycell.lblDetail.text=d.value(forKey: "detail") as! String?
        mycell.lblPrice.text=d.value(forKey: "price") as! String?
        //var s = ""
        //s = String(format: "%@.jpg", (d.value(forKey: "id") as! String?)!)
        //mycell.img.image=UIImage(named: s)
        return mycell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
