class Match < ApplicationRecord
  has_many :streams

  validates :sport, :kickoff, :title, presence: true

  def as_json(arg)
    {
        :sport => self.sport,
        :kickoff => self.kickoff.to_i,
        :competition => self.competition,
        :title => self.title,
        :streams => self.streams.collect{|s| {url: s.url, extra_info: s.extra_info}}
    }
  end
end
