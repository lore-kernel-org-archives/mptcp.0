Content-Type: multipart/mixed; boundary="===============1450083725431325082=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Mon, 20 Aug 2018 22:43:40 -0700
Message-ID: <20180821054340.GF1428@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1808201744480.15643@sriyenga-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 707

--===============1450083725431325082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20/08/18 - 17:47:10, Mat Martineau wrote:
> =

> On Mon, 20 Aug 2018, Christoph Paasch wrote:
> =

> > Two forward-ports coming from mptcp_trunk.
> > =

> > Gregory Detal (1):
> >  mptcp: correct refcnt for sk in tcp_v{4,6}_rcv
> > =

> > Matthieu Baerts (1):
> >  mptcp:minisocks: fix refcnt when adding to backlog
> > =

> > include/net/mptcp.h      |  2 ++
> > net/ipv4/tcp_ipv4.c      |  2 +-
> > net/ipv4/tcp_minisocks.c |  2 +-
> > net/ipv6/tcp_ipv6.c      |  2 +-
> > net/mptcp/mptcp_ctrl.c   | 18 ++++++++++++++++--
> > 5 files changed, 21 insertions(+), 5 deletions(-)
> =

> Both applied.

Cool!

> =

> Is https://github.com/multipath-tcp/mptcp_net-next/blob/master/net/ipv4/t=
cp_ipv4.c#L1822
> another place that mptcp_prepare_for_backlog() should be used?

In principle yes, but we didn't put this in mptcp_trunk, because this has
already the lockless subflow establishment patches that I still need to
forward-port to the net-next branch.


Christoph


--===============1450083725431325082==--
