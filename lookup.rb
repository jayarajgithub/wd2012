def get_command_line_argument
    # ARGV is an array that Ruby defines for us,
    # which contains all the arguments we passed to it
    # when invoking the script from the command line.
    # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
    if ARGV.empty?
      puts "Usage: ruby lookup.rb <domain>"
      exit
    end
    ARGV.first
  end
  
  # `domain` contains the domain name we have to look up.
  domain = get_command_line_argument
  
  # File.readlines reads a file and returns an
  # array of string, where each element is a line
  # https://www.rubydoc.info/stdlib/core/IO:readlines
  dns_raw = File.readlines("zone")
  
  # ..
  # ..
  # FILL YOUR CODE HERE
  # ..
  # ..


  #my_string = "abcdefg"

  def parse_dns(dns_string)    
    dns_string = dns_string.map(&:strip).delete_if { |string| string.length == 0 }
    
    dns_string=dns_string[1..-1]
    array=Array.new(5) {Array.new(3) }
    inp=[]
    i=0
    while i < 5
    inp=dns_string[x].strip.split(",")
      j=0
      while j < 3
        array[i][j]=inp[j].strip
      end
    end
  dns_record= Hash[array.map { |key,d1,d2| [d1,{:type=>key,:target=>d2}]}]
 end


def resolve(dns_records,lookup_chain,domain_name)
  record=dns_records[domain_name]
  if !(record)
    lookup_chain=[]
    displayerror1 = "Error: record not found for "+ domain_name
    lookup_chain.push(displayerror1)
  elsif record[:type]=="A"
    lookup_chain.push(record[:target])
  elsif record[:type]=="CNAME"
    lookup_chain.push(record[:target])
    resolve(dns_records,lookup_chain,record[:target])
  else
    displayerror2 = "Invalid record type for " + domain_name
    lookup_chain.push(displayerror2)
  end
end


 
  
  # To complete the assignment, implement `parse_dns` and `resolve`.
  # Remember to implement them above this line since in Ruby
  # you can invoke a function only after it is defined.
  dns_records = parse_dns(dns_raw)
  lookup_chain = [domain]
  lookup_chain = resolve(dns_records, lookup_chain, domain)
  puts lookup_chain.join(" => ")