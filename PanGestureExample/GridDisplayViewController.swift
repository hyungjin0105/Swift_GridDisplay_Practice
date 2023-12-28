import UIKit

class GridDisplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var rows: Int
    var columns: Int
    
    private var collectionView: UICollectionView!
    private var boxes: [Bool]
    let rectangleBox = UIView()

    private let cellSize: CGSize = CGSize(width: 40, height: 40)
    
    private var layout: UICollectionViewFlowLayout!

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
        setupCollectionView()
        setupRectangleBox()
        setupButtons()
        setupConstraints()
    }

    private func setupCollectionView() {
        layout = UICollectionViewFlowLayout()
        
        if columns % 2 == 0 {
            // Even number of columns - pair columns with minimal space between them
            layout.minimumInteritemSpacing = 1 // Minimal spacing for paired columns
            layout.minimumLineSpacing = 10 // Larger spacing between pairs
        } else {
            // Odd number of columns - use standard spacing logic
            let baseSpacing = 5 // Base spacing for 8 columns
            let spacingIncrement = 10 // Increment spacing by 10 for each column less than 8
            let columnDifference = max(0, 8 - columns)
            layout.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
            layout.minimumLineSpacing = 2
        }
        
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
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: rectangleBox.topAnchor, constant: -20),// Positioned below the rectangle box
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: (CGFloat(columns) * cellSize.width) + CGFloat(columns - 1) * layout.minimumInteritemSpacing),
           collectionView.heightAnchor.constraint(equalToConstant: (CGFloat(rows) * cellSize.height) + CGFloat(rows - 1) * layout.minimumLineSpacing),

            
            rectangleBox.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * (4.0 / 7.0)),
            rectangleBox.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rectangleBox.widthAnchor.constraint(equalToConstant: 100),
            rectangleBox.heightAnchor.constraint(equalToConstant: 30),
            
            twoColumn.topAnchor.constraint(equalTo: rectangleBox.bottomAnchor, constant: 20),
            twoColumn.leadingAnchor.constraint(equalTo: rectangleBox.leadingAnchor),

            // Button 2 Constraints
            oneColumn.topAnchor.constraint(equalTo: twoColumn.topAnchor),
            oneColumn.leadingAnchor.constraint(equalTo: twoColumn.trailingAnchor, constant: 10),
            oneColumn.widthAnchor.constraint(equalTo: twoColumn.widthAnchor),
        ])
    }
    
    func updateCollectionViewLayout(forColumns newColumns: Int) {
        self.columns = newColumns
        setupCollectionView() // Recalculate the layout
        collectionView.reloadData() // Reload the collection view to apply new layout
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
