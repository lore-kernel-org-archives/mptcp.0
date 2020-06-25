Content-Type: multipart/mixed; boundary="===============2583014914535196752=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3 0/3] setsockopt: allow reuseport and
 ip6only
Date: Thu, 25 Jun 2020 10:59:40 +0200
Message-ID: <67ee87c768b20504453f443fe92df60e64068a98.camel@redhat.com>
In-Reply-To: 20200624224608.GX26990@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4795

--===============2583014914535196752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-25 at 00:46 +0200, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > On Wed, 24 Jun 2020, Florian Westphal wrote:
> > =

> > > 3rd iteration.  I've incorporated feedback from Mat, so for
> > > options other than reuseport/reuseaddr the generic handler gets called
> > > instead of returning -EOPNOTSUPP.
> > > =

> > > I've tested that ssh restart works on a a modified kernel that
> > > enables mptcp for all IPPROTO_TCP sockets.
> > =

> > Thanks for the v3 updates, changes look good. Should the patches go to =
the
> > mptcp repo for some more test coverage or are you intending to post for
> > net-next soon?
> =

> The former, they depend on Paolos fallback refactoring which isn't in
> net-next yet afaics.

I'd like to spool the token refactor first, which in turn will cause
conflict without "mptcp: drop MP_JOIN request sock on syn cookies" -
currently on -net only.

I'll ask Dave for a -net -> -net-next merge, so we can start spooling
stuff.

Cheers,

Paolo

--===============2583014914535196752==--
