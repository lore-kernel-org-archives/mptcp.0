Content-Type: multipart/mixed; boundary="===============4174092354776790491=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/4] mptcp: add __init annotation on setup
 functions
Date: Fri, 22 May 2020 08:46:42 -0700
Message-ID: <20200522154642.GG21533@MacBook-Pro-64.local>
In-Reply-To: fae062c473b43900d481322b02c322537e2d7da2.1590142022.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4457

--===============4174092354776790491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On 22/05/20 - 12:10:10, Paolo Abeni wrote:
> Add the missing annotation in some setup-only
> functions.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 5 +++--
>  net/mptcp/protocol.h | 9 +++++----
>  net/mptcp/subflow.c  | 2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e3a628bea2b8..16ca39ae314a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2028,7 +2028,7 @@ static struct inet_protosw mptcp_protosw =3D {
>  	.flags		=3D INET_PROTOSW_ICSK,
>  };
>  =

> -void mptcp_proto_init(void)
> +void __init mptcp_proto_init(void)
>  {
>  	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
>  =

> @@ -2037,6 +2037,7 @@ void mptcp_proto_init(void)
>  =

>  	mptcp_subflow_init();
>  	mptcp_pm_init();
> +	mptcp_token_init();
>  =

>  	if (proto_register(&mptcp_prot, 1) !=3D 0)
>  		panic("Failed to register MPTCP proto.\n");
> @@ -2089,7 +2090,7 @@ static struct inet_protosw mptcp_v6_protosw =3D {
>  	.flags		=3D INET_PROTOSW_ICSK,
>  };
>  =

> -int mptcp_proto_v6_init(void)
> +int __init mptcp_proto_v6_init(void)
>  {
>  	int err;
>  =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f5adca93e8fb..038c0237cca0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -342,7 +342,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subfl=
ow_context *subflow)
>  =

>  int mptcp_is_enabled(struct net *net);
>  bool mptcp_subflow_data_available(struct sock *sk);
> -void mptcp_subflow_init(void);
> +void __init mptcp_subflow_init(void);
>  =

>  /* called with sk socket lock held */
>  int __mptcp_subflow_connect(struct sock *sk, int ifindex,
> @@ -365,9 +365,9 @@ extern const struct inet_connection_sock_af_ops ipv4_=
specific;
>  extern const struct inet_connection_sock_af_ops ipv6_specific;
>  #endif
>  =

> -void mptcp_proto_init(void);
> +void __init mptcp_proto_init(void);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int mptcp_proto_v6_init(void);
> +int __init mptcp_proto_v6_init(void);
>  #endif
>  =

>  struct sock *mptcp_sk_clone(const struct sock *sk,
> @@ -382,6 +382,7 @@ bool mptcp_finish_join(struct sock *sk);
>  void mptcp_data_acked(struct sock *sk);
>  void mptcp_subflow_eof(struct sock *sk);
>  =

> +void __init mptcp_token_init(void);

I think you need to define the empty mptcp_token_init() as otherwise this
patch won't compile.


Christoph

--===============4174092354776790491==--
