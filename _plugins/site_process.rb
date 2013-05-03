#!/usr/bin/env ruby
module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.generate_projects
      
      self.render 

    # these must come after render
      self.cleanup
      self.write
    end
  end
end
 