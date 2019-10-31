Content-Type: multipart/mixed; boundary="===============8739350283242751618=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 6/6] mptcp: Add IPv6 support
Date: Thu, 31 Oct 2019 13:32:38 +0100
Message-ID: <1ac6f933dbbd1f27b190adb9e8b78bc268c6f44f.camel@redhat.com>
In-Reply-To: 20191030233844.4790-7-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2374

--===============8739350283242751618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello Peter!

On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
> Mimic hooks and option handling for IPv6 as was done for
> IPv4 MPTCP sockets.
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  include/net/mptcp.h  |   3 ++
>  net/ipv6/tcp_ipv6.c  |   7 +++
>  net/mptcp/ctrl.c     |  11 +++++
>  net/mptcp/protocol.c |  85 ++++++++++++++++++++++++++++++++--
>  net/mptcp/protocol.h |   3 ++
>  net/mptcp/subflow.c  | 107 ++++++++++++++++++++++++++++++++++++++++++-
>  6 files changed, 209 insertions(+), 7 deletions(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index eba39a881767..41225c50aebb 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -53,6 +53,9 @@ struct mptcp_out_options {
>  #ifdef CONFIG_MPTCP
>  =

>  void mptcp_init(void);
> +#if IS_ENABLED(CONFIG_IPV6)
> +int mptcpv6_init(void);
> +#endif


I didn't see a stub version of mptcpv6_init(),
 =

>  static inline bool sk_is_mptcp(const struct sock *sk)
>  {
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 50f6f21bbdb1..10d1c033d458 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2109,9 +2109,16 @@ int __init tcpv6_init(void)
>  	ret =3D register_pernet_subsys(&tcpv6_net_ops);
>  	if (ret)
>  		goto out_tcpv6_protosw;
> +
> +	ret =3D mptcpv6_init();
> +	if (ret)
> +		goto out_tcpv6_pernet_subsys;
> +
>  out:
>  	return ret;

so probably the above hunk will cause build problems when CONFIG_MPTCP is
unset. Am I missing something?

thanks!
-- =

davide

--===============8739350283242751618==--
