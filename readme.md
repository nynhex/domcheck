# DomCheck

## Description

Does WHOIS and DNS checks using [Ruby Whois] (https://whoisrb.org/) and [Resolv::DNS] (http://ruby-doc.org/stdlib-2.1.0/libdoc/resolv/rdoc/Resolv/DNS.html)

## How to install

- `git clone git@github.com:reyloc/domcheck.git` OR `git clone https://github.com/reyloc/domcheck.git`
- `cd domcheck`
- `bundle install`

## Usage

#### Using the bin/domcheck file
```
[reyloc@localhost ~] domcheck/bin/domcheck reyloc.com
WHOIS Information
    Domain:                      reyloc.com
    Available:                   false
    Registered:                  true
    Created:                     2013-08-11 08:40:10 UTC
    Updated:                     2015-11-26 05:23:53 UTC
    Expires:                     2017-08-11 08:40:10 UTC
    Nameservers:                 NS1.REYLOC.ORG
                                 NS2.REYLOC.ORG
    Technical Contact Name:      Jason Colyer
    Technical Contact Email:     jcolyer2007@yahoo.com
    Registrant Contact Name:     Jason Colyer
    Registrant Contact Email:    jcolyer2007@yahoo.com
    Admin Contact Name:          Jason Colyer
    Admin Contact Email:         jcolyer2007@yahoo.com
DNS Information
    A Records:                   159.203.94.18
    MX Records:                  mail.reyloc.org [45.55.41.134] (0)
    NS Records:                  ns2.reyloc.org (45.55.185.212)
                                 ns1.reyloc.org (104.236.243.147)
    www resolves to:             159.203.94.18
    PTR Informaation:            159.203.94.18=>web1.reyloc.org
```
#### Using the class from lib/domain.rb
```
2.1.1 :001 > require_relative 'domcheck/lib/domain'
 => true
2.1.1 :002 > domain = Domain.new('reyloc.com')
 => #<Domain:0x000000036574c8 @dom="reyloc.com", @error="", @w=#<Whois::Client:0x00000003657450 @timeout=10, @settings={}>, @available=false, @registered=true, @created=2013-08-11 08:40:10 UTC, @updated=2015-11-26 05:23:53 UTC, @expires=2017-08-11 08:40:10 UTC, @nameservers="NS1.REYLOC.ORG, NS2.REYLOC.ORG", @tech_name="Jason Colyer", @tech_email="jcolyer2007@yahoo.com", @tech_id=nil, @reg_name="Jason Colyer", @reg_email="jcolyer2007@yahoo.com", @reg_id=nil, @admin_name="Jason Colyer", @admin_email="jcolyer2007@yahoo.com", @admin_id=nil, @A="159.203.94.18", @MX="mail.reyloc.org [45.55.41.134] (0)", @NS="ns2.reyloc.org (45.55.185.212), ns1.reyloc.org (104.236.243.147)", @www="159.203.94.18", @PTR="159.203.94.18=>web1.reyloc.org">
2.1.1 :003 > domain.A
 => "159.203.94.18"
2.1.1 :004 > domain.admin_name
 => "Jason Colyer"
2.1.1 :005 > puts domain.info
WHOIS Information
    Domain:                      reyloc.com
    Available:                   false
    Registered:                  true
    Created:                     2013-08-11 08:40:10 UTC
    Updated:                     2015-11-26 05:23:53 UTC
    Expires:                     2017-08-11 08:40:10 UTC
    Nameservers:                 NS1.REYLOC.ORG
                                 NS2.REYLOC.ORG
    Technical Contact Name:      Jason Colyer
    Technical Contact Email:     jcolyer2007@yahoo.com
    Registrant Contact Name:     Jason Colyer
    Registrant Contact Email:    jcolyer2007@yahoo.com
    Admin Contact Name:          Jason Colyer
    Admin Contact Email:         jcolyer2007@yahoo.com
DNS Information
    A Records:                   159.203.94.18
    MX Records:                  mail.reyloc.org [45.55.41.134] (0)
    NS Records:                  ns2.reyloc.org (45.55.185.212)
                                 ns1.reyloc.org (104.236.243.147)
    www resolves to:             159.203.94.18
    PTR Informaation:            159.203.94.18=>web1.reyloc.org
 => nil
```
