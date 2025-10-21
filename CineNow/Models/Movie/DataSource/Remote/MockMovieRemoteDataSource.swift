//
//  MovieRemoteDataSource.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

struct MockMovieRemoteDataSource: MovieRemoteDataSourceService {
    
    func fetchPopular(at index: Int) async throws -> [Movie] {
        [
            Movie(
                id: 76600,
                overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2022-12-14")!,
                name: "Avatar: The Way of Water",
                voteAverage: 7.7,
                voteCount: 7535,
                posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"
            ),
            Movie(
                id: 948_713,
                overview: "In the wake of King Edward's death, Uhtred of Bebbanburg and his comrades adventure across a fractured kingdom in the hopes of uniting England at last.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-04-14")!,
                name: "The Last Kingdom: Seven Kings Must Die",
                voteAverage: 7.4,
                voteCount: 232,
                posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg"
            ),
            Movie(
                id: 677_179,
                overview: "After dominating the boxing world, Adonis Creed has been thriving in both his career and family life. When a childhood friend and former boxing prodigy, Damian Anderson, resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face-off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damian — a fighter who has nothing to lose.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-03-01")!,
                name: "Creed III",
                voteAverage: 7.3,
                voteCount: 1192,
                posterPath: "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg"
            ),
            Movie(
                id: 638_974,
                overview: "After starting their own detective agency, Nick and Audrey Spitz land a career-making case when their billionaire pal is kidnapped from his wedding.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-03-28")!,
                name: "Murder Mystery 2",
                voteAverage: 6.5,
                voteCount: 864,
                posterPath: "/s4GA2ZSRS0L6XRQZJIZH8CUiAAK.jpg"
            ),
            Movie(
                id: 713_704,
                overview: "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-04-12")!,
                name: "Evil Dead Rise",
                voteAverage: 7.0,
                voteCount: 207,
                posterPath: "/5ik4ATKmNtmJU6AYD0MaiHACxJa.jpg"
            ),
            Movie(
                id: 315_162,
                overview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2022-12-07")!,
                name: "Puss in Boots: The Last Wish",
                voteAverage: 8.3,
                voteCount: 5331,
                posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg"
            ),
            Movie(
                id: 603_692,
                overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-03-22")!,
                name: "John Wick: Chapter 4",
                voteAverage: 8.0,
                voteCount: 1211,
                posterPath: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
            ),
        ]
    }

    func fetchDetails(id: Int) async throws -> Movie {
        Movie(
            id: 603_692,
            overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
            createdAt: DateFormatter.tmdbFormatter.date(from: "2023-03-22")!,
            name: "John Wick: Chapter 4",
            voteAverage: 8.0,
            voteCount: 1211,
            posterPath: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
        )
    }
    
}
