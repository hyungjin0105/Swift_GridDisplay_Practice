import UIKit

class GridDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var rows: Int
    var columns: Int
    private var collectionView: UICollectionView!
    private var boxes: [Bool]
    let rectangleBox = UIView()

    private let cellSize: CGSize = CGSize(width: 40, height: 40) // Adjust the size as needed

    // Custom initializer
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.boxes = Array(repeating: true, count: rows * columns)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupCollectionView()
        setupRectangleBox()
        setupConstraints()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(collectionView)
    }

    private func setupRectangleBox() {
        rectangleBox.backgroundColor = .red
        rectangleBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangleBox)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: rectangleBox.topAnchor, constant: -20),// Positioned below the rectangle box
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: (CGFloat(columns) * cellSize.height)+CGFloat(columns-1)*2), // Width based on the number of columns
            collectionView.heightAnchor.constraint(equalToConstant: (CGFloat(rows) * cellSize.height)+CGFloat(rows-1)*2), // Height based on the number of rows
            
            //선생님 박스. 위치가 화면에 고정되어 있어 디바이스마다 다를수도..
            rectangleBox.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * (4.0 / 7.0)),
            rectangleBox.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rectangleBox.widthAnchor.constraint(equalToConstant: 100), // Set the width as needed
            rectangleBox.heightAnchor.constraint(equalToConstant: 30)  // Set the height as needed
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxes.count // Adjusted to new grid size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.blue // All cells are highlighted
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

}
