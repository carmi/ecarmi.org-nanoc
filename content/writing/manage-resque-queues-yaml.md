---
title: Manage Resque Job Queues in YAML
slug: manage-resque-jobs-yaml
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2013-08-11"
updated_at: "2013-08-11"
published: true
featured: true
comments_enabled: true
tags: Resque, YAML
summary: Ruby metaprogramming + Resque + YAML = one slick configuration file.
---
## One config to rule them all

This post is about a neat trick to manage all of the queue declarations for many Resque Jobs in a single configuration file using a tad of metaprogramming.

## Resque Introduction

[Resque]( https://github.com/resque/resque/ ) (pronounced like "rescue") is a Redis-backed library for creating background jobs, placing those jobs on multiple queues, and processing them later. A typical job class looks like this:

~~~ ruby
class HighPriorityJob < BaseJob
  @queue = :high

  def self.perform(args)
    # code to do some work
  end
end
~~~

And then you can enqueue the job for processing later with `Resque.enqueue(HighPriorityJob, args)`. Now you have some workers that run the jobs on each queue. Some jobs are more important than others so you end up with a few different queues. Maybe a `high`, `medium`, and `low` queue relating to the priority of each job.

This is all fine and dandy for a few jobs. But sometimes your codebase grows and you end up with many different job classes. In this case it can get unwieldy to define each queue in the class itself. Wouldn't it be nice if you could define which queue any given job runs on in a central YAML file? You could then easily see which jobs run on which queues, easily change which jobs run on which queues, and reduce duplication. Let's do it!

Let's assume we have a bunch of jobs including these:

~~~ ruby
class MediumPriorityJob < BaseJob
  @queue = :medium

  def self.perform(args)
  end
end
~~~

~~~ ruby
class LowPriorityJob < BaseJob
  @queue = :low

  def self.perform(args)
  end
end
~~~

~~~ ruby
class OtherPriorityJob < BaseJob
  @queue = :low

  def self.perform(args)
  end
end
~~~

 The majority of jobs run on the `low` queue and this seems like a good default queue for us. Then whenever we have a special job that needs to be run on a separate queue we can define it separately. Let's imagine what we would want a YAML file to look like:

~~~ yaml
job_queues:
  # Defaults for all jobs if not specified
  default_queue:
    "low"
  high_priority_job:
    queue: "high"
  medium_priority_job:
    queue: "medium"
~~~

Great, let's settle on [underscore](http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore)'ing our class names in the YAML file, so ThisIsMyClass becomes this_is_my_class. (If you are not using rails you'll have to supply your own `#underscore` method.)

Cool, now I find it handy to combine this with the definitions of workers, so I placed that YAML into my resque-pool.yml. But you can place it wherever. Then adding it to our app is as easy as doing a `YAML.load` on the file in your app setup. If you're running on Rails then in an initializer would do the trick. Something like this will work for Rails:

~~~ ruby
Resque::RESQUE_JOB_QUEUES = YAML.load_file(Rails.root.join('config/resque-pool.yml'))['job_queues']
~~~

## A Touch of Metaprogramming

Sweet, but how to do we get our jobs to actually follow this configuration file. Well, you may have noticed that all our jobs inherit from the BaseJob class. What's all that about. Well, a lot of applications have some logging or stats that they want to attach to all the jobs. By having a base class that every job inherits from you can easily manage job-wide settings. And that's exactly what we will do.

There's a handy little method that every class in Ruby has called [`#inherited`](http://www.ruby-doc.org/core-2.0/Class.html#method-i-inherited)  Whenever we do `MyClass < YourClass` inherited is called on YourClass with MyClass as the argument.

In our BaseJob class let's add an `#inherited` method that will assign the queue to the class:

~~~ ruby
class BaseJob
  # things that are common to all jobs go up here...

  def self.inherited(subclass)
    # Lookup class specific settings from config/resque-pool.yml
    subclass_config = Resque::RESQUE_JOB_QUEUES[subclass.name.underscore]
    # this is replaces having to do @queue = 'low-heavy' in the worker classes
    subclass.instance_variable_set(:@queue, self.resque_queue_name(subclass_config))
  end

  def self.resque_queue_name(subclass_config)
    if subclass_config.try(:[], 'queue')
      return subclass_config['queue']
    else
      return Resque::RESQUE_JOB_QUEUES['default_queue']
    end
  end
end
~~~

## One configuration file to rule them all

And that's it. Now we can add a new class without having to think about what queue it should be on. It'll magically use the default queue.

