SCHEDULER.every '1d', :first_in => 0 do |job|  
  heros = YAML.load_file('heros.yml')
  leaders = get_leaders(heros)
  if leaders
    heros.keys.each do |hid|
      # Ladies
      data = leader_list(hid, 'women', leaders).take(5)
      if data
        send_event(hid+'-f', { items: data })
      end
      # Gentlmen
      data = leader_list(hid, 'men', leaders).take(5)
      if data
        send_event(hid+'-m', { items: data })
      end
    end
  end
end