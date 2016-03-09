require 'net/http'
require 'json'
i=0 
stop = false
states = []
while(stop == false) do
	url = "https://data.gov.in/api/datastore/resource.json?resource_id=e16c75b6-7ee6-4ade-8e1f-2cd3043ff4c9&api-key=5f50a64949e68cf3fa3eadb5b1310d81&fields=state&offset=#{i}&limit=100"
	uri = URI(url)
	response = Net::HTTP.get(uri)
	result =  JSON.parse(response)
	puts i
	result['records'].uniq.each{|v|
	  states << v['state']
	}	
	puts states.uniq
	stop = result['count'] < 100
	i += 1
end	
puts states.uniq.count
File.open("states.json","w") do |f|
  f.write(states.uniq.sort.to_json)
end
	
	
