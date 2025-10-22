//
//  MovieRemoteDataSource.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

struct MockMovieRemoteDataSource: MovieRemoteDataSourceService {
    
    func fetchUpcoming(at _: Int) async throws -> MoviesListResponseDTO {
        MoviesListResponseDTO(
            results: [
                Movie(
                    id: 76600,
                    overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2022-12-14")!,
                    title: "Avatar: The Way of Water",
                    voteAverage: 7.7,
                    voteCount: 7535,
                    posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"
                ),
                Movie(
                    id: 948_713,
                    overview: "In the wake of King Edward's death, Uhtred of Bebbanburg and his comrades adventure across a fractured kingdom in the hopes of uniting England at last.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-14")!,
                    title: "The Last Kingdom: Seven Kings Must Die",
                    voteAverage: 7.4,
                    voteCount: 232,
                    posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg"
                ),
                Movie(
                    id: 677_179,
                    overview: "After dominating the boxing world, Adonis Creed has been thriving in both his career and family life. When a childhood friend and former boxing prodigy, Damian Anderson, resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face-off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damian — a fighter who has nothing to lose.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-01")!,
                    title: "Creed III",
                    voteAverage: 7.3,
                    voteCount: 1192,
                    posterPath: "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg"
                ),
                Movie(
                    id: 638_974,
                    overview: "After starting their own detective agency, Nick and Audrey Spitz land a career-making case when their billionaire pal is kidnapped from his wedding.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-28")!,
                    title: "Murder Mystery 2",
                    voteAverage: 6.5,
                    voteCount: 864,
                    posterPath: "/s4GA2ZSRS0L6XRQZJIZH8CUiAAK.jpg"
                ),
                Movie(
                    id: 713_704,
                    overview: "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-12")!,
                    title: "Evil Dead Rise",
                    voteAverage: 7.0,
                    voteCount: 207,
                    posterPath: "/5ik4ATKmNtmJU6AYD0MaiHACxJa.jpg"
                ),
            ],
            page: 1,
            totalPages: 1
        )
    }

    func fetchTopRated(at _: Int) async throws -> MoviesListResponseDTO {
        MoviesListResponseDTO(
            results: [
                Movie(
                    id: 76600,
                    overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2022-12-14")!,
                    title: "Avatar: The Way of Water",
                    voteAverage: 7.7,
                    voteCount: 7535,
                    posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"
                ),
                Movie(
                    id: 948_713,
                    overview: "In the wake of King Edward's death, Uhtred of Bebbanburg and his comrades adventure across a fractured kingdom in the hopes of uniting England at last.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-14")!,
                    title: "The Last Kingdom: Seven Kings Must Die",
                    voteAverage: 7.4,
                    voteCount: 232,
                    posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg"
                ),
                Movie(
                    id: 677_179,
                    overview: "After dominating the boxing world, Adonis Creed has been thriving in both his career and family life. When a childhood friend and former boxing prodigy, Damian Anderson, resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face-off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damian — a fighter who has nothing to lose.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-01")!,
                    title: "Creed III",
                    voteAverage: 7.3,
                    voteCount: 1192,
                    posterPath: "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg"
                ),
                Movie(
                    id: 638_974,
                    overview: "After starting their own detective agency, Nick and Audrey Spitz land a career-making case when their billionaire pal is kidnapped from his wedding.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-28")!,
                    title: "Murder Mystery 2",
                    voteAverage: 6.5,
                    voteCount: 864,
                    posterPath: "/s4GA2ZSRS0L6XRQZJIZH8CUiAAK.jpg"
                ),
                Movie(
                    id: 713_704,
                    overview: "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-12")!,
                    title: "Evil Dead Rise",
                    voteAverage: 7.0,
                    voteCount: 207,
                    posterPath: "/5ik4ATKmNtmJU6AYD0MaiHACxJa.jpg"
                ),
            ],
            page: 1,
            totalPages: 1
        )
    }

    func fetchNowPlaying(at _: Int) async throws -> MoviesListResponseDTO {
        MoviesListResponseDTO(
            results: [
                Movie(
                    id: 76600,
                    overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2022-12-14")!,
                    title: "Avatar: The Way of Water",
                    voteAverage: 7.7,
                    voteCount: 7535,
                    posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"
                ),
                Movie(
                    id: 948_713,
                    overview: "In the wake of King Edward's death, Uhtred of Bebbanburg and his comrades adventure across a fractured kingdom in the hopes of uniting England at last.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-14")!,
                    title: "The Last Kingdom: Seven Kings Must Die",
                    voteAverage: 7.4,
                    voteCount: 232,
                    posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg"
                ),
                Movie(
                    id: 677_179,
                    overview: "After dominating the boxing world, Adonis Creed has been thriving in both his career and family life. When a childhood friend and former boxing prodigy, Damian Anderson, resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face-off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damian — a fighter who has nothing to lose.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-01")!,
                    title: "Creed III",
                    voteAverage: 7.3,
                    voteCount: 1192,
                    posterPath: "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg"
                ),
                Movie(
                    id: 638_974,
                    overview: "After starting their own detective agency, Nick and Audrey Spitz land a career-making case when their billionaire pal is kidnapped from his wedding.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-28")!,
                    title: "Murder Mystery 2",
                    voteAverage: 6.5,
                    voteCount: 864,
                    posterPath: "/s4GA2ZSRS0L6XRQZJIZH8CUiAAK.jpg"
                ),
                Movie(
                    id: 713_704,
                    overview: "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-12")!,
                    title: "Evil Dead Rise",
                    voteAverage: 7.0,
                    voteCount: 207,
                    posterPath: "/5ik4ATKmNtmJU6AYD0MaiHACxJa.jpg"
                ),
            ],
            page: 1,
            totalPages: 1
        )
    }

    func fetchDetails(id movieID: Int) async throws -> Movie {
        switch movieID {
            case 76600:
                Movie(
                    id: 76600,
                    overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2022-12-14")!,
                    title: "Avatar: The Way of Water",
                    voteAverage: 7.7,
                    voteCount: 8932,
                    posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg"
                )
            case 980078:
                Movie(
                    id: 980078,
                    overview: "In the wake of King Edward's death, Uhtred of Bebbanburg and his comrades adventure across a fractured kingdom in the hopes of uniting England at last.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-04-14")!,
                    title: "The Last Kingdom: Seven Kings Must Die",
                    voteAverage: 7.3,
                    voteCount: 456,
                    posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg"
                )
            case 677179:
                Movie(
                    id: 677179,
                    overview: "After dominating the boxing world, Adonis Creed has been thriving in both his career and family life. When a childhood friend and former boxing prodigy, Damian Anderson, resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-03-01")!,
                    title: "Creed III",
                    voteAverage: 7.2,
                    voteCount: 1192,
                    posterPath: "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg"
                )
            default:
                Movie(
                    id: movieID,
                    overview: "Mock movie overview for testing purposes.",
                    releaseDate: DateFormatter.tmdbFormatter.date(from: "2023-01-01")!,
                    title: "Mock Movie Title",
                    voteAverage: 6.0,
                    voteCount: 100,
                    posterPath: "/mockPosterPath.jpg"
                )
        }
    }
    
    func fetchFavorites(at page: Int) async throws -> MoviesListResponseDTO {
        MoviesListResponseDTO(results: [], page: 1, totalPages: 1)
    }

    func addToFavorites(_ movieID: Int) async throws {
    }

    func removeFromFavorites(_ movieID: Int) async throws {
    }
    
}
