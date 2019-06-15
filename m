Content-Type: multipart/mixed; boundary="===============8422371875595382894=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 1/2] net: mptcp: randomness improvements for
 crypto.c
Date: Sat, 15 Jun 2019 11:07:09 +0200
Message-ID: <20190615090709.wy5545fcybav4cav@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1906141507120.48543@skshiu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1384

--===============8422371875595382894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > -	return hsiphash(&combined, offsetofend(typeof(combined), dport),
> > -			&crypto_nonce_secret);
> > +			    tcp_cookie_time(), &crypto_key_secret);
> =

> tcp_cookie_time() adds a dependency on CONFIG_SYN_COOKIES. It also looks
> like tcp_cookie_time() only increments once per second, so the uniqueness=
 of
> the key (within a 1-second interval) becomes totally dependent on the
> uniqueness of the 4-tuple. I think a different seed source is needed that
> won't repeat so predictably.

Thats a good point, this means we will also need to include
net_hash_mix() into the input so we won't create same keys for identical
tuples in different network namespaces.

But, I wonder, if the key doesn't need to be recomputeable at all, then
this is just a random value to send, so two alternatives might be:

1. just use get_random_bytes
2. use prandom_u32() as additional input key instead of increment++.

--===============8422371875595382894==--
