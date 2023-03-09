# Ruby Developer Applicants Test

To understand your coding ability and style, we have devised to give you a simple practical coding test. We use this as a discussion topic during interviews and may use it as a sample of your knowledge when presenting your profile to customers.

## Objective:

Make this data searchable https://gist.github.com/g3d/d0b84a045dd6900ca4cb

## Bare minimum requirements:
- Implementation must use Ruby, JavaScript and HTML (all three). You can use rails views for this.
- Search logic should be implemented in Ruby and written by YOU, don't use a gem or external code for this
- Use Ruby 3.х, Rails 7.х (or-non-rails), Trailblazer 2.х (if you are familiar)
- A search for Lisp Common should match a programming language named "Common Lisp"
- Writing code with reusability in mind
- Search match precision
- Search results ordered by relevance
- Support for exact matches, eg. Interpreted "Thomas Eugene", which should match "BASIC", but not "Haskell"
- Match in different fields, eg. Scripting Microsoft should return all scripting languages designed by "Microsoft"
- Support for negative searches, eg. john -array, which should match "BASIC", "Haskell", "Lisp" and "S-Lang", but not "Chapel", "Fortran" or "S".
- Solution elegance
- Visual design

## Keep in mind:
- Frameworks are allowed, but not required.
- Comments are VERY useful, they help us understand your thought process
- This exercise is not meant to take more than 6 - 8 hours
- A readme file is highly encouraged
- It's preferable if you don't use a database for this small data set, instead read the JSON file

## Update how to upload db for searches
- rails db:create
- rails db:migrate
- rails db:seed
