//
//  Achievment.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 05.02.2025.
//

import UIKit

struct Achievment {
    let title: String
    let descripton: String
    let iconName: String
    let color: UIColor
    
    static var demoData: [Achievment] {
            return [
                Achievment(
                    title: "Мировой исследователь",
                    descripton: "Посетил 150+ стран на 6 континентах",
                    iconName: "globe.europe.africa.fill",
                    color: .systemTeal
                ),
                Achievment(
                    title: "Фотограф года",
                    descripton: "Выложил 1000+ фотографий с геолокациями",
                    iconName: "camera.aperture",
                    color: .systemOrange
                ),
                Achievment(
                    title: "Альпинист",
                    descripton: "Покорил 5 вершин выше 4000 метров",
                    iconName: "mountain.2.fill",
                    color: .systemIndigo
                ),
                Achievment(
                    title: "Эко-герой",
                    descripton: "Собрал 50 кг мусора во время путешествий",
                    iconName: "leaf.fill",
                    color: .systemGreen
                ),
                Achievment(
                    title: "Фуд-эксперт",
                    descripton: "Попробовал 30 национальных блюд",
                    iconName: "fork.knife.circle.fill",
                    color: .systemRed
                ),
                Achievment(
                    title: "Культуролог",
                    descripton: "Посетил 20 музеев и исторических мест",
                    iconName: "books.vertical.fill",
                    color: .systemPurple
                )
            ]
        }
}
