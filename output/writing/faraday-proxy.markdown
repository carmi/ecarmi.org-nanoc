I like verbose logs. If I'm working with a service that ultimately communicates via HTTP, I like seeing the raw HTTP logs. I very often run a proxy in devlopment to look at raw HTTP traffic. Something like [Charles](http://www.charlesproxy.com/) is easy to use for browser traffic. However, when you want to pass the traffic of a Ruby HTTP client through your proxy you need to do a bit of hacking. The normal method is to overwrite the `def connection` definition with a monkey patch where the client sets up an HTTP connection. [Something like this.](http://stackoverflow.com/questions/11948656/omniauth-google-faraday-behind-the-proxy-how-setup-proxy/11953745#11953745)

But I wanted a solution that was more general and didn't require knowing about the client talking to Faraday. I also didn't want to monkey patch the entire `Faraday::Connection` class. So I wrote up a little monkey patch that wraps the Faraday::Connection `initialize` method injecting in your proxy settings. If you toss this code into your app (if it's a Rails app in an initializer) then all Faraday connections should go through your proxy. Cool!


~~~ ruby
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Faraday
  class Connection
    alias_method :old_initialize, :initialize

    def initialize(url = nil, options = {})
      proxy = 'http://127.0.0.1:3128'
      (url.is_a?(Hash) ? url : options).merge!(proxy: proxy)

      old_initialize(url, options)
    end
  end
end
~~~


Change line 8 to be whatever path and port your proxy is running on.

You should get a SSL verification error if you are making HTTPS calls to external services. You can disable this SSL verification during debugging with line 1.
