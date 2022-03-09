# ToyBrickTableView-Swift
ToyBrickTableView的Swift版本

已集成
- [ ] 上下拉刷新
- [ ] 空白数据集显示
- [ ] Cell侧滑
## 如何安装
```ruby
pod 'ToyBrickTableView-Swift'
```
## 如何使用
* 自定义TableViewCell
```swift
override class func reuseIdentifier() -> String {
    return "tableViewCell复用标志符"
}
```
```swift
override class func cellRowHeightForDict(dict: NSMutableDictionary) -> Float {
    //设置Cell高度
    return Float(44)
}
```
```swift
static func buildCellDict(model: CustomerModel) -> NSMutableDictionary {
    /**
     构建Cell字典
     每次build都会将dict清空
     */
    let dict = super.buildCellDict(cls: TBSplitLineTableViewCell.self)
    dict["model"] = model
    return dict
}
```
```swift
required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //初始化Cell, 添加自定义子视图
    super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor = UIColor.white
    self.contentView.addSubview(self.customerView)
}
```
```swift
override func updateCellWithDict(dict: NSMutableDictionary) {
    /**
     取字典中的数据用来渲染Cell
     如果需要上一次dict中的数据，可以将数据先保存在类中，再在这里重新将数据写入dict中
     */
    let model: CustomerModel = dict["model"] as! CustomerModel
    //doSomething
}
```
* 构建TableView
```swift
private lazy var tableView: TBTableView = {
    var tableView = TBTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableView.Style.plain)
    tableView.backgroundColor = UIColor.white
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.estimatedSectionFooterHeight = 0
    tableView.estimatedSectionHeaderHeight = 0
    return tableView
}()
```
>⚠️ 以下```UITableViewDataSource```、```UITableViewDelegate```两个代理的实现照抄就行🥳
```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dict: NSMutableDictionary = self.dataSource[indexPath.row]
    let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
    let reuseIdentifier: String = (tableViewCellClass as! TBTableViewCell.Type).reuseIdentifier()
        
    var tableViewCell: TBTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TBTableViewCell)
    if tableViewCell == nil {
        tableViewCell = (tableViewCellClass as! TBTableViewCell.Type).init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        tableViewCell?.backgroundColor = UIColor.clear
        tableViewCell?.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    tableViewCell?.updateCellWithDict(dict: dict)
    return tableViewCell!
}
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let dict: NSMutableDictionary = self.dataSource[indexPath.row]
    let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
    let height: Float = (tableViewCellClass as! TBTableViewCell.Type).cellRowHeightForDict(dict: dict)
    return (height == Float(UITableView.automaticDimension) || height >= 0) ? CGFloat(height) : 0
}
    
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let dict: NSMutableDictionary = self.dataSource[indexPath.row]
    let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
    let height: Float = (tableViewCellClass as! TBTableViewCell.Type).cellRowHeightForDict(dict: dict)
    if #available(iOS 11.0, *) {
        return (height == Float(UITableView.automaticDimension) || height >= 0) ? CGFloat(height) : 0
    }else {
        return height <= 1 ? 0 : CGFloat(height)
    }
}
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dict: NSMutableDictionary = self.dataSource[indexPath.row]
    dict.executeAction()
}
```
* TableView数据源构建
```swift
private func buildCellDataSource() {
    self.dataSource.removeAll()
    
    self.dataSource.append(CustomerTableViewCell.buildCellDict(model: model).addAction(actionBlock: {
        print("点击")
        //doSomething
    }))
}
```
## END
我是佛系程序员👨‍💻‍
