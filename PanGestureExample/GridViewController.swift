import UIKit

class GridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let rectangleBox = UIView()

    var gridColumns: Int
    var gridRows: Int
    var boxes: [Bool]

    var collectionView: UICollectionView!

    // Custom initializer
    init(rows: Int, columns: Int) {
        self.gridRows = rows
        self.gridColumns = columns
        self.boxes = Array(repeating: false, count: rows * columns)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupRectangleBox()
        setupConstraints()
    }
    
    private func setupRectangleBox() {
            rectangleBox.backgroundColor = .red
            rectangleBox.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(rectangleBox)
        }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let baseSpacing: CGFloat = 30
        let cellSize: CGFloat = 30
        let spacing: CGFloat = 2 // Assuming a spacing of 2 points between cells
        let totalCellWidth = (cellSize * CGFloat(gridColumns)) + (spacing * CGFloat(gridColumns - 1))

        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: rectangleBox.topAnchor, constant: baseSpacing),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: totalCellWidth),
            
            rectangleBox.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * (3.5 / 7.0)),
            rectangleBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleBox.widthAnchor.constraint(equalToConstant: 100),
            rectangleBox.heightAnchor.constraint(equalToConstant: 30)
        ])
    }




    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridRows * gridColumns
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.blue // All cells are highlighted
        return cell
    }

    // UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }



    // Additional methods if needed...
}
