//
//  SimplePageViewModel.swift
//  MVVMCollection
//
//  Created by Alex on 05.08.22.
//

import Foundation

protocol SimplePageViewModel {
    var titleText: String { get }
    var dateText: String { get }
    
    // May be actions
    // func changeDate(by dateText: String)
}


/// 1) Simple option
/// В простых случаях можно обойтись extension'ом к модели
/// Протокол даёт необходимое скрытие
extension SimpleDomainModel: SimplePageViewModel {
    var titleText: String {
        "\(answer)"
    }
    var dateText: String {
        date.ISO8601Format()
    }
}


/// 2) Complicated option
/// В более сложных сценариях может потребоваться отдельная сущность,
/// которая оборачивает исходную модель
/// Её роль заключается в инкапсуляции объектов и методов, необходимых для энкодинга модели во View
/// и для декодинге элементарных событий от View в понятные для buisness logic экшены
final class FormatedSimplePageViewModelImpl {
    private var formater = DateFormatter()
    
    var model: SimpleDomainModel
    
    init(model: SimpleDomainModel) {
        self.model = model
        
        formater.dateStyle = .medium
        formater.timeStyle = .short
        formater.locale = Locale(identifier: "RU_ru")
    }
}

/// Сложный encoding/decoding модели удобнее держать отдельно
/// от кода редеринга, даже если не предвидится редизайна View
extension FormatedSimplePageViewModelImpl: SimplePageViewModel {
    var titleText: String {
        formatNumbers(for: model.answer)
    }
    
    var dateText: String {
        formater.string(from: model.date)
    }
}

extension FormatedSimplePageViewModelImpl {
    private func formatNumbers(for number: Int) -> String {
        "\(number)"
            .compactMap { Int(String($0)) }
            .map { getEmoji(for: $0) }
            .joined()
        
    }
    
    private func getEmoji(for number: Int) -> String {
        switch number {
        case 0...9:
            return "\(number)\u{fe0f}\u{20e3}"
        default:
            return "🆕"
        }
    }
}
