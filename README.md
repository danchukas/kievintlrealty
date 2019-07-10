# kievintlrealty
Task's description is here:
https://github.com/danchukas/kievintlrealty/blob/master/TaskDescription.txt

It is link for run application:
http://localhost:180/

## load-tests by ab on local machine:

ab -k -c 1000 -n 10000 http://localhost:180/34f485e8a75f8b0c3f913c457d9e2ad5
Requests per second:    4030.51 [#/sec] (mean)

ab -k -c 1000 -n 10000 http://localhost:180/generate/?url=http%3A%2F%2Fgoogle.com
Requests per second:    3908.17 [#/sec] (mean)

## For scaling we need:
- generated "url_key" must contain identifier of it's handler server
- for use shorten url: up servers which parse "url_key" and redirect to handle server 
- for generate shorten url: up servers which categorise "url" and redirect to handle server which handle this type of urls (by domain, by url length, ...)  
- up main load balancers for above 2 types of servers 
- add load balancers to DNS 
- Amazon EC2 Auto Scaling or similar solution

## Other thinks
For increase performance we need:
- add cache servers
- every type of requests (I mean getting html form too) we can divide with separate projects and independent tune in them.

For user loyalty:
- add error failovers

For filter possible spam traffic
- add checking of input data
