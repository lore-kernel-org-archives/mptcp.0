Content-Type: multipart/mixed; boundary="===============2123141569643653263=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1] mptcp: refine MPTCP-level ack scheduling
Date: Thu, 05 Nov 2020 18:09:28 -0800
Message-ID: <6036ba51-7155-e25a-102f-fe307fa69b9c@linux.intel.com>
In-Reply-To: a6f8772ee52668ef70c8673249b4152e8053ccca.1604512047.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6574

--===============2123141569643653263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Nov 2020, Paolo Abeni wrote:

> Send timely MPTCP-level ack is somewhat when the insertion

Is there a word missing after 'somewhat'?

> into the msk receive level is performed by the worker.
> It needs TCP-level dup-ack to notify the MPTCP-level
> ack_seq increase, as both the TCP-level ack seq and the
> rcv window are unchanged.
>
> We can actually avoid processing incoming data with the
> worker, and let the subflow or recevmsg() send ack as needed.
>
> When recvmsg() moves the skbs inside the msk receive queue,
> the msk space is still unchanged, so tcp_cleanup_rbuf() could
> end-up skipping TCP-level ack generation. Anyway, when
> __mptcp_move_skbs() is invoked, a known amount of bytes is
> going to be consumed soon: we update rcv wnd computation taking
> them in account.
>
> Additionally we need to explicitly trigger tcp_cleanup_rbuf()
> when recvmsg() consumes a significant amount of the receive buffer.
>
> Signed-off-by:  Paolo Abeni <pabeni(a)redhat.com>
> ---
> RFC -> v1:
> - removed unneeded deltas in __mptcp_move_skbs()
> ---
> net/mptcp/options.c  |  1 +
> net/mptcp/protocol.c | 66 +++++++++++++++++---------------------------
> net/mptcp/protocol.h |  7 +++++
> net/mptcp/subflow.c  |  4 +--
> 4 files changed, 35 insertions(+), 43 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 248e3930c0cb..8a59b3e44599 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -530,6 +530,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
> 		opts->ext_copy.ack64 =3D 0;
> 	}
> 	opts->ext_copy.use_ack =3D 1;
> +	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
>
> 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
> 	if (dss_size =3D=3D 0)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1ef980d4a646..c02760302e46 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -405,7 +405,7 @@ static void mptcp_set_timeout(const struct sock *sk, =
const struct sock *ssk)
> 	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
> }
>
> -static void mptcp_send_ack(struct mptcp_sock *msk)
> +static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
> {
> 	struct mptcp_subflow_context *subflow;
>
> @@ -413,8 +413,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
> 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>
> 		lock_sock(ssk);
> -		tcp_send_ack(ssk);
> +		if (force)
> +			tcp_send_ack(ssk);
> +		else
> +			tcp_cleanup_rbuf(ssk, 1);
> 		release_sock(ssk);
> +		if (!force)
> +			break;
> 	}
> }
>
> @@ -466,7 +471,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
>
> 		ret =3D true;
> 		mptcp_set_timeout(sk, NULL);
> -		mptcp_send_ack(msk);
> +		mptcp_send_ack(msk, true);
> 		if (sock_flag(sk, SOCK_DEAD))
> 			return ret;
>
> @@ -489,7 +494,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
> 	unsigned int moved =3D 0;
> 	bool more_data_avail;
> 	struct tcp_sock *tp;
> -	u32 old_copied_seq;
> 	bool done =3D false;
> 	int sk_rbuf;
>
> @@ -506,7 +510,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>
> 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
> 	tp =3D tcp_sk(ssk);
> -	old_copied_seq =3D tp->copied_seq;
> 	do {
> 		u32 map_remaining, offset;
> 		u32 seq =3D tp->copied_seq;
> @@ -572,9 +575,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
> 	} while (more_data_avail);
>
> 	*bytes +=3D moved;
> -	if (tp->copied_seq !=3D old_copied_seq)
> -		tcp_cleanup_rbuf(ssk, 1);
> -
> 	return done;
> }
>
> @@ -678,19 +678,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *=
ssk)
> 	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
> 		goto wake;
>
> -	if (move_skbs_to_msk(msk, ssk))
> -		goto wake;
> -
> -	/* mptcp socket is owned, release_cb should retry */
> -	if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
> -			      &sk->sk_tsq_flags)) {
> -		sock_hold(sk);
> +	move_skbs_to_msk(msk, ssk);

If the return value of move_skbs_to_msk() isn't needed, it looks like that =

function can be simplified (this is the only caller).

>
> -		/* need to try again, its possible release_cb() has already
> -		 * been called after the test_and_set_bit() above.
> -		 */
> -		move_skbs_to_msk(msk, ssk);
> -	}
> wake:
> 	if (wake)
> 		sk->sk_data_ready(sk);
> @@ -1526,7 +1515,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
> 	msk->rcvq_space.time =3D mstamp;
> }
>
> -static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> +static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
> {
> 	unsigned int moved =3D 0;
> 	bool done;
> @@ -1545,12 +1534,16 @@ static bool __mptcp_move_skbs(struct mptcp_sock *=
msk)
>
> 		slowpath =3D lock_sock_fast(ssk);
> 		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> +		if (moved && rcv) {
> +			WRITE_ONCE(msk->rmem_pending, min(rcv, moved));
> +			tcp_cleanup_rbuf(ssk, 1);
> +			WRITE_ONCE(msk->rmem_pending, 0);

This seems like a roundabout way to get the rmem_pending value to be used =

by __mptcp_space(), but I don't have any better ideas :)

> +		}
> 		unlock_sock_fast(ssk, slowpath);
> 	} while (!done);
>
> 	if (mptcp_ofo_queue(msk) || moved > 0) {
> -		if (!mptcp_check_data_fin((struct sock *)msk))
> -			mptcp_send_ack(msk);
> +		mptcp_check_data_fin((struct sock *)msk);
> 		return true;
> 	}
> 	return false;
> @@ -1574,8 +1567,8 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
> 	__mptcp_flush_join_list(msk);
>
> -	while (len > (size_t)copied) {
> -		int bytes_read;
> +	for (;;) {
> +		int bytes_read, old_space;
>
> 		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
> 		if (unlikely(bytes_read < 0)) {
> @@ -1587,9 +1580,14 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> 		copied +=3D bytes_read;
>
> 		if (skb_queue_empty(&sk->sk_receive_queue) &&
> -		    __mptcp_move_skbs(msk))
> +		    __mptcp_move_skbs(msk, len - copied))
> 			continue;
>
> +		/* be sure to advertize window change */
> +		old_space =3D READ_ONCE(msk->old_wspace);
> +		if ((tcp_space(sk) - old_space) >=3D old_space)
> +			mptcp_send_ack(msk, false);

Since mptcp_send_ack(msk, false) will now always send the ack on the first =

subflow, if the peer is transmitting only on a different subflow this =

could send a stream of acks on an otherwise inactive subflow. This seems =

like a different class of odd behavior compared to the occasional =

duplicate ack on an otherwise active subflow - seems like it could lead to =

cellular radios having to be more active than they need to be when a =

device is on wifi, for example. Is it worthwhile to add something to =

mptcp_skb_cb to track which subflow data arrived on so we can prefer that =

subflow for the dup ack?


Thanks,

Mat


> +
> 		/* only the master socket status is relevant here. The exit
> 		 * conditions mirror closely tcp_recvmsg()
> 		 */
> @@ -1642,7 +1640,7 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> 		/* .. race-breaker: ssk might have gotten new data
> 		 * after last __mptcp_move_skbs() returned false.
> 		 */
> -		if (unlikely(__mptcp_move_skbs(msk)))
> +		if (unlikely(__mptcp_move_skbs(msk, 0)))
> 			set_bit(MPTCP_DATA_READY, &msk->flags);
> 	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
> 		/* data to read but mptcp_wait_data() cleared DATA_READY */
> @@ -1874,7 +1872,6 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> 		__mptcp_close_subflow(msk);
>
> -	__mptcp_move_skbs(msk);
> 	if (mptcp_send_head(sk))
> 		mptcp_push_pending(sk, 0);
>
> @@ -2496,8 +2493,7 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
> 	return -EOPNOTSUPP;
> }
>
> -#define MPTCP_DEFERRED_ALL (TCPF_DELACK_TIMER_DEFERRED | \
> -			    TCPF_WRITE_TIMER_DEFERRED)
> +#define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
>
> /* this is very alike tcp_release_cb() but we must handle differently a
>  * different set of events
> @@ -2515,16 +2511,6 @@ static void mptcp_release_cb(struct sock *sk)
>
> 	sock_release_ownership(sk);
>
> -	if (flags & TCPF_DELACK_TIMER_DEFERRED) {
> -		struct mptcp_sock *msk =3D mptcp_sk(sk);
> -		struct sock *ssk;
> -
> -		ssk =3D mptcp_subflow_recv_lookup(msk);
> -		if (!ssk || sk->sk_state =3D=3D TCP_CLOSE ||
> -		    !schedule_work(&msk->work))
> -			__sock_put(sk);
> -	}
> -
> 	if (flags & TCPF_WRITE_TIMER_DEFERRED) {
> 		mptcp_retransmit_handler(sk);
> 		__sock_put(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d29c6a4749eb..d65a4c161945 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -221,10 +221,12 @@ struct mptcp_sock {
> 	u64		rcv_data_fin_seq;
> 	struct sock	*last_snd;
> 	int		snd_burst;
> +	int		old_wspace;
> 	atomic64_t	snd_una;
> 	atomic64_t	wnd_end;
> 	unsigned long	timer_ival;
> 	u32		token;
> +	int		rmem_pending;
> 	unsigned long	flags;
> 	bool		can_ack;
> 	bool		fully_established;
> @@ -259,6 +261,11 @@ static inline struct mptcp_sock *mptcp_sk(const stru=
ct sock *sk)
> 	return (struct mptcp_sock *)sk;
> }
>
> +static inline int __mptcp_space(const struct sock *sk)
> +{
> +	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_pending);
> +}
> +
> static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *=
sk)
> {
> 	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fd356dc9d580..02d757e0ddb7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -850,8 +850,6 @@ static void mptcp_subflow_discard_data(struct sock *s=
sk, struct sk_buff *skb,
> 		sk_eat_skb(ssk, skb);
> 	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
> 		subflow->map_valid =3D 0;
> -	if (incr)
> -		tcp_cleanup_rbuf(ssk, incr);
> }
>
> static bool subflow_check_data_avail(struct sock *ssk)
> @@ -973,7 +971,7 @@ void mptcp_space(const struct sock *ssk, int *space, =
int *full_space)
> 	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> 	const struct sock *sk =3D subflow->conn;
>
> -	*space =3D tcp_space(sk);
> +	*space =3D __mptcp_space(sk);
> 	*full_space =3D tcp_full_space(sk);
> }
>
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============2123141569643653263==--
