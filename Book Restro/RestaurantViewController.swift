import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tblView: UITableView!
    var data = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        let dml = DMLOperation()
        data = dml.restauranList(quey: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tblView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var mycell=RestroListTableViewCell()
        mycell=tableView.dequeueReusableCell(withIdentifier: "cell1") as! RestroListTableViewCell
        
        let d = data.object(at: indexPath.row) as! NSDictionary
        
        mycell.name.text=d.value(forKey: "name") as! String?
        var s = ""
        s = String(format: "%@.jpg", (d.value(forKey: "id") as! String?)!)
        mycell.img.image=UIImage(named: s)
        return mycell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let u = UserDefaults()
        let d = data.object(at: indexPath.row) as! NSDictionary
        u.set(d.value(forKey: "id") as! String?, forKey: "rId")
        u.set(d.value(forKey: "name") as! String?, forKey: "rName")
        u.set(d.value(forKey: "address") as! String?, forKey: "rAddress")
        u.set(d.value(forKey: "city") as! String?, forKey: "rCity")
        u.set(d.value(forKey: "hours") as! String?, forKey: "rHours")
        u.set(d.value(forKey: "logitude") as! String?, forKey: "rLogitude")
        u.set(d.value(forKey: "latitude") as! String?, forKey: "rLatitude")
        u.set(d.value(forKey: "detail") as! String?, forKey: "rDetail")
        u.set(d.value(forKey: "phone") as! String?, forKey: "rPhone")
        
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "detail") as! RestroDetailViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }

}
