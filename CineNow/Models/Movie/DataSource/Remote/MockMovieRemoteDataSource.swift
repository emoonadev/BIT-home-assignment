//
//  MovieRemoteDataSource.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import ComposableArchitecture
import Foundation

struct MockMovieRemoteDataSource: MovieRemoteDataSourceService {
    
    func fetchUpcoming(at index: Int) async throws -> [Movie] {
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
            )
        ]
    }
    
    func fetchTopRated(at index: Int) async throws -> [Movie] {
        [
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
            Movie(
                id: 855_263,
                overview: "Struggling but unapologetically living on her own terms, Inez is moving from shelter to shelter in mid-1990s New York City. With her 6-year-old son Terry in foster care and unable to leave him again, she kidnaps him so they can build their life together.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-03-31")!,
                name: "A Thousand and One",
                voteAverage: 8.3,
                voteCount: 11,
                posterPath: "/9WyipqK3wOf8lJLWqFX0r7aBodm.jpg"
            ),
            Movie(
                id: 842_675,
                overview: "Humans built huge engines on the surface of the earth to find a new home. But the road to the universe is perilous. In order to save earth, young people once again have to step forward to start a race against time for life and death.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-01-22")!,
                name: "The Wandering Earth II",
                voteAverage: 7.6,
                voteCount: 164,
                posterPath: "/pR858ihc6Ls9xohpdRJVjV787ml.jpg"
            ),
            Movie(
                id: 497_828,
                overview: "A celebrity model couple are invited on a luxury cruise for the uber-rich, helmed by an unhinged, alcoholic captain. What first appears Instagrammable ends catastrophically, leaving the survivors stranded on a desert island in a struggle of hierarchy.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2022-09-18")!,
                name: "Triangle of Sadness",
                voteAverage: 7.2,
                voteCount: 1224,
                posterPath: "/k9eLozCgCed5FGTSdHu0bBElAV8.jpg"
            )
        ]
    }
    
    func fetchNowPlaying(at index: Int) async throws -> [Movie] {
        [
            Movie(
                id: 713_704,
                overview: "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-04-12")!,
                name: "Evil Dead Rise",
                voteAverage: 7.0,
                voteCount: 207,
                posterPath: "/mIBCtPvKZQlxubxKMeViO2UrP3q.jpg"
            ),
            Movie(
                id: 758_323,
                overview: "Father Gabriele Amorth, Chief Exorcist of the Vatican, investigates a young boy's terrifying possession and ends up uncovering a centuries-old conspiracy the Vatican has desperately tried to keep hidden.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-04-05")!,
                name: "The Pope's Exorcist",
                voteAverage: 6.5,
                voteCount: 143,
                posterPath: "/9JBEPLTPSm0d1mbEcLxULjJq9Eh.jpg"
            ),
            Movie(
                id: 385_687,
                overview: "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-05-17")!,
                name: "Fast X",
                voteAverage: 7.0,
                voteCount: 524,
                posterPath: "/jwMMQR69Xz9AYtX4u2uYJgfAAev.jpg"
            ),
            Movie(
                id: 447_277,
                overview: "The youngest of King Triton's daughters, and the most defiant, Ariel longs to find out more about the world beyond the sea, and while visiting the surface, falls for the dashing Prince Eric. With mermaids forbidden to interact with humans, Ariel makes a deal with the evil sea witch, Ursula, which gives her a chance to experience life on land, but ultimately places her life – and her father's crown – in jeopardy.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-05-18")!,
                name: "The Little Mermaid",
                voteAverage: 7.2,
                voteCount: 246,
                posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg"
            ),
            Movie(
                id: 447_365,
                overview: "Peter Quill, still reeling from the loss of Gamora, must rally his team around him to defend the universe along with protecting one of their own. A mission that, if not completed successfully, could quite possibly lead to the end of the Guardians as we know them.",
                createdAt: DateFormatter.tmdbFormatter.date(from: "2023-05-03")!,
                name: "Guardians of the Galaxy Volume 3",
                voteAverage: 8.5,
                voteCount: 239,
                posterPath: "/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg"
            )
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