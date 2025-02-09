//
//  Achievment.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 05.02.2025.
//

import UIKit

struct Achievment {
    let title: String
    let description: String
    let iconName: String
    let color: UIColor
    let currentProgress: Int
    let maxProgress: Int
    let obtainedDate: Date?
    
    static var demoData: [Achievment] {
        return [
            Achievment(
                title: "Мировой исследователь",
                description: "Посетил 150+ стран на 6 континентах",
                iconName: "globe.europe.africa.fill",
                color: .systemTeal,
                currentProgress: 130,
                maxProgress: 150,
                obtainedDate: nil
            ),
            Achievment(
                title: "Фотограф года",
                description: "Выложил 1000+ фотографий с закатом",
                iconName: "camera.aperture",
                color: .systemOrange,
                currentProgress: 45,
                maxProgress: 1000,
                obtainedDate: nil
            ),
            Achievment(
                title: "Альпинист",
                description: "Покорил 5 вершин выше 4000 метров",
                iconName: "mountain.2.fill",
                color: .systemIndigo,
                currentProgress: 3,
                maxProgress: 5,
                obtainedDate: nil
            ),
            Achievment(
                title: "Эко-герой",
                description: "Собрал 50 кг мусора во время путешествий",
                iconName: "leaf.fill",
                color: .systemGreen,
                currentProgress: 50,
                maxProgress: 50,
                obtainedDate: Date()
            ),
            Achievment(
                title: "Фуд-эксперт",
                description: "Попробовал 30 национальных блюд",
                iconName: "fork.knife.circle.fill",
                color: .systemRed,
                currentProgress: 30,
                maxProgress: 30,
                obtainedDate: Date()
            ),
            Achievment(
                title: "Культуролог",
                description: "Посетил 20 музеев и исторических мест",
                iconName: "books.vertical.fill",
                color: .systemPurple,
                currentProgress: 20,
                maxProgress: 20,
                obtainedDate: Date()
            ),
            Achievment(
                title: "Морской волк",
                description: "Провел 100 часов на яхте",
                iconName: "sailboat.fill",
                color: .systemBlue,
                currentProgress: 100,
                maxProgress: 100,
                obtainedDate: Date()
            ),
            Achievment(
                title: "Путешественник во времени",
                description: "Посетил 10 разных часовых поясов",
                iconName: "clock.fill",
                color: .systemYellow,
                currentProgress: 4,
                maxProgress: 10,
                obtainedDate: nil
            )
        ]
    }
}
