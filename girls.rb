
def leader_list(girl, sex, leaders)
  list = []
  return false unless leaders[girl] and leaders[girl][sex]
  leaders[girl][sex].each do |rank, athlete|
    # Clean Up Name
    name = athlete['name'].split(' ')
    label = name[0]+name[1].chars.first.upcase
    # Result
    result = athlete['result']
    # Barbara
    if girl == 'barbara' 
      result = result.split('|')[0]
    end
    # Nicole
    if girl == 'nicole' 
      result = result.split('|')[1]
    end
    # Cindy
    if girl == 'cindy' 
      result = result.split('|')[0].split(' ')[0].to_i.to_s
    end
    # Lynne
    if girl == 'lynne' 
      result = result.split('|')[0]
    end
    # Hammer
    if girl == 'hammer' 
      result = result.split('|')[0]
    end
    # Holbrook
    if girl == 'holbrook' 
      result = result.split('|')[0]
    end
    # Strip and Round Rounds
    if result.include?('rounds')
      result = result.gsub(' rounds','').to_i.to_s  
    end
    # Strip and Round Reps
    if result.include?('reps')
      result = result.gsub(' reps','').to_i.to_s  
    end
    # Clean Up Labels
    result.gsub!(' mins ',':')
    result.gsub!(' mins','')
    result.gsub!(' min','')
    result.gsub!(' secs','')
    result.gsub!(' sec','')
    list.push({label: label, value: result})
  end
  # Pad The List
  if leaders[girl][sex].length < 5
    fill = 5-leaders[girl][sex].length
    (0..fill).each do |f|
      list.push({label: '&nbsp;', value: '&nbsp;'})
    end
  end
  return list
end

def get_leaders(girls)
  # Beyond The White Board Credentials
  return false unless ENV['BTWB_USERNAME']
  return false unless ENV['BTWB_PASSWORD']
  return false unless ENV['BTWB_BOX']

  # Today's date
  date = Time.now.strftime("%Y-%m-%d")

  # Process Girls
  leaders = {}
  girls.each do |girl,atom|
    # Get ATOM feed from BTWB and archive data
    xml_path = 'atom/' + date + '-' + ENV['BTWB_BOX'] + '-' + atom
    if !File.file?(xml_path)
      xml = HTTParty.get('http://beyondthewhiteboard.com/gyms/' + ENV['BTWB_BOX'] + '/leader_boards/' + atom, basic_auth: { username: ENV['BTWB_USERNAME'], password: ENV['BTWB_PASSWORD'] })
      File.open(xml_path, 'w+') do |file|
        file.puts xml
      end
    else
      xml = File.open(xml_path)
    end
    # Parse XML
    men = {}
    women = {}
    girl_xml = Nokogiri::XML(xml)
    girl_xml.xpath("//xmlns:ul", "xmlns" => "http://www.w3.org/1999/xhtml").each do |result|
      data = {}
      result.xpath("./xmlns:li", "xmlns" => "http://www.w3.org/1999/xhtml").each do |item|
        if item.text != ''
          data[item.attr('class')] = item.text
        end
      end
      if data['gender'] == 'Male'
        rank = data['rank']
        men[rank] = data
      end
      if data['gender'] == 'Female'
        rank = data['rank']
        women[rank] = data
      end
    end
    leaders[girl] = {'men'=>men,'women'=>women}
  end
  return leaders
end