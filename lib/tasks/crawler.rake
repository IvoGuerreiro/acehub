namespace :crawler do

  desc 'Crawl reddit soccer streams'
  task reddit_soccer: :environment do


    endpoints = %w[https://www.reddit.com/r/soccerstreams_pl/ https://www.reddit.com/r/soccerstreams_other]
    agent = Mechanize.new


    endpoints.each do |e|

      page = agent.get(e)

      matches = page.search('a').select {|x| x.text.include?('GMT]')}.collect{|x| [x.text, x.attributes['href']]}
      now = Time.now.utc


      list = matches.collect do |m|

        text = m.first
        ini = text.index('[')
        sep = text.index(']')
        puts text.inspect
        title = text[sep+1..-1].strip
        ix = 0
        streams = []

        kickoff = now.change(hour: text[ini+1..ini+3], min: text[ini+4..ini+6])

        kickoff += 1.day if kickoff < now - 12.hours


        match_page = agent.get('https://www.reddit.com' + m.last)
        stream_raw = match_page.search('body').text


        until (ixace = stream_raw.index('acestream:', ix)).nil?
          streams << {
            :url => stream_raw[ixace, 52],
            :extra_info => stream_raw[ixace + 52, 30].scan(/\[[a-zA-Z0-9 ]+\]/).collect{|x| x[1..-2]}.join(' ')
          }
          ix = ixace+10
        end

        streams.uniq! {|s| s[:url]}

        {
          :sport => 'Football/Soccer',
          :kickoff => kickoff,
          :title => title,
          :competition => nil,
          :streams => streams
        }

      end.select{|m| m[:streams].any? }


      puts list.inspect


      list.each do |l|
        match = Match.find_or_create_by!(sport: l[:sport], kickoff: l[:kickoff], title: l[:title]) do |m|
          m.competition = l[:competition] if l[:competition].present? && m.competition.blank?
        end

        l[:streams].each do |s|
          stream = Stream.find_or_initialize_by(match_id: match.id, url: s[:url])
          stream.extra_info = s[:extra_info] if stream.extra_info.nil? || (s[:extra_info].present? && s[:extra_info].size > stream.extra_info.size)
          stream.save!
        end
      end
    end

  end

  desc 'Crawl reddit NFL streams'
  task reddit_nfl: :environment do


    agent = Mechanize.new

    page = agent.get('https://www.reddit.com/r/nflstreams/')

    matches = page.search('a').select {|x| x.text.include?('Game Thread') && x.text.include?('@')}.collect{|x| [x.text, x.attributes['href']]}

    now = Time.now.in_time_zone('Eastern Time (US & Canada)')
    puts "NOW: #{now}"



    list = matches.collect do |m|

      text = m.first
      init_title_ix = text.index(':')
      end_title_ix = text.index('(')
      puts text.inspect
      title = text[init_title_ix+1..end_title_ix-1].strip
      ix = 0
      streams = []

      puts "#{text[end_title_ix+1..end_title_ix+2]} #{text[end_title_ix+4..end_title_ix+5]}"

      kickoff = now.change(hour: text[end_title_ix+1..end_title_ix+2], min: text[end_title_ix+4..end_title_ix+5]).utc

      kickoff += 1.day if kickoff < Time.now.utc - 12.hours


      match_page = agent.get('https://www.reddit.com' + m.last)
      stream_raw = match_page.search('body').text


      until (ixace = stream_raw.index('acestream:', ix)).nil?
        streams << {
          :url => stream_raw[ixace, 52],
          :extra_info => stream_raw[ixace + 52, 30].scan(/\[[a-zA-Z0-9 ]+\]/).collect{|x| x[1..-2]}.join(' ')
        }
        ix = ixace+10
      end

      streams.uniq! {|s| s[:url]}

      {
        :sport => 'NFL',
        :kickoff => kickoff,
        :title => title,
        :competition => nil,
        :streams => streams
      }

    end.select{|m| m[:streams].any? }


    puts list.inspect


    list.each do |l|
      match = Match.find_or_create_by!(sport: l[:sport], kickoff: l[:kickoff], title: l[:title]) do |m|
        m.competition = l[:competition] if l[:competition].present? && m.competition.blank?
      end

      l[:streams].each do |s|
        stream = Stream.find_or_initialize_by(match_id: match.id, url: s[:url])
        stream.extra_info = s[:extra_info] if stream.extra_info.nil? || (s[:extra_info].present? && s[:extra_info].size > stream.extra_info.size)
        stream.save!
      end
    end

  end
end
