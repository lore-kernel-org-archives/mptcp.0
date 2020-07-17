Content-Type: multipart/mixed; boundary="===============3483164849340435522=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: make msk established at remote
 key reception time"
Date: Fri, 17 Jul 2020 10:37:33 -0700
Message-ID: <alpine.OSX.2.23.453.2007171010030.39222@kdpetti-mobl.amr.corp.intel.com>
In-Reply-To: bca8c79e8cf93c4358d13e05f2885adef3106ed7.1594999863.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5083

--===============3483164849340435522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jul 2020, Paolo Abeni wrote:

> Commit message should be rewritten entirely, comprising the title:
> '''
> mptcp: explicitly track the fully established status
>
> Currently accepted msk sockets become established only after
> accept() returns the new sk to user-space.
>
> As MP_JOIN request are refused as per RFC spec on non fully
> established socket, the above causes mp_join self-tests
> instabilities.
>
> This change lets the msk entering the established status
> as soon as it receives the 3rd ack and propagates the first
> subflow fully established status on the msk socket.
>
> Finally we can change the subflow acceptance condition to
> take in account both the sock state and the msk fully
> established flag.
>
> '''
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c  |  1 +
> net/mptcp/protocol.c |  3 ++-
> net/mptcp/protocol.h |  6 ++++++
> net/mptcp/subflow.c  | 12 ++++++++----
> 4 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 018025ae9f36..3bc56eb608d8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -709,6 +709,7 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *sk,
> 		 * additional ack.
> 		 */
> 		subflow->fully_established =3D 1;
> +		WRITE_ONCE(msk->fully_established, true);
> 		goto fully_established;
> 	}
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0debc7a16dd5..740dba58d257 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1523,6 +1523,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->cached_ext =3D NULL;
> 	msk->flags =3D 0;
> 	msk->can_ack =3D false;
> +	msk->fully_established =3D false;
>
> 	__mptcp_init_sock(nsk);
>
> @@ -1857,7 +1858,7 @@ bool mptcp_finish_join(struct sock *sk)
> 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
>
> 	/* mptcp socket already closing? */
> -	if (inet_sk_state_load(parent) !=3D TCP_ESTABLISHED)
> +	if (!mptcp_is_fully_established(parent))
> 		return false;
>
> 	if (!msk->pm.server_side)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 08198b61b8a6..6a3fdc7d2883 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -198,6 +198,7 @@ struct mptcp_sock {
> 	u32		token;
> 	unsigned long	flags;
> 	bool		can_ack;
> +	bool		fully_established;
> 	spinlock_t	join_list_lock;
> 	struct work_struct work;
> 	struct list_head conn_list;
> @@ -375,6 +376,11 @@ void mptcp_get_options(const struct sk_buff *skb,
> 		       struct mptcp_options_received *mp_opt);
>
> void mptcp_finish_connect(struct sock *sk);
> +static inline bool mptcp_is_fully_established(struct sock *sk)
> +{
> +	return inet_sk_state_load(sk) =3D=3D TCP_ESTABLISHED &&
> +	       mptcp_sk(sk)->fully_established;

Should this be READ_ONCE(mptcp_sk(sk)->fully_established), for the same =

reason inet_sk_state_load() also uses READ_ONCE() and =

mptcp_can_accept_new_subflow() uses READ_ONCE(msk->pm.accept_subflow)?


> +}
> void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
> void mptcp_data_ready(struct sock *sk, struct sock *ssk);
> bool mptcp_finish_join(struct sock *sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e79508655fa2..9a979746c0c5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -395,9 +395,7 @@ void mptcp_subflow_fully_established(struct mptcp_sub=
flow_context *subflow,
> 	subflow->remote_key =3D mp_opt->sndr_key;
> 	subflow->fully_established =3D 1;
> 	subflow->can_ack =3D 1;
> -
> -	inet_sk_state_store(subflow->conn, TCP_ESTABLISHED);
> -	mptcp_pm_new_connection(msk, 1);
> +	WRITE_ONCE(msk->fully_established, true);
> }
>
> static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> @@ -479,10 +477,16 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> 		}
>
> 		if (ctx->mp_capable) {
> +			/* this can't race with mptcp_close(), as the msk is
> +			 * not yet exposted to user-space
> +			 */
> +			inet_sk_state_store((void *)new_msk, TCP_ESTABLISHED);
> +
> 			/* new mpc subflow takes ownership of the newly
> 			 * created mptcp socket
> 			 */
> 			new_msk->sk_destruct =3D mptcp_sock_destruct;
> +			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
> 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
> 			ctx->conn =3D new_msk;
> 			new_msk =3D NULL;
> @@ -977,7 +981,7 @@ int __mptcp_subflow_connect(struct sock *sk, int ifin=
dex,
> 	int addrlen;
> 	int err;
>
> -	if (sk->sk_state !=3D TCP_ESTABLISHED)
> +	if (!mptcp_is_fully_established(sk))
> 		return -ENOTCONN;
>
> 	err =3D mptcp_subflow_create_socket(sk, &sf);
> -- =

> 2.26.2

With the READ_ONCE() change I think this addresses the listen side of =

https://github.com/multipath-tcp/mptcp_net-next/issues/56 , with a couple =

of other non-locked transitions to TCP_ESTABLISHED still remaining on the =

connect path.

Thanks!

--
Mat Martineau
Intel
--===============3483164849340435522==--
