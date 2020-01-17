Content-Type: multipart/mixed; boundary="===============4960341824179437516=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix compilation warning
Date: Fri, 17 Jan 2020 18:16:07 +0100
Message-ID: <acb4062b2baf89c715c4409d7a5fedbd16015911.camel@redhat.com>
In-Reply-To: 20200117165631.1329562-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3401

--===============4960341824179437516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-17 at 17:56 +0100, Matthieu Baerts wrote:
> After having applied 77c6b6aec34b (mptcp: handle ipv4-mapped ipv6 address=
.),
> we have this warning:
> =

>   net/ipv6/tcp_ipv6.c: In function =E2=80=98tcp_v6_syn_recv_sock=E2=80=99:
>   net/ipv6/tcp_ipv6.c:1211:29: warning: passing argument 1 of =E2=80=98mp=
tcp_handle_ipv6_mapped=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier =
from pointer target type [-Wdiscarded-qualifiers]
>    1211 |    mptcp_handle_ipv6_mapped(sk, true);
>         |                             ^~
>   In file included from ./include/net/tcp.h:42,
>                    from net/ipv6/tcp_ipv6.c:44:
>   ./include/net/mptcp.h:201:44: note: expected =E2=80=98struct sock *=E2=
=80=99 but argument is of type =E2=80=98const struct sock *=E2=80=99
>     201 | void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
>         |                               ~~~~~~~~~~~~~^~
> =

> Simply fixed by passing some arguments to 'const'.
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: Handle MP_CAPABLE options for outgoing conn=
ections"
> =

>  include/net/mptcp.h | 2 +-
>  net/mptcp/subflow.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index eabc57c3fde4..d9214f4387c3 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -162,7 +162,7 @@ static inline bool mptcp_skb_can_collapse(const struc=
t sk_buff *to,
>  =

>  #endif /* CONFIG_MPTCP */
>  =

> -void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
> +void mptcp_handle_ipv6_mapped(const struct sock *sk, bool mapped);
>  =

>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  int mptcpv6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1eff992a43dc..2525da9d28c9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -165,7 +165,7 @@ static int subflow_v6_conn_request(struct sock *sk, s=
truct sk_buff *skb)
>  #endif
>  =

>  static struct inet_connection_sock_af_ops *
> -subflow_default_af_ops(struct sock *sk)
> +subflow_default_af_ops(const struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	if (sk->sk_family =3D=3D AF_INET6)
> @@ -174,7 +174,7 @@ subflow_default_af_ops(struct sock *sk)
>  	return &subflow_specific;
>  }
>  =

> -void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped)
> +void mptcp_handle_ipv6_mapped(const struct sock *sk, bool mapped)
>  {
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);


Uhmm..

I think the correct fix is replacing in the call-side:

	mptcp_handle_ipv6_mapped(sk, true);

with:

	mptcp_handle_ipv6_mapped(newsk, true);

(the current code passes the wrong argument to the mptcp helper)

Cheers,

Paolo

--===============4960341824179437516==--
