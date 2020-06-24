Content-Type: multipart/mixed; boundary="===============6841514723501230976=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3 0/3] setsockopt: allow reuseport and
 ip6only
Date: Thu, 25 Jun 2020 00:46:08 +0200
Message-ID: <20200624224608.GX26990@breakpoint.cc>
In-Reply-To: alpine.OSX.2.23.453.2006241502290.39721@adesai3-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4791

--===============6841514723501230976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> =

> On Wed, 24 Jun 2020, Florian Westphal wrote:
> =

> > 3rd iteration.  I've incorporated feedback from Mat, so for
> > options other than reuseport/reuseaddr the generic handler gets called
> > instead of returning -EOPNOTSUPP.
> > =

> > I've tested that ssh restart works on a a modified kernel that
> > enables mptcp for all IPPROTO_TCP sockets.
> =

> Thanks for the v3 updates, changes look good. Should the patches go to the
> mptcp repo for some more test coverage or are you intending to post for
> net-next soon?

The former, they depend on Paolos fallback refactoring which isn't in
net-next yet afaics.
--===============6841514723501230976==--
