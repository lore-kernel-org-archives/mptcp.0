Content-Type: multipart/mixed; boundary="===============9023307187868175791=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/9] mptcp: fix race from mptcp_close/mptcp join
Date: Mon, 02 Dec 2019 13:10:39 +0100
Message-ID: <4b1827db5dae62d9f75899c1951fce56edffb5e4.camel@redhat.com>
In-Reply-To: 20191130224900.8694-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2734

--===============9023307187868175791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-11-30 at 23:48 +0100, Florian Westphal wrote:
> squashto: mptcp: Add handling of incoming MP_JOIN requests
> =

> When we get join request, we can run into following problem:
> =

> cpu0                        cpu1
> =

> mptcp_close()               mptcp_finish_join()
>   lock_mptcp_sk()
>   close all ssk
>   unlock_mptcp_sk()
>                            lock_mptcp_sk()
> 	                    ... add to empty list
> 			    ... graft ssk to invalid parent
> =

> Fix this by indicating via mptcp_finish_join if the join was ok or not.
> We can do so by testing the mptcp sk_state from mptcp_finish_join after
> we've obtained the msk socket lock.
> =

> If the state is established, mptcp_close wasn't called yet (or, its
> waiting on the msk lock -- the latter makes no difference to the
> former).
> =

> If the state is different, then don't don't graft the ssk, don't
> add it the the connection list, and let the caller close the ssk.
> =

> Also, do NOT advance the ssk to established state.  The tcp stack
> already does this a bit later on, after the full tcp_sk state has been
> set up.  Doing this here can trigger a divide-by-0 bug when the ssk
> receives data right away, because tp->->rcvq_space.space has not been
> initialized yet.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 13 +++++++++++--
>  net/mptcp/protocol.h |  2 +-
>  net/mptcp/subflow.c  |  8 +++++---
>  3 files changed, 17 insertions(+), 6 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 72e6950fbbc2..529a08095512 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1174,19 +1174,28 @@ void mptcp_finish_connect(struct sock *sk, int mp=
_capable)
>  	inet_sk_state_store(sk, TCP_ESTABLISHED);
>  }
>  =

> -void mptcp_finish_join(struct sock *sk)
> +bool mptcp_finish_join(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> +	struct sock *parent =3D (void *)msk;
> +	bool ret =3D false;
>  =

>  	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
>  =

>  	local_bh_disable();
>  	bh_lock_sock_nested(subflow->conn);
> +
> +	/* mptcp socket already closing? */
> +	if (parent->sk_state !=3D TCP_ESTABLISHED)
> +		goto out;
> +
> +	ret =3D true;
>  	list_add_tail(&subflow->node, &msk->conn_list);


This relies on mptcp_close() setting msk status before acquiring the
msk socket lock, right? If so perhaps we can add a comment there to
document the locking schema?
 =

The patch LGTM! =


/P

--===============9023307187868175791==--
