# README

This will be an app to store and retrieve recipes through an api.
To run the app, you'll be able to use either local environment and through container.

## Applied concepts

1. Service Objects
Used to remove business logic from both controllers and models in order to keep the code cleaner

2. Observers
Used to update related entities whenever an object is updated. In this API, the pattern is applied implicitly at the User and Recipe model to remove attachment images when they are deleted.

3. Query Objects
Used to remove queries from controllers and models so they can be reused when necessary. Query Objects are being as the filter classes at the controllers. The filter classes are present under the 'queries' folder

4. Factory Design Pattern
Used to make a base class with wider scoped methods while having child classes for more specialized uses. In this API, it was applied on the filter classes with RecipeFilters inheriting from BaseFilters so that it becomes possible to add filters for users in the future.