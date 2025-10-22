# BIT - iOS TechnicaHome Assignment

## General Architecture

The project is built using **SwiftUI** and the **TCA** framework.  
I followed **Use Case design pattern**, where each layer has a clear and independent responsibility.  
This separation ensures the project is **modular**, **testable**, and **scalable** over time

### Layers Overview
- **UI Layer**
- **Domain Layer (Use Cases)
- **Data Layer (Repositories - DataSources)**

This structure allows easy testing, better readability, and smooth teamwork in a large-scale environment.

---

## Technical Decisions
- **Accessibility**  
  I added **accessibility labels and text descriptions** across the app.  
  For apps like BIT, this is important to have a great user experience for everyone.
  
- **Why TCA?**  
  It provides a clear flow of data and actions, and fits well with SwiftUI.
  
- **Why Use Cases?**  
  Keeps business logic isolated from UI and infrastructure, making the app easier to maintain and extend.

---

## Not Implemented

- **Play Trailer** — Not implemented due to lack of time.  
  My focus was on delivering clean, maintainable, and scalable code first

---

## If I Had More Time?

- Implement the **Play Trailer** feature.
- Add more **unit tests**

---

## Tests

A few **unit tests** have been included to demonstrate the testability of the architecture.  
With more time, I would increase coverage, especially for use cases and reducers

---

## Notes

I approached this exercise as if it were a **real production project**, prioritizing:
- Code readability and structure
- Clear separation of responsibilities
- Scalability for future features
- Accessibility and user experience

---
