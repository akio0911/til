import UIKit



//protocol SideMenuTableViewControllerDelegate: AnyObject {
//    func sendMail()
//    func presentInfoModalView()
//}
//
//class SideMenuTableViewController: UITableViewController {
//    weak var delegate: SideMenuTableViewControllerDelegate?
//
//    private let cellContents:[(identifier:String, iconName:String, text:String, behaviour:((SideMenuTableViewControllerDelegate) -> Void)?)] = [
//        ("oneIconCell", "mail", "ご意見・ご要望", { $0.presentInfoModalView() }),
//        ("oneIconCell", "plusalpha", "有料版のご購入", { $0.sendMail() }),
//        ("oneIconCell", "autosave", "自動保存", { $0.sendMail() }),
//        ("oneIconCell", "info", "クレジット", { $0.sendMail() })
//    ]
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // 行数に該当するcellContentsのidentifierのセルを取得
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellContents[indexPath.row].identifier, for: indexPath) as! CustomCell
//        // 行数に該当するcellContentsのimageNameを設定
//        cell.cellIcon?.image = UIImage(named: cellContents[indexPath.row].iconName)
//        // 行数に該当するcellContentsのtextを設定
//        cell.cellTextLabel?.text = cellContents[indexPath.row].text
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 行数に該当するcellContentsの関数を実行
//        cellContents[indexPath.row].behaviour?(delegate)
//    }
//    //後略
//}



struct SideMenuItem {
    let iconName: String
    let title: String
    let execute: () -> Void
}

class CustomCell: UITableViewCell {
    /// 外からは操作できないようにprivate
    private let cellIconImageView: UIImageView!
    private let cellTextLabel: UILabel!

    /// MenuItemをセルでどう表示するかの知識はここに閉じ込める
    func configure(menuItem: SideMenuItem) {
        cellIconImageView?.image = UIImage(named: menuItem.iconName)
        cellTextLabel?.text = menuItem.title
    }
}

protocol SideMenuTableViewControllerDelegate: AnyObject {
    func sendMail()
    func presentInfoModalView()
}

final class SideMenuTableViewController: UITableViewController {

    private weak var delegate: SideMenuTableViewControllerDelegate?

    /// メニューの並び順はここで定義
    private var menuItems: [SideMenuItem] {
        [
            SideMenuItem(
                iconName: "mail",
                title: "ご意見・ご要望",
                execute: { [weak self] in
                    self?.delegate?.presentInfoModalView()
                }
            ),
            SideMenuItem(
                iconName: "plusalpha",
                title: "有料版のご購入",
                execute: { [weak self] in
                    self?.delegate?.sendMail()
                }
            ),
            SideMenuItem(
                iconName: "autosave",
                title: "自動保存",
                execute: { [weak self] in
                    self?.delegate?.sendMail()
                }
            ),
            SideMenuItem(
                iconName: "info",
                title: "クレジット",
                execute: { [weak self] in
                    self?.delegate?.sendMail()
                }
            )
        ]
    }

