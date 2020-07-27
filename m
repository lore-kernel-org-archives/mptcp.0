Content-Type: multipart/mixed; boundary="===============4096302293138654169=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 09/11] tcp: handle want_cookie clause via
 reqsk_put
Date: Tue, 28 Jul 2020 01:00:52 +0200
Message-ID: <20200727230052.GN23458@breakpoint.cc>
In-Reply-To: 962243569496bee88d74b854549d853ca9a1a726.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5332

--===============4096302293138654169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2020-07-27 at 11:00 +0200, Florian Westphal wrote:
> > Would need to duplicate timeout logic and so on which I wanted to
> > avoid.
> =

> Yep that would be quite complex. I was wondering about something
> simpler, like using with LRU policy a static 4 slots circular buffer
> inside the msk (the one identified by the token). WDYT?

But where do I get the token to find the msk from the cookie ack?
Its not re-sent in the options afaics, unlike mp_capable case.
--===============4096302293138654169==--
