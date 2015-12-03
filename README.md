# Adian, an OS X App.Net Interface
Adian is a community-maintained App.Net interface for OS X.

Its initial author was [App.Net!jws](http://app.net/jws)
(who happens to be @jeremy-w on GitHub).


## Under Construction
It's got a touch of the under construction right now, so you might want to
check out:

- [Nice.Social](https://nice.social), a fine browser-based client by !matigo
  that is actively under development
- [Cauldron](http://cauldron-app.herokuapp.com/), a no longer maintained
  cross-platform client by !chriscolon
- [Wedge](http://wedge.natestedman.com/), a popular but no longer maintained
  OS X client by !natesm.
- [wry](http://grailbox.com/wry/), a command-line OS X client by !hoop33


## Under the Hood: Bootstrapping as WrySquared
For bootstrap, we're piggy-backing on Wry. This allows the app to focus on
the "providing an OS X GUI" part of the problem without needing to reinvent
the "interacting with ADN" wheel.

Before you can use Adian, you'll need to install wry (`brew install wry` works)
and run `wry authorize` to log in to ADN with it.
