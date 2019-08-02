Content-Type: multipart/mixed; boundary="===============5353832952917595746=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 02/10] Fix locking in mptcp_finish_join.
Date: Thu, 01 Aug 2019 17:56:29 -0700
Message-ID: <alpine.OSX.2.21.1908011749410.6574@tmdiggs-mobl2.amr.corp.intel.com>
In-Reply-To: 20190726015827.10637-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1575

--===============5353832952917595746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jul 2019, Peter Krystad wrote:

> Lock was being taken on the subflow sock, not mptcp_sock.
>
> squashto:  Add handling of incoming MP_JOIN requests
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> net/mptcp/protocol.c | 9 +++++----
> net/mptcp/protocol.h | 2 +-
> net/mptcp/subflow.c  | 2 +-
> 3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5501c405c6e0..8a841d489b52 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -816,18 +816,19 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
> 	inet_sk_state_store(sk, TCP_ESTABLISHED);
> }
>
> -void mptcp_finish_join(struct sock *conn, struct sock *sk)
> +void mptcp_finish_join(struct sock *sk)
> {
> 	struct subflow_context *subflow =3D subflow_ctx(sk);
> -	struct mptcp_sock *msk =3D mptcp_sk(conn);
> +	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>
> 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
>
> 	local_bh_disable();
> -	bh_lock_sock_nested(sk);
> +	bh_lock_sock_nested(subflow->conn);
> 	list_add_tail(&subflow->node, &msk->conn_list);
> -	bh_unlock_sock(sk);
> +	bh_unlock_sock(subflow->conn);

This is the sort of locking I'm getting deadlock warnings for in my =

mptcp-level data_ready function (patch that tries to fix the MPTCP socket =

wakeup problem). The selftest didn't trigger the lock warning for me, but =

it doesn't do any joins yet! I didn't get a chance to test against the =

multipath-tcp.org kernel yet.

This function reverses the order of lock acquisition (locks the mptcp =

socket second), so it could deadlock. How we solve this is part of our =

larger locking discussion so I don't have a solution to give here :)

Mat

> 	local_bh_enable();
> +	inet_sk_state_store(sk, TCP_ESTABLISHED);
> }
>
> bool mptcp_sk_is_subflow(const struct sock *sk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6e6cf37799ef..90e11d28fad8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -211,7 +211,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> 		       struct tcp_options_received *opt_rx);
>
> void mptcp_finish_connect(struct sock *sk, int mp_capable);
> -void mptcp_finish_join(struct sock *conn, struct sock *sk);
> +void mptcp_finish_join(struct sock *sk);
>
> void token_init(void);
> void token_new_request(struct request_sock *req, const struct sk_buff *sk=
b);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d91d817b8779..9d91014c0d1b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -165,7 +165,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
> 			if (token_new_join(child))
> 				goto close_child;
> 			else
> -				mptcp_finish_join(ctx->conn, child);
> +				mptcp_finish_join(child);
> 		}
> 	}
>
> -- =

> 2.17.2
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============5353832952917595746==--
