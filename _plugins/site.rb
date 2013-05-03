module Jekyll
  class Site
    alias orig_site_payload site_payload
    def site_payload
        h = orig_site_payload

    #   detect the presence of (and add if there) the 'time' front matter tag
        posts.each{|p| 
            if p.data.has_key?('time') then
                time = p.data['time']
                if time =~ /[0-9]{1,2}:[0-9]{2}/ then
                    time = time.split(":")
                    p.date = Time.local(p.date.year, p.date.month, p.date.day, time[0].to_i, time[1].to_i, 0)
                end
            end
        }

        payload = h["site"]

    #   sort articles by date/time
        payload["articles"] = posts.sort {|p1, p2| 
            p2.date <=> p1.date
        }

        payload["articlesByMonth"] = posts.group_by{|p|
            p.date.strftime('%B %Y')
        }

    #   add projects to payload
        #payload["projects"] = 

        payload["max_results"] = payload.fetch("max_results", 15)
        h["site"] = payload

        h
    end
  end
end