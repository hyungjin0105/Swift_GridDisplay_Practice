import UIKit

class GridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    let rectangleBox = UIView()
    var gridColumns: Int
    var gridRows: Int
    var boxes: [Bool]
    let buttonOne = UIButton(type: .system)
    let buttonTwo = UIButton(type: .system)
    var collectionView: UICollectionView!
    
    // MARK: - Initializer
    init(rows: Int, columns: Int) {
        self.gridRows = rows
        self.gridColumns = columns
        self.boxes = Array(repeating: false, count: rows * columns)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .systemBackground
        setupRectangleBox()
        setupCollectionView()
        
        if gridColumns % 2 == 0 {
            setupButtons()
        }
        setupConstraints()
        
    }
    
    private func setupRectangleBox() {
        rectangleBox.backgroundColor = .red
        rectangleBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangleBox)
    }
    
    
    private func setupButtons() {
        configureButton(buttonOne, title: "One")
        buttonOne.addTarget(self, action: #selector(adjustSpacingForOneButton), for: .touchUpInside)
        
        configureButton(buttonTwo, title: "Two")
        buttonTwo.addTarget(self, action: #selector(adjustSpacingForTwoButton), for: .touchUpInside)
    }
    
    
    @objc private func adjustSpacingForOneButton() {
        if let layout = collectionView.collectionViewLayout as? CustomGridLayout {
            layout.useAlternatingSpacing = false
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    @objc private func adjustSpacingForTwoButton() {
        if let layout = collectionView.collectionViewLayout as? CustomGridLayout {
            // Toggle alternating spacing
            layout.useAlternatingSpacing = true
            // Invalidate the layout to apply changes
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func configureButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }
    
    private func setupCollectionView() {
        let layout = CustomGridLayout(columns: gridColumns)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
    
    }
    
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let cellSize: CGFloat = 30
        let basespacing: CGFloat = 15 + ((8 - CGFloat(gridColumns)) * 10)
        let baseheight: CGFloat = 2
        let spacenum = CGFloat(gridColumns) - 1
        //        let totalCellWidth = (cellSize * 8) + ((cellSize/2) * 7)
        let totalCellWidth = (cellSize * CGFloat(gridColumns) + (basespacing * spacenum))
        let totalCellHeight = (cellSize * CGFloat(gridRows)) + (baseheight * CGFloat(gridRows - 1))
        
        
        NSLayoutConstraint.activate([
            rectangleBox.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * (3.5 / 7.0)),
            rectangleBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleBox.widthAnchor.constraint(equalToConstant: 100),
            rectangleBox.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.widthAnchor.constraint(equalToConstant: totalCellWidth),
            collectionView.heightAnchor.constraint(equalToConstant: totalCellHeight),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: rectangleBox.topAnchor, constant: -20)
        ])
        
        if gridColumns % 2 == 0 {
            // Set up constraints for the buttons only if they are added to the view
            NSLayoutConstraint.activate([
                buttonOne.topAnchor.constraint(equalTo: rectangleBox.bottomAnchor, constant: 20),
                buttonOne.leadingAnchor.constraint(equalTo: rectangleBox.leadingAnchor),
                
                buttonTwo.topAnchor.constraint(equalTo: rectangleBox.bottomAnchor, constant: 20),
                buttonTwo.trailingAnchor.constraint(equalTo: rectangleBox.trailingAnchor)
            ])
        }
    }
    
    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridRows * gridColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.systemYellow // All cells are highlighted
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
}
