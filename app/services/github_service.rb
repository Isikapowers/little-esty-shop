class GithubService

  def get_data(url)
    response = Faraday.get("https://api.github.com/repos/isikapowers/little-esty-shop#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def pulls
    get_data("/pulls?state=closed&per_page=100")
  end

  def name
    get_data("")
  end

  def contributors
    user_hash = {}
    data = get_data("/contributors")
    data.each do |hash|
      user_hash[hash[:login]] = hash[:contributions]
    end
    user_hash.delete("BrianZanti")
    user_hash.delete("timomitchel")
    user_hash.delete("scottalexandra")
    user_hash.delete("jamisonordway")
    user_hash
  end

  def get_all
    result = {name: name, pulls: pulls, contributors: contributors}
  end
end
