Content-Type: multipart/mixed; boundary="===============6642982799905938785=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] net/mptcp: rcu-ify the subflow context
Date: Fri, 13 Sep 2019 17:54:13 +0200
Message-ID: <529de6ddb5b240acb2c62067e1ea93a8b6188ef2.camel@redhat.com>
In-Reply-To: 424f2707dffedc2a74abfb5d15bc0a1f6f01e477.1567437714.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1846

--===============6642982799905938785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-02 at 17:24 +0200, Davide Caratti wrote:
> make sure to wait a grace period before freeing the subflow context. See
> also net-next commit 72f21c741e86 ("net/tls: use RCU protection on
> icsk->icsk_ulp_data")
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> =

> Notes:
>     proposal: we can squash this in
>     =

>     commit d636603cad37 ("mptcp: Implement MPTCP receive path")
>     =

>     and the last hunk can go into
>     =

>     commit 0e0b608d46c5 ("mptcp: Associate MPTCP context with TCP socket")
> =

>  net/mptcp/protocol.h |  5 +++--
>  net/mptcp/subflow.c  | 10 +++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 991ad288b892..b201e1410219 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -197,13 +197,14 @@ struct subflow_context {
>  	struct  sock *conn;        /* parent mptcp_sock */
>  =

>  	void	(*tcp_sk_data_ready)(struct sock *sk);
> +	struct	rcu_head rcu;
>  };
>  =

>  static inline struct subflow_context *subflow_ctx(const struct sock *sk)
>  {
>  	struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -	return (struct subflow_context *)icsk->icsk_ulp_data;
> +	/* Use RCU on icsk_ulp_data only for sock diag code */
> +	return (__force struct subflow_context *)icsk->icsk_ulp_data;
>  }
>  =

>  static inline struct socket *

The patch looks fine, but I'm still wondering if we should try to be
more conservative here, using something alike:

	return rcu_dereference_protected(icsk->icsk_ulp_data,
		lockdep_sock_is_held((struct sock *)icsk))

and fixing the eventual lockdep splat explcitily

(possibly we may need a different/additional condition for
rcu_dereference_protected() based  on icsk refcnt)

Paolo


--===============6642982799905938785==--
