Content-Type: multipart/mixed; boundary="===============3713608551167649849=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Mon, 20 Aug 2018 17:47:10 -0700
Message-ID: <alpine.OSX.2.21.1808201744480.15643@sriyenga-mobl.amr.corp.intel.com>
In-Reply-To: 20180820155219.16681-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 706

--===============3713608551167649849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 20 Aug 2018, Christoph Paasch wrote:

> Two forward-ports coming from mptcp_trunk.
>
> Gregory Detal (1):
>  mptcp: correct refcnt for sk in tcp_v{4,6}_rcv
>
> Matthieu Baerts (1):
>  mptcp:minisocks: fix refcnt when adding to backlog
>
> include/net/mptcp.h      |  2 ++
> net/ipv4/tcp_ipv4.c      |  2 +-
> net/ipv4/tcp_minisocks.c |  2 +-
> net/ipv6/tcp_ipv6.c      |  2 +-
> net/mptcp/mptcp_ctrl.c   | 18 ++++++++++++++++--
> 5 files changed, 21 insertions(+), 5 deletions(-)

Both applied.

Is =

https://github.com/multipath-tcp/mptcp_net-next/blob/master/net/ipv4/tcp_ip=
v4.c#L1822 =

another place that mptcp_prepare_for_backlog() should be used?

--
Mat Martineau
Intel OTC

--===============3713608551167649849==--
