Content-Type: multipart/mixed; boundary="===============6071134110335930916=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 2/2] dbg
Date: Mon, 08 Jun 2020 19:13:18 +0200
Message-ID: <3fd153bfe811e88a50eba35e6e2ca391cf9e0950.camel@redhat.com>
In-Reply-To: e377f787126b17eeed52e365d76bd8004105e79d.1591615582.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4617

--===============6071134110335930916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-08 at 18:44 +0200, Paolo Abeni wrote:
> ---
>  net/core/sock.c      | 16 +---------------
>  net/mptcp/protocol.c | 23 +++++++++++++++++++++++
>  net/mptcp/protocol.h |  7 +++++++
>  net/mptcp/token.c    |  3 +++
>  4 files changed, 34 insertions(+), 15 deletions(-)
> =

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6c4acf1f0220..92030a61752b 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1776,7 +1776,7 @@ EXPORT_SYMBOL(sk_alloc);
>  /* Sockets having SOCK_RCU_FREE will call this function after one RCU
>   * grace period. This is the case for UDP sockets and TCP listeners.
>   */
> -static void __sk_destruct(struct rcu_head *head)
> +void __sk_destruct(struct rcu_head *head)
>  {
>  	struct sock *sk =3D container_of(head, struct sock, sk_rcu);
>  	struct sk_filter *filter;
> @@ -1814,20 +1814,6 @@ static void __sk_destruct(struct rcu_head *head)
>  	sk_prot_free(sk->sk_prot_creator, sk);
>  }
>  =

> -void sk_destruct(struct sock *sk)
> -{
> -	bool use_call_rcu =3D sock_flag(sk, SOCK_RCU_FREE);
> -
> -	if (rcu_access_pointer(sk->sk_reuseport_cb)) {
> -		reuseport_detach_sock(sk);
> -		use_call_rcu =3D true;
> -	}
> -
> -	if (use_call_rcu)
> -		call_rcu(&sk->sk_rcu, __sk_destruct);
> -	else
> -		__sk_destruct(&sk->sk_rcu);
> -}
>  =

>  static void __sk_free(struct sock *sk)
>  {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cbd33debea1..09e0fc91983b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2088,6 +2088,29 @@ static struct inet_protosw mptcp_protosw =3D {
>  	.flags		=3D INET_PROTOSW_ICSK,
>  };
>  =

> +void __sk_destruct(struct rcu_head *head);
> +
> +void sk_destruct(struct sock *sk)
> +{
> +	bool use_call_rcu =3D sock_flag(sk, SOCK_RCU_FREE);
> +
> +	if (rcu_access_pointer(sk->sk_reuseport_cb)) {
> +		reuseport_detach_sock(sk);
> +		use_call_rcu =3D true;
> +	}
> +
> +	if (sk->sk_prot =3D=3D &mptcp_prot) {
> +		struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +		msk->add_nr =3D stack_trace_save(msk->add_store, STORE_LEN, 1);
> +	}
> +
> +	if (use_call_rcu)
> +		call_rcu(&sk->sk_rcu, __sk_destruct);
> +	else
> +		__sk_destruct(&sk->sk_rcu);
> +}
> +
>  #if IS_ENABLED(CONFIG_KASAN)
>  #define MPTCP_USE_SLAB		0
>  #else
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6322c4e2d07c..912525b677c6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -210,6 +210,13 @@ struct mptcp_sock {
>  	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
>  	struct sock	*first;
>  	struct mptcp_pm_data	pm;
> +
> +#define STORE_LEN		16
> +	long		add_store[STORE_LEN];
> +	int		add_nr;
> +	bool		connect;
> +	bool		accept;
> +	int		del_nr;
>  };
>  =

>  #define mptcp_for_each_subflow(__msk, __subflow)			\
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 8acea188323c..fae4f4724f2a 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -167,6 +167,7 @@ int mptcp_token_new_connect(struct sock *sk)
>  	WRITE_ONCE(msk->token, subflow->token);
>  	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
>  	bucket->chain_len++;
> +	msk->connect =3D true;
>  	spin_unlock_bh(&bucket->lock);
>  	return 0;
>  }
> @@ -193,6 +194,7 @@ void mptcp_token_accept(struct mptcp_subflow_request_=
sock *req,
>  	if (!WARN_ON_ONCE(pos !=3D req))
>  		hlist_nulls_del_init_rcu(&req->token_node);
>  	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
> +	msk->accept =3D true;
>  	spin_unlock_bh(&bucket->lock);
>  }
>  =

> @@ -285,6 +287,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk)
>  		__sk_nulls_del_node_init_rcu((struct sock *)pos);
>  		bucket->chain_len--;
>  	}
> +	msk->del_nr++;
>  	spin_unlock_bh(&bucket->lock);
>  }
>  =


For the records: this horrible crap was not supposed to be here.
-ENOCOFFEE :(

Will send a v2 hopefully comprising the correct code.

Sorry for the noise.

/P

--===============6071134110335930916==--
