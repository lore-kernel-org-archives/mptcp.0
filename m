Content-Type: multipart/mixed; boundary="===============7987811570272410264=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP stream performances
Date: Tue, 27 Oct 2020 12:18:19 +0100
Message-ID: <055e191f48d01344d3debca9f6260220c53f05f3.camel@redhat.com>
In-Reply-To: aa8d90d38dbbb5f97a5a883389378d979f32b186.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6441

--===============7987811570272410264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

adding some comments to give a little more context. This is getting
close to my stream of consciousness, so I guess it will not more easily
readable then "the ulysses"...

On Mon, 2020-10-26 at 16:46 +0100, Paolo Abeni wrote:
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4e02c259134f..2d07d099d038 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -530,6 +530,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  		opts->ext_copy.ack64 =3D 0;
>  	}
>  	opts->ext_copy.use_ack =3D 1;
> +	WRITE_ONCE(msk->old_wspace, tcp_space((struct sock *)msk));

here a cmpxchg would be needed to make the above safe, but at worst we
will have an additional unneeded call to tcp_cleanp_rbuf(), and the
latter will avoid dup acks, so I think it's not tragic.

>  =

>  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
>  	if (dss_size =3D=3D 0)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e69852fa32e2..328aa98c51f2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -406,7 +406,7 @@ static void mptcp_set_timeout(const struct sock *sk, =
const struct sock *ssk)
>  	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
>  }
>  =

> -static void mptcp_send_ack(struct mptcp_sock *msk)
> +static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
>  {
>  	struct mptcp_subflow_context *subflow;
>  =

> @@ -414,8 +414,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  =

>  		lock_sock(ssk);
> -		tcp_send_ack(ssk);
> +		if (force)
> +			tcp_send_ack(ssk);
> +		else
> +			tcp_cleanup_rbuf(ssk, 1);
>  		release_sock(ssk);
> +		if (!force)
> +			break;
>  	}
>  }
>  =

> @@ -467,7 +472,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  =

>  		ret =3D true;
>  		mptcp_set_timeout(sk, NULL);
> -		mptcp_send_ack(msk);
> +		mptcp_send_ack(msk, true);
>  		if (sock_flag(sk, SOCK_DEAD))
>  			return ret;
>  =

> @@ -490,7 +495,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>  	unsigned int moved =3D 0;
>  	bool more_data_avail;
>  	struct tcp_sock *tp;
> -	u32 old_copied_seq;
>  	bool done =3D false;
>  	int sk_rbuf;
>  =

> @@ -507,7 +511,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>  =

>  	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
>  	tp =3D tcp_sk(ssk);
> -	old_copied_seq =3D tp->copied_seq;
>  	do {
>  		u32 map_remaining, offset;
>  		u32 seq =3D tp->copied_seq;
> @@ -572,10 +575,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mp=
tcp_sock *msk,
>  		}
>  	} while (more_data_avail);
>  =

> -	*bytes +=3D moved;
> -	if (tp->copied_seq !=3D old_copied_seq)
> -		tcp_cleanup_rbuf(ssk, 1);

__mptcp_move_skbs_from_subflow() is invoked by the subflow receive
path, via subflow_data_ready()/mptcp_data_ready() and by
mptcp_recvmsg(), via __mptcp_move_skbs().

In the first case we don't need to send additional acks, the TCP stack
will do that for us in tcp_rcv_established() via tcp_ack_snd_check()
just after updating the msk->ack_seq. =


To cover the second case, is better moving the ack hook elsewhere, see
below.

Note: in tcp_rcv_established() we always hit the TCP 'slow-path', as
TCP header prediction always fails for packets carrying any type of
MPTCP options. We could change that. e.g. including a DSS64 in the
predicted header len, but then the TCP ack will be generated _before_
msk->ack_seq is updated, so we are better off with header
misprediction;)

> -
> +	*bytes =3D moved;
>  	return done;
>  }
>  =

> @@ -1526,7 +1526,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
>  =

>  static bool __mptcp_move_skbs(struct mptcp_sock *msk)
>  {
> -	unsigned int moved =3D 0;
> +	unsigned int moved_total =3D 0;
>  	bool done;
>  =

>  	/* avoid looping forever below on racing close */
> @@ -1536,6 +1536,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k)
>  	__mptcp_flush_join_list(msk);
>  	do {
>  		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> +		unsigned int moved;
>  		bool slowpath;
>  =

>  		if (!ssk)
> @@ -1543,12 +1544,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *=
msk)
>  =

>  		slowpath =3D lock_sock_fast(ssk);
>  		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> +		if (moved)
> +			tcp_send_ack(ssk);

This may generare an high volume of TCP dup acks, but calling
tcp_cleanup_rbuf() here is not enough, because the packets are still
accounted in the msk receive buffer, the msk receive windows is not
changed with the above call, so neither the subflow receive window.
tcp_cleanup_rbuf() will likely _not_ generate a new ack when needed.

Even replacing tcp_send_ack() with __tcp_ack_snd_check() will not
improve much: since the rcv window is not changed, and the relevant
segment has been already acked at the TCP level, such call will either
generate a dup ack or no ack at all. Additionally __tcp_ack_snd_check()
is currently static.

All the above makes me thing that trying to remove the workqueue for
the receive path could be a better solution: if incoming pkts are
always moved into the msk receive queue by subflow_data_ready(), the
ACK packet generated by the TCP stack will be enough to cover all the
above, without any need for dup acks.

With a caveat: currently we leave some packet in the subflow receive
queue while the msk receive queue is full. Possibly keeping the
incoming skb always accounted into the ingress ssk would avoid that
case - currently we move the accounting from ssk to msk
in __mptcp_move_skbs_from_subflow(). Handling the skb freing at receive
time and subflow tear down will not be trivial.

/P

--===============7987811570272410264==--
