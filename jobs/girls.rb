SCHEDULER.every '1d', :first_in => 0 do |job|  
  girls = YAML.load_file('girls.yml')
  leaders = get_leaders(girls)
  if leaders
    girls.keys.each do |gid|
      # Ladies
      data = leader_list(gid, 'women', leaders).take(5)
      if data
        send_event(gid+'-f', { items: data })
      end
      # Gentlmen
      data = leader_list(gid, 'men', leaders).take(5)
      if data
        send_event(gid+'-m', { items: data })
      end
    end
  end
end

