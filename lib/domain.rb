require 'whois'
require 'resolv'
require 'socket'

class Domain

  attr_reader :dom, :error
  attr_reader :available, :registered, :created, :updated, :expires
  attr_reader :nameservers, :tech_name, :tech_email, :tech_id, :reg_name
  attr_reader :reg_email, :reg_id, :admin_name, :admin_email, :admin_id
  attr_reader :A, :MX, :NS, :www, :PTR
  
  def initialize(domain)
    @domain   = domain
    @error = ''
    self.whois
    self.dns if @registered
  end

  def iterate(arr)
    msg = ''
    i   = 0
    while i < arr.split(', ').count
      if i == 0
        msg << "#{arr.split(', ')[i]}\n"
      else
        msg << "                                 #{arr.split(', ')[i]}\n"
      end
      i += 1
    end
    return msg
  end

  def info
    return @error if @error != ''
    msg = ''
    msg << "WHOIS Information\n"
    msg << "    Domain:                      #@domain\n"
    msg << "    Available:                   #@available\n"
    msg << "    Registered:                  #@registered\n"
    msg << "    Created:                     #@created\n" if @registered
    msg << "    Updated:                     #@updated\n" if @registered
    msg << "    Expires:                     #@expires\n" if @registered
    msg << "    Nameservers:                 #{iterate(@nameservers)}" if @registered
    msg << "    Technical Contact Name:      #@tech_name\n" if @registered
    msg << "    Technical Contact Email:     #@tech_email\n" if @registered
    msg << "    Registrant Contact Name:     #@reg_name\n" if @registered
    msg << "    Registrant Contact Email:    #@reg_email\n" if @registered
    msg << "    Admin Contact Name:          #@admin_name\n" if @registered
    msg << "    Admin Contact Email:         #@admin_email\n" if @registered
    msg << "DNS Information\n" if @registered
    msg << "    A Records:                   #{iterate(@A)}" if @registered
    msg << "    MX Records:                  #{iterate(@MX)}" if @registered
    msg << "    NS Records:                  #{iterate(@NS)}" if @registered
    msg << "    www resolves to:             #{iterate(@www)}" if @registered
    msg << "    PTR Informaation:            #{iterate(@PTR)}" if @registered
    return msg
  end

  def whois
    begin
      @w           = Whois::Client.new(:timeout => 10)
      @lookup      = Whois.whois(@domain)
      @available   = @lookup.available?
      @registered  = @lookup.registered?
      @created     = @lookup.created_on
      @updated     = @lookup.updated_on
      @expires     = @lookup.expires_on
      @nameservers = (@registered ? @lookup.nameservers.map{|n,i4,i6| n}.join(', ') : '')
      @technical   = (@registered ? @lookup.technical_contact : '')
      @tech_name   = (@registered ? @technical.name : '')
      @tech_email  = (@registered ? @technical.email : '')
      @tech_id     = (@registered ? @technical.id : '')
      @registrant  = (@registered ? @lookup.registrant_contact : '')
      @reg_name    = (@registered ? @registrant.name : '')
      @reg_email   = (@registered ? @registrant.email : '')
      @reg_id      = (@registered ? @registrant.id : '')
      @admin       = (@registered ? @lookup.admin_contact : '')
      @admin_name  = (@registered ? @admin.name : '')
      @admin_email = (@registered ? @admin.email : '')
      @admin_id    = (@registered ? @admin.id : '')
    rescue Whois::ServerNotFound
      @error = "No WHOIS server found for #@domain"
    rescue Whois::NoInterfaceError
      @error = "No WHOIS server found for #@domain"
    rescue Whois::ConnectionError
      @error = "WHOIS server timed out or refused query for #@domain"
    end
  end

  def dns
    Resolv::DNS.open do |d|
      @A   = d.getresources(@domain, Resolv::DNS::Resource::IN::A).map{|a| a.address}.join(', ')
      @MX  = d.getresources(@domain, Resolv::DNS::Resource::IN::MX).map{|a| "#{a.exchange} [#{Resolv.getaddress a.exchange.to_s}] (#{a.preference})"}.join(', ')
      @NS  = d.getresources(@domain, Resolv::DNS::Resource::IN::NS).map{|a| "#{a.name} (#{Resolv.getaddress a.name.to_s})"}.join(', ')
      @www = d.getresources("www.#@domain", Resolv::DNS::Resource::IN::A).map{|a| a.address}.join(', ')
      @PTR = @A.split(', ').map{|a| "#{a}=>#{Resolv.getname a}"}.join(', ')
    end
  end

end
