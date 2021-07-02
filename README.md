# CleanArchitectureGallery
Photo Gallery using VIP (Clean Architecture)

In this application i am using Clean Swift Architecture (VIP).
- My Application have following modules to make my code clean, reuseable and testabel.
    -   View Controller : Here we define our views, and keep instance of interactor and router. Passes the actions from views to the interactor (output) and takes the presenter actions as input
    -   Interactor: Contains a view business logic and keep refference of presenter. Runs actions on workers based on input (from the View Controller), triggers and passes the output to the presenter.
    -   Worker: An abstraction that handles different under-the-hood operations like fetch the photos from server. Should follow the Single Responsibility principle (an interactor may contain many workers with different responsibilities).
    -   Presenter: After the interactor produces some results, it passes the response to the presenter. Next, the presenter marshals the response into view models suitable for display and then passes the view models back to the view controller for display to the user.
    -   Router: Extracts this navigation logic out of the view controller
    -   Model: Decoupled data abstractions.
