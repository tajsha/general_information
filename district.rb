require 'net/http'
require 'json'
i=0 
stop = false
districts = {}
while(stop == false) do
	url = "https://data.gov.in/api/datastore/resource.json?resource_id=e16c75b6-7ee6-4ade-8e1f-2cd3043ff4c9&api-key=5f50a64949e68cf3fa3eadb5b1310d81&fields=state,district&offset=#{i}&limit=100"
	uri = URI(url)
	response = Net::HTTP.get(uri)
	result =  JSON.parse(response)
	puts i
	result['records'].uniq.each{|v|
	  if districts[v['state']].nil?
	    districts[v['state']] = []
	  end
	  if ((districts.include? v['district']) == false) and v['district'] != 'NA'
	    puts v['district']
		districts[v['state']] << v['district']
	  end	
	   	
	}	
	stop = result['count'] < 100
	i += 1
end	
districts.each{|k, v|
 districts[k] = v.sort.uniq 
}
puts districts.inspect
File.open("districts.json","w") do |f|
  f.write(Hash[districts.sort_by { |k,v| k }].to_json)
end
	
	
