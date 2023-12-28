import UIKit

class GridDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var rows: Int
    var columns: Int
    
    private var layout: CustomGridLayout!

    
    private var collectionView: UICollectionView!
    private var boxes: [Bool]
    let rectangleBox = UIView()

    private let cellSize: CGSize = CGSize(width: 40, height: 40)
    
    private let twoColumn = UIButton(type: .system)
    private let oneColumn = UIButton(type: .system)

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
        setupCollectionView() // Initialize layout here
        setupRectangleBox()
        setupButtons()
        setupConstraints() // Use the layout property here
    }


    private func setupCollectionView() {
        layout = CustomGridLayout(columns: columns) // Initialize as property

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(collectionView)
    }
    
    private func setupButtons() {
        // Configure Button 1
        twoColumn.setTitle("Two column", for: .normal)
        twoColumn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(twoColumn)

        // Configure Button 2
        oneColumn.setTitle("One Column", for: .normal)
        oneColumn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(oneColumn)

    }

    private func setupRectangleBox() {
        rectangleBox.backgroundColor = .red
        rectangleBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangleBox)
    }

    private func setupConstraints() {
        let averageSpacing: CGFloat
        if columns % 2 == 0 {
            // For even columns, average the spacing (1 and 10)
            averageSpacing = (1 + 10) / 2.0
        } else {
            // For odd columns, use the standard minimumInteritemSpacing
            averageSpacing = layout.minimumInteritemSpacing
        }

        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: rectangleBox.topAnchor, constant: -20),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: (CGFloat(columns) * cellSize.width) + CGFloat(columns - 1) * averageSpacing),

            collectionView.heightAnchor.constraint(equalToConstant: (CGFloat(rows) * cellSize.height) + CGFloat(rows - 1) * layout.minimumLineSpacing),

            rectangleBox.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * (4.0 / 7.0)),
            rectangleBox.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rectangleBox.widthAnchor.constraint(equalToConstant: 100),
            rectangleBox.heightAnchor.constraint(equalToConstant: 30),
            
            twoColumn.topAnchor.constraint(equalTo: rectangleBox.bottomAnchor, constant: 20),
            twoColumn.leadingAnchor.constraint(equalTo: rectangleBox.leadingAnchor),

            oneColumn.topAnchor.constraint(equalTo: twoColumn.topAnchor),
            oneColumn.leadingAnchor.constraint(equalTo: twoColumn.trailingAnchor, constant: 10),
            oneColumn.widthAnchor.constraint(equalTo: twoColumn.widthAnchor),
        ])
    }

    
    func updateCollectionViewLayout(forColumns newColumns: Int) {
        self.columns = newColumns
        layout.updateColumnCount(newColumnCount: newColumns) // Directly use the layout property
        collectionView.reloadData()
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
