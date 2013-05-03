#!/usr/bin/env ruby
# encoding: utf-8

module Jekyll  
  class Site
    def generate_projects
      dir = self.config['project_dir'] || 'projects'
      self.config['projects'] = []

      Dir[File.join(dir, "*/")].each do |i|
        next if i == dir
        next if ['.','..'].include?(i)

        dirname = File.dirname(i)
        basename = 'index.textile'

        puts "PROCESSING #{dirname} (#{i})"

        page = Page.new(self, self.source, i, basename)
        page.data['slug'] = File.split(i).last.downcase unless page.data['slug']

        self.config['projects'] << page
      end

      self.config['projects'].sort!{|i,j| i.data['slug'] <=> j.data['slug'] }

      puts "FINAL PAGES: #{self.config['projects'].collect{|i| i.url}.join(', ')}"
    end

    def get_project_pages(filename, parent=nil)
      rv = []


      if File.directory?(filename)
        # Dir["#{filename}/*"].each do |i|
        #   rv += get_project_pages(i)
        # end
      else
        dirname = File.dirname(filename)
        basename = File.basename(filename)

        page = Page.new(self, self.source, dirname, basename)
        page.data['slug'] = File.split(dirname).last.downcase unless page.data['slug']
        #page.data['subpages'] = []

        # Dir[File.join(dirname, '*')].each do |j|
        #   if File.exists?(File.join(j, 'index.textile'))
        #     page.data['subpages'] << j
        #   end
        # end

        rv << page
      end

    #   if basename
    #     page = Page.new(self, self.source, relpath, basename)
    #     page.data['slug'] = File.split(relpath).last.downcase unless page.data['slug']
    #     page.data['parent'] = parent if parent
    #   end

    # # for all children....
    #   Dir["#{relpath}/**/**"].each do |i|
    #     next if i == filename
    #     next if ['.', '..'].include?(i)

    #     if File.directory?(i)
    #       children = get_project_pages(File.join(relpath, i), page)
    #       page.data['subpages'] = children
    #       rv += children
    #     else
    #       rv << page
    #     end
    #   end

      rv
    end
  end
  
end
 
