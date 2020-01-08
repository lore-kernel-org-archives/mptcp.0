Content-Type: multipart/mixed; boundary="===============4875680067435425592=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v6 05/11] tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Wed, 08 Jan 2020 08:04:53 -0800
Message-ID: <7df4cdc2-37fe-e724-a2e8-829b6920e9c6@gmail.com>
In-Reply-To: 20200108011921.28942-6-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3297

--===============4875680067435425592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 1/7/20 5:19 PM, Mat Martineau wrote:
> If ULP is used on a listening socket, icsk_ulp_ops and icsk_ulp_data are
> copied when the listener is cloned. Sometimes the clone is immediately
> deleted, which will invoke the release op on the clone and likely
> corrupt the listening socket's icsk_ulp_data.
> =

> The clone operation is invoked immediately after the clone is copied and
> gives the ULP type an opportunity to set up the clone socket and its
> icsk_ulp_data.
> =

> The MPTCP ULP clone will silently fallback to plain TCP on allocation
> failure, so 'clone()' does not need to return an error code.
> =

> v5 -> v6:
>  - clarified MPTCP clone usage in commit message
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  include/net/tcp.h               |  5 +++++
>  net/ipv4/inet_connection_sock.c |  2 ++
>  net/ipv4/tcp_ulp.c              | 12 ++++++++++++
>  3 files changed, 19 insertions(+)
> =

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 85f1d7ff6e8b..82879718d35a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2154,6 +2154,9 @@ struct tcp_ulp_ops {
>  	/* diagnostic */
>  	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
>  	size_t (*get_info_size)(const struct sock *sk);
> +	/* clone ulp */
> +	void (*clone)(const struct request_sock *req, struct sock *newsk,
> +		      const gfp_t priority);
>  =

>  	char		name[TCP_ULP_NAME_MAX];
>  	struct module	*owner;
> @@ -2164,6 +2167,8 @@ int tcp_set_ulp(struct sock *sk, const char *name);
>  void tcp_get_available_ulp(char *buf, size_t len);
>  void tcp_cleanup_ulp(struct sock *sk);
>  void tcp_update_ulp(struct sock *sk, struct proto *p);
> +void tcp_clone_ulp(const struct request_sock *req,
> +		   struct sock *newsk, const gfp_t priority);


Maybe not needed, see below.

>  =

>  #define MODULE_ALIAS_TCP_ULP(name)				\
>  	__MODULE_INFO(alias, alias_userspace, name);		\
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 18c0d5bffe12..bf53a722923a 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -810,6 +810,8 @@ struct sock *inet_csk_clone_lock(const struct sock *s=
k,
>  		/* Deinitialize accept_queue to trap illegal accesses. */
>  		memset(&newicsk->icsk_accept_queue, 0, sizeof(newicsk->icsk_accept_que=
ue));
>  =

> +		tcp_clone_ulp(req, newsk, priority);

Since inet_csk_clone_lock() is also used by dccp, I would suggest renaming
this helper to inet_clone_ulp() ?

> +
>  		security_inet_csk_clone(newsk, req);
>  	}
>  	return newsk;
> diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
> index 12ab5db2b71c..e7a2589d69ee 100644
> --- a/net/ipv4/tcp_ulp.c
> +++ b/net/ipv4/tcp_ulp.c
> @@ -130,6 +130,18 @@ void tcp_cleanup_ulp(struct sock *sk)
>  	icsk->icsk_ulp_ops =3D NULL;
>  }
>  =

> +void tcp_clone_ulp(const struct request_sock *req, struct sock *newsk,
> +		   const gfp_t priority)
> +{
> +	struct inet_connection_sock *icsk =3D inet_csk(newsk);
> +
> +	if (!icsk->icsk_ulp_ops)
> +		return;
> +
> +	if (icsk->icsk_ulp_ops->clone)
> +		icsk->icsk_ulp_ops->clone(req, newsk, priority);
> +}
> +

Unless I am mistaken, this is only used from  inet_csk_clone_lock()

So I would move this function in net/ipv4/inet_connection_sock.c, make it s=
tatic
so that compiler can inline it cleanly.


--===============4875680067435425592==--
