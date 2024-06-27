//
//  HomeViewModel.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-08.
//

import Foundation
import Combine

class HomeViewAdapter: ObservableObject, CurrentIndex {
    
    @Published var viewModel: HomeView.ViewModel?
    @Published var usersText: UsersTexts
    @Published var gridItemState: GridItemState
    @Published var splitValues: SplitValues
    @Published var readerVelocity: ReaderVelocity
    @Published var currentWord: String
    @Published var words: [String] = []
    @Published var isPlaying: Bool
    @Published var wordsPerMinute: Double
    
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    var currentIndex: IndexType
    let systemIcons = SystemIcons()
    typealias IndexType = (Int, Int)
    
    lazy var textState: TextState = {
        return TextState(
            homeViewAdapter: self,
            index: 0,
            selectedText: "",
            totalTextLength: 0
        )
    }()
    
    init(viewModel: HomeView.ViewModel? = nil,
         sliderValue: Double = 1.0,
         timer: Timer? = nil,
         currentIndex: (Int, Int)? = nil) {
        
        self.viewModel = viewModel
        self.usersText = UsersTexts()
        self.gridItemState = GridItemState(
            index: 0,
            isSelected: false)
        self.splitValues = SplitValues(
            start: "",
            middle: "",
            end: "")
        self.wordsPerMinute = sliderValue
        readerVelocity = ReaderVelocity(sliderValue)
        
        
        self.currentWord = ""
        self.isPlaying = false
        self.timer = timer
        self.currentIndex = currentIndex ?? (0, 0)
        
        textState = TextState(
            homeViewAdapter: self,
            index: 0,
            selectedText: "",
            totalTextLength: Int(0.0))
        
        let splitValues = self.splitCurrentWord()
        
        $isPlaying
            .removeDuplicates()
            .sink { [weak self] isPlaying in
                guard let self = self else { return }
                
                if isPlaying {
                    self.startReading()
                    
                } else {
                    self.pauseReading()
                }
            }
            .store(in: &cancellables)
        
        self.splitValues = splitValues
    }
    
    func generateViewModel() {
        self.viewModel = .init(
            title: "Reader App",
            burgerIcon: systemIcons.burgerMenu,
            libraryIcon: systemIcons.library,
            xMarkIcon: systemIcons.xmark,
            flipIcon: systemIcons.flipIcon,
            dottedRectangle: systemIcons.dottedRectangle,
            indicator: systemIcons.indicator,
            showSelectedText: { selectedItem in
                self.showSelectedText(selectedIndex: selectedItem)
            }, closeSelectedText: { selectedItem in
                self.closeSelectedText(selectedItem: selectedItem)
            }, logoutAction: {
                self.viewModel?.logoutAction() /*authDbViewAdapter.logout()*/
            }
        )
    }
    
    func userSelectedText() {
        setupText(selectedText: textState.selectedText)
    }
    
    func heightInProcent(forItem item: Int, itemHeightInPercentage: [Int: Double]) -> CGFloat {
        CGFloat(itemHeightInPercentage[item] ?? 0.0) * 0.8
    }
    
    func showSelectedText(selectedIndex: Int) {
        guard let selectedText = usersText.texts[safe: selectedIndex - 1] else {
            return
        }
        textState.selectedText = selectedText
        gridItemState.index = selectedIndex
        gridItemState.isSelected = true
    }
    
    func closeSelectedText(selectedItem: Int) {
        gridItemState.isSelected = false
        textState.selectedText = ""
        
    }
    
    func resetReader() {
        timer?.invalidate()
        timer = nil
        currentIndex = (0, 0)
        currentWord = ""
    }
    
    func wpmValueConverter() -> String {
        String(format: "%.0f", 60.0 / wordsPerMinute)
    }
    
    private func splitCurrentWord() -> SplitValues {
        let currentWord = self.currentWord.uppercased()
        
        guard currentWord.count > 1 else {
            return .init(start: "", middle: currentWord, end: "")
        }
        
        var indexOfMiddle = currentWord.count / 2
        indexOfMiddle -= currentWord.count % 2 == 0 ? 1 : 0
        
        var valueAdjustment = 0
        
        var middle = "I"
        while middle == "I" {
            middle = String(currentWord.map{$0}[indexOfMiddle + valueAdjustment])
            if middle != "I" {
                break
            }
            if valueAdjustment >= 0 {
                valueAdjustment = valueAdjustment + 1
            } else {
                valueAdjustment = -valueAdjustment
            }
        }
        
        var first = ""
        if indexOfMiddle + valueAdjustment > 0 {
            first = String(currentWord.prefix(indexOfMiddle + valueAdjustment))
        }
        let last = String(currentWord.suffix(currentWord.count - (indexOfMiddle + valueAdjustment) - 1))
        
        return .init(start: first, middle: middle, end: last)
    }
    
    private func setupText(selectedText: String) {
        let separators = CharacterSet.punctuationCharacters.subtracting(CharacterSet(charactersIn: "'")).union(.whitespacesAndNewlines)
        let wordsArray = selectedText.components(separatedBy: separators).filter { !$0.isEmpty }
        words = wordsArray
    }
    
    private func updateCurrentWord() {
        guard currentIndex.0 < words.count else { return }
        
        timer?.invalidate()
        
        let speedInterval = updateReaderSpeed(to: wordsPerMinute)
        
        let timerPublisher = Timer.publish(every: TimeInterval(speedInterval), on: .main, in: .default)
            .autoconnect()
            .eraseToAnyPublisher()
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(speedInterval), repeats: true) { timer in
            guard self.currentIndex.0 < self.words.count else {
                timer.invalidate()
                self.timer = nil
                return
            }
            
            self.currentWord = self.words[self.currentIndex.0]
            self.currentIndex.0 += 1
            
            self.splitValues = self.splitCurrentWord()
        }
        
        timerPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    private func startReading() {
        userSelectedText()
        updateCurrentWord()
        
    }
    
    private func pauseReading() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateReaderSpeed(to value: Double) -> TimeInterval {
        readerVelocity.timeInterval = value
        return TimeInterval(readerVelocity.timeInterval)
        
    }
}