    /// IndexPathに対応するMenuItemの求め方はここに集約
    private func menuItem(indexPath: IndexPath) -> SideMenuItem {
        menuItems[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneIconCell", for: indexPath) as! CustomCell
        cell.configure(menuItem: menuItem(indexPath: indexPath))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuItem(indexPath: indexPath).execute()
    }
}



///// 部分適用
//func partial<A, B, R>(_ function: @escaping (A, B) -> R, _ a: A) -> (B) -> R {
//    { function(a, $0) }
//}
//
//func add(_ a: Int, _ b: Int) -> Int {
//    a + b
//}
//
//let add1 = partial(add, 1)
//add1(2) // 3


//protocol TableViewControllerDelegate: AnyObject {
//    func hoge()
//}
//
//class TableViewController: UITableViewController {
//    weak var tableViewControllerDelegate: TableViewControllerDelegate?
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableViewControllerDelegate?.hoge()
//    }
//}
//
//class ViewController: UIViewController {
//}
//
//extension ViewController: TableViewControllerDelegate {
//    func hoge() {
//        // これが呼ばれない
//    }
//}



//protocol SendMailDelegate: AnyObject {
//    func sendMail()
//}
//class SideMenuTableViewController: UITableViewController {
//    var sendMailDelegate: SendMailDelegate?
//    let cellContents:[(identifier:String, iconName:String, text:String)] = [
//        ("oneIconCell", "mail", "ご意見・ご要望"),
//        ("oneIconCell", "plusalpha", "有料版の購入"),
//        ("oneIconCell", "autosave", "自動保存")
//    ]
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellContents[indexPath.row].identifier, for: indexPath) as! CustomCell
//        cell.cellIcon?.image = UIImage(named: cellContents[indexPath.row].iconName)
//        cell.cellTextLabel?.text = cellContents[indexPath.row].text
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (indexPath.row == 0) {
//            sendMailDelegate?.sendMail()
//        }
//    }
//}




//class TopViewController: UIViewController {
//    private let menuViewController = MenuViewController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        menuViewController.delegate = self
//    }
//}
//
//extension TopViewController: MenuViewControllerDelegate {
//    func didSelect(item: MenuItem) {
//        switch item {
//        case .contactUs:
//            presentMailComposer()
//        }
//    }
//
//    private func presentMailComposer() {}
//}
//
//enum MenuItem {
//    case contactUs
//}
//
//protocol MenuViewControllerDelegate: AnyObject {
//    func didSelect(item: MenuItem)
//}
//
//class MenuViewController: UITableViewController {
//    weak var delegate: MenuViewControllerDelegate?
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            delegate?.didSelect(item: .contactUs)
//        default:
//            break
//        }
//    }
//}





//class TableViewController: UITableViewController {
//    weak var viewControllerDelegate: ViewControllerDelegate?
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewControllerDelegate?.hoge()
//    }
//}
//
//protocol ViewControllerDelegate: AnyObject {
//    func hoge()
//}
//
//class ViewController: UIViewController {
//    func hoge() {
//        // これが呼ばれない
//    }
//}


//let plus: (Int) -> ((Int) -> Int) = { a in
//    { b in
//        a + b
//    }
//}
//let plus5 = plus(5)
//plus5(10)


//func plus(_ a: Int) -> ((Int) -> Int) {
//    { a + $0 }
//}
//
//let plus5 = plus(5)
//plus5(10)
//
//let minus10 = plus(-10)
//minus10(7)


//let textField1 = UITextField()
//let textField2 = UITextField()
//textField1.text = "10"
//textField2.text = "20"
//
//let result = [textField1, textField2]
//    .map { Int($0.text ?? "") ?? 0 }
//    .reduce(0, +)
//result

//let a = 1
//let a = 2



//class GetNumber{
//    func getNumberFromTextField(textField: UITextField) -> Int{
//        var number = 0
//        if Int(textField.text ?? "") != nil{//空でないかつ数字として取り出せるなら
//            number = Int(textField.text ?? "") ?? 0
//            textField.text = String(number)//数字の前に0があるなら除去
//        }else{//空でないかつ数字として取り出せるないなら一瞬赤くする
//            textField.backgroundColor = .red
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                textField.backgroundColor = .white
//            }
//        }
//        return number
//    }
//}
//
//class ViewController {
//    private let textField1 = UITextField()
//    private let textField2 = UITextField()
//    private let textField3 = UITextField()
//
//    private let calculator = ScoreCalculator()
//
//    func 計算ボタンが押された() {
//        switch calculator.calculate(input: 入力値(画面での入力値1: textField1.text, 画面での入力値2: textField2.text, 画面での入力値3: textField3.text)) {
//        case .数字として取り出せる(let value):
//            textField1.text = String(value)
//        case .数字として取り出せない:
//            textField1.backgroundColor = .red
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//                self?.textField1.backgroundColor = .white
//            }
//        }
//    }
//}
//
//struct 入力値 {
//    let 画面での入力値1: String?
//    let 画面での入力値2: String?
//    let 画面での入力値3: String?
//}
//
//class ScoreCalculator {
//    enum Result {
//        case 数字として取り出せる(Int)
//        case 数字として取り出せない
//    }
//
//    func calculate(input: 入力値) -> Result {
//        // いろいろ計算する
//
//        return .数字として取り出せる(123)
//    }
//}
