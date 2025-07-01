# README

This will be an app to store and retrieve recipes through an api.
To run the app, you'll be able to use either local environment and through container.

To run the application localy, it'll be necessary to have Ruby version 3.4.4 or above.

## Installation instructions

### Local environment
 - Run `bundle install`
 - Run `rails db:create && rails db:migrate`
 - Start the server with `rails s`

## Currently existing endpoints

### get api/v1/recipes
List all saved recipes, accept a series of parameters under a "search" hash
searchable attributes:
```
name: recipe name
category_name: the recipe's category

```

The request has two possible outputs:
one in which it returns a message saying that there's no recipe saved and a list of recipes. the response in the second case follows the format below:
```
{
    {
        "id": recipe_id,
        "name": recipe_name,
        "preparation_time": preparation time in minutes,
        "ingredients": a free text field listing all ingredients,
        "instructions": a free text field with instructions,
        "created_at": creation_date,
        "updated_at": update time,
        "category": category name
    }
}
```

### get api/v1/recipes/:id
Finds a recipe with given id, returns the following format:
```
{
    "id": recipe_id,
    "name": recipe_name,
    "preparation_time": preparation time in minutes,
    "ingredients": a free text field listing all ingredients,
    "instructions": a free text field with instructions,
    "created_at": creation_date,
    "updated_at": update time,
    "category": category name
}
```


## To do
- Fix implementation of solid queue
- Add documentation to api through RDoc or another tool

## Applied concepts

1. Namespace
Used at the controllers to help organize the code and enable suport of multiple versions of the same controller.

2. Observers
Used to update related entities whenever an object is updated. In this API, the pattern is applied implicitly at the User and Recipe model to remove attachment images when they are deleted.

3. Query Objects
Used to remove queries from controllers and models so they can be reused when necessary. Query Objects are being as the filter classes at the controllers. The filter classes are present under the 'queries' folder

4. Factory Design Pattern
Used to make a base class with wider scoped methods while having child classes for more specialized uses. In this API, it was applied on the filter classes with RecipeFilters inheriting from BaseFilters so that it becomes possible to add filters for users in the future.

5. Jobs
When a image is added to an user or recipe, a background job is ran to generate variant files for it so the app has thumbnail version of it