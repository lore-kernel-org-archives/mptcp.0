Content-Type: multipart/mixed; boundary="===============6065341041624527406=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "tcp,
 ulp: Add clone operation to tcp_ulp_ops"
Date: Thu, 09 Jan 2020 09:14:32 +0100
Message-ID: <ebe1bddd242a7127cbbacbeb0de496bcae1e9b82.camel@redhat.com>
In-Reply-To: 20200108215738.28326-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3303

--===============6065341041624527406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-08 at 13:57 -0800, Mat Martineau wrote:
> Make change suggested in upstream review - move and rename ulp clone
> helper to make it inline-friendly.
> =

> Commit message addition:
> =

> """
> v6 -> v7:
>  - move and rename ulp clone helper to make it inline-friendly
> """
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  include/net/tcp.h               |  2 --
>  net/ipv4/inet_connection_sock.c | 14 +++++++++++++-
>  net/ipv4/tcp_ulp.c              | 12 ------------
>  3 files changed, 13 insertions(+), 15 deletions(-)
> =

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 853537e330f8..5e4133d09b9d 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2183,8 +2183,6 @@ int tcp_set_ulp(struct sock *sk, const char *name);
>  void tcp_get_available_ulp(char *buf, size_t len);
>  void tcp_cleanup_ulp(struct sock *sk);
>  void tcp_update_ulp(struct sock *sk, struct proto *p);
> -void tcp_clone_ulp(const struct request_sock *req,
> -		   struct sock *newsk, const gfp_t priority);
>  =

>  #define MODULE_ALIAS_TCP_ULP(name)				\
>  	__MODULE_INFO(alias, alias_userspace, name);		\
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index bf53a722923a..6a691fd04398 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -770,6 +770,18 @@ void inet_csk_reqsk_queue_hash_add(struct sock *sk, =
struct request_sock *req,
>  }
>  EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
>  =

> +static void inet_clone_ulp(const struct request_sock *req, struct sock *=
newsk,
> +			   const gfp_t priority)
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
>  /**
>   *	inet_csk_clone_lock - clone an inet socket, and lock its clone
>   *	@sk: the socket to clone
> @@ -810,7 +822,7 @@ struct sock *inet_csk_clone_lock(const struct sock *s=
k,
>  		/* Deinitialize accept_queue to trap illegal accesses. */
>  		memset(&newicsk->icsk_accept_queue, 0, sizeof(newicsk->icsk_accept_que=
ue));
>  =

> -		tcp_clone_ulp(req, newsk, priority);
> +		inet_clone_ulp(req, newsk, priority);
>  =

>  		security_inet_csk_clone(newsk, req);
>  	}
> diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
> index e7a2589d69ee..12ab5db2b71c 100644
> --- a/net/ipv4/tcp_ulp.c
> +++ b/net/ipv4/tcp_ulp.c
> @@ -130,18 +130,6 @@ void tcp_cleanup_ulp(struct sock *sk)
>  	icsk->icsk_ulp_ops =3D NULL;
>  }
>  =

> -void tcp_clone_ulp(const struct request_sock *req, struct sock *newsk,
> -		   const gfp_t priority)
> -{
> -	struct inet_connection_sock *icsk =3D inet_csk(newsk);
> -
> -	if (!icsk->icsk_ulp_ops)
> -		return;
> -
> -	if (icsk->icsk_ulp_ops->clone)
> -		icsk->icsk_ulp_ops->clone(req, newsk, priority);
> -}
> -
>  static int __tcp_set_ulp(struct sock *sk, const struct tcp_ulp_ops *ulp_=
ops)
>  {
>  	struct inet_connection_sock *icsk =3D inet_csk(sk);

LGTM, thanks!

Paolo

--===============6065341041624527406==--
