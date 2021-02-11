Content-Type: multipart/mixed; boundary="===============1668374378606477191=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: dispose initial struct socket when its
 subflow is closed
Date: Thu, 11 Feb 2021 19:20:04 +0100
Message-ID: <20210211182004.GB2766@breakpoint.cc>
In-Reply-To: 20210211162607.10780-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7757

--===============1668374378606477191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> wrote:
> Christoph Paasch reported following crash:
> dst_release underflow
> WARNING: CPU: 0 PID: 1319 at net/core/dst.c:175 dst_release+0xc1/0xd0 net=
/core/dst.c:175
> CPU: 0 PID: 1319 Comm: syz-executor217 Not tainted 5.11.0-rc6af8e85128b4d=
0d24083c5cac646e891227052e0c #70
> Call Trace:
>  rt_cache_route+0x12e/0x140 net/ipv4/route.c:1503
>  rt_set_nexthop.constprop.0+0x1fc/0x590 net/ipv4/route.c:1612
>  __mkroute_output net/ipv4/route.c:2484 [inline]
> ...
> =

> Problem is that worker leaves msk->subflow alone even when it
> happened to close the subflow ssk associated with it.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/157
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d49e0efbdd50..c30dff10ed9a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2106,6 +2106,14 @@ static struct sock *mptcp_subflow_get_retrans(cons=
t struct mptcp_sock *msk)
>  	return backup;
>  }
>  =

> +static void mptcp_dispose_initial_subflowg(struct mptcp_sock *msk)
> +{

Grrr.  This should be 'mptcp_dispose_initial_subflow'.

Also note that msk->first also needs treatment, but I'd do that
in another patch.
--===============1668374378606477191==--
