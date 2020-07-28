Content-Type: multipart/mixed; boundary="===============6423267071915479092=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 09/11] tcp: handle want_cookie clause via
 reqsk_put
Date: Tue, 28 Jul 2020 13:51:37 +0200
Message-ID: <7baf4fd642790314afd5c4a5624003e41e620eb6.camel@redhat.com>
In-Reply-To: 20200727230052.GN23458@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5340

--===============6423267071915479092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-07-28 at 01:00 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Mon, 2020-07-27 at 11:00 +0200, Florian Westphal wrote:
> > > Would need to duplicate timeout logic and so on which I wanted to
> > > avoid.
> > =

> > Yep that would be quite complex. I was wondering about something
> > simpler, like using with LRU policy a static 4 slots circular buffer
> > inside the msk (the one identified by the token). WDYT?
> =

> But where do I get the token to find the msk from the cookie ack?
> Its not re-sent in the options afaics, unlike mp_capable case.

uhm... wasting even more memory we could store in each slot hmac and
token (24 bytes per slot)

MPJ ACK with syncookie we could lookup the slot by hmac.

Not sure about the security implications.

Sounds too overkill?

/P


--===============6423267071915479092==--
