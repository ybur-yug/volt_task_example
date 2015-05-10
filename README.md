# Volt Tasks - Introduction

## [Original Video by @rickcarlino](https://www.youtube.com/watch?v=th0UKrSFdo0)

## Getting Started
First, let's get a basic application set up. I will assume you've already dug around a simple project, but if you
are completely new to Volt I would recommend reading through the documentation [here](http://docs.voltframework.com).
We create a project with a simple

`volt new project_name`

And it will bundle automatically. However, if you prefer to bundle to a local path like I do using:

`bundle --path vendor/bundle`

This is what you should see after creating your first application:

![step 1](http://i.imgur.com/ujb4F0E.gif)

Now that we have a project, we can fire up our server and have the application start to run. One of the best things about
development in Volt is the server will automatically reload your new code. So, start a server in a separate terminal and 
proceed to generate a task now. 

(in a new terminal)
`bundle exec volt s`

(in the original)
`bundle exec volt g task stat`

```addendum: In the gif I type `stats`, this was a mistake and I didn't re-record it.```

Now, let's see what that gets us:

![step 2](http://i.imgur.com/8r3VaJQ.gif)

So we have a Volt task, and the relevent spec. Let's open up the default task file and check it out:

```RUBY
class StatTask < Volt::Task

end
```

Now, lets add some code to get information from the backend using this task we have generated. Volt tasks exclusively run
asynchronously on the backend.

```RUBY
...
  def show_stats
    {
      ruby_version:     RUBY_VERSION, # note that these are constants always available in Ruby
      ruby_description: RUBY_DESCRIPTION,
      ruby_platform:    RUBY_PLATFORM
    }
  end
...
```
##### [Source](https://github.com/ybur-yug/volt_task_example/blob/master/app/main/tasks/stat_task.rb#L2)


Now, this method is an instance level method. However, to call it in our controller Volt has a slightly different convention
than the norm when it comes to invoking this. It is also worth noting that even though we are writing it as a Ruby hash, it 
will be coerced into a Volt model on the frontend. This becomes an important detail 

If we navigate to our controller, we can begin to handle the output from this.

```RUBY
module Main
  class MainController < Volt::ModelController
    def index
      StatTask.show_stats
      .then do |stats|
        page._info = stats
      end.fail do |error|
        page._info = error
      end
    ...
   end
end
```
##### [Source](https://github.com/ybur-yug/volt_task_example/blob/master/app/main/controllers/main_controller.rb#L5)

Now if we go to our client code in `app/main/views/main/index.html`, we have created a `page._info` Volt model we can access these parameters from. Not that is is accessed with a `_` prepended. This is another Volt convention.

```RUBY
...
  <h2>Ruby Description</h2>
    {{ page._info._ruby_description }}
  <h2>Ruby Version</h2>
    {{ page._info._ruby_version }}
  <h2>Ruby Platform</h2>
    {{ page._info._ruby_platform }}
 ...
```
##### [Source](https://github.com/ybur-yug/volt_task_example/blob/master/app/main/views/main/index.html#L7)

And now we've successfully executed code on only the server, and fed it to the client once the task was completed.

Happy Hacking.
