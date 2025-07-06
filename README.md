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
[
    {
        "id": recipe_id,
        "name": recipe_name,
        "category": category_name,
        "ingredients": "a free text field listing all ingredients",
        "instructions": "a free text field with instructions",
        "preparation_time": preparation time in minutes,
        "photo_url": link to original image,
        "thumb_url": link to image scaled down to thumb size
    }
]
```

### get api/v1/recipes/:id
Finds a recipe with given id, returns the following format:
```
{
    "id": recipe_id,
    "name": recipe_name,
    "category": category_name,
    "ingredients": "a free text field listing all ingredients",
    "instructions": "a free text field with instructions",
    "preparation_time": preparation time in minutes,
    "photo_url": link to original image,
    "thumb_url": link to image scaled down to thumb size
}
```

### post api/v1/recipes
Creates a new recipe receiving the following attributes:
```
{
    name": recipe_name,
    "category": category_name,
    "ingredients": "a free text field listing all ingredients",
    "instructions": "a free text field with instructions",
    "preparation_time": preparation time in minutes,
    "photo": link for photo
}
```
obs: On Postman you can send an image as a parameters by sending the params on the form-data format and setting the "photo" param
as a file

In case of success, the request will return a json with the following format:
```
{
    "id": recipe_id,
    "name": recipe_name,
    "category": category_name,
    "ingredients": "a free text field listing all ingredients",
    "instructions": "a free text field with instructions",
    "preparation_time": preparation time in minutes,
    "photo_url": link to original image,
    "thumb_url": link to image scaled down to thumb size
}
```

### patch api/v1/recipes/:id
Finds a recipe with given id, update it's attributes and returns the following format:
```
{
    "id": recipe_id,
    "name": recipe_name,
    "category": category_name,
    "ingredients": "a free text field listing all ingredients",
    "instructions": "a free text field with instructions",
    "preparation_time": preparation time in minutes,
    "photo_url": link to original image,
    "thumb_url": link to image scaled down to thumb size
```

### delete api/v1/recipes/:id
Finds a recipe with given id, and deletes it
In case of success, it returns a message

### There's similar endpoints for users but the input attributes currently are:
```
{
    "name": username,
    "email": email,
    "avatar": link to image
}
```

the output json will follow the format:
```
{
    "id": user id,
    "name": user name,
    "email": user email,
    "avatar_url": link to original image,
    "thumb_url": link to image scaled down to thumb size
}
```



## To do
- Add authentication to user model
- Add documentation to api through RDoc or another tool
- Change format of ingredients attribute of recipe so it's of the json type
- Link users and recipes

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