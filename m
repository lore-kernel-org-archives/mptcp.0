Content-Type: multipart/mixed; boundary="===============5619266974081022464=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 2/2] mptcp: add
 mptcp_destroy_common helper
Date: Tue, 15 Sep 2020 12:12:09 +0200
Message-ID: <c98ade363df0ccd3b37e07cc5320a1ae88fae93c.camel@redhat.com>
In-Reply-To: 9ba28d5dc65283a21065f44816b9de1ab0ebcf6f.1600154343.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5878

--===============5619266974081022464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-15 at 15:36 +0800, Geliang Tang wrote:
> This patch added a new helper named mptcp_destroy_common containing the
> shared code between mptcp_destroy() and mptcp_sock_destruct().
> =

> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/protocol.c | 13 +++++++++----
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/subflow.c  |  5 +----
>  3 files changed, 11 insertions(+), 8 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5b8aa02856b6..e85827519e0a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2151,17 +2151,22 @@ static struct sock *mptcp_accept(struct sock *sk,=
 int flags, int *err,
>  	return newsk;
>  }
>  =

> +void mptcp_destroy_common(struct sock *sk)
> +{
> +	skb_rbtree_purge(&mptcp_sk(sk)->out_of_order_queue);
> +	mptcp_token_destroy(mptcp_sk(sk));
> +	mptcp_pm_free_anno_list(mptcp_sk(sk));
> +	inet_sock_destruct(sk);

I think "inet_sock_destruct(sk);" should be left in mptcp_destroy()...

> +}
> +
>  static void mptcp_destroy(struct sock *sk)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  =

> -	skb_rbtree_purge(&msk->out_of_order_queue);
> -	mptcp_token_destroy(msk);
>  	if (msk->cached_ext)
>  		__skb_ext_put(msk->cached_ext);
>  =

> -	mptcp_pm_free_anno_list(msk);
> -	sk_sockets_allocated_dec(sk);
> +	mptcp_destroy_common(sk);

... and we must keep sk_sockets_allocated_dec() this here, too.

Cheers,

Paolo

--===============5619266974081022464==--
