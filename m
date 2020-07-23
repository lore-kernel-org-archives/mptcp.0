Content-Type: multipart/mixed; boundary="===============2091065282134704374=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 05/12] mptcp: Track received
 DATA_FIN sequence number and add related helpers
Date: Thu, 23 Jul 2020 07:26:56 -0700
Message-ID: <20200723142656.GO73500@MacBook-Pro-64.local>
In-Reply-To: 20200723003219.90547-6-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5244

--===============2091065282134704374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/22/20 - 17:32, Mat Martineau wrote:
> Incoming DATA_FIN headers need to propagate the presence of the DATA_FIN
> bit and the associated sequence number to the MPTCP layer, even when
> arriving on a bare ACK that does not get added to the receive queue. Add
> structure members to store the DATA_FIN information and helpers to set
> and check those values.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/options.c  |  16 +++++++
>  net/mptcp/protocol.c | 106 +++++++++++++++++++++++++++++++++++++++----
>  net/mptcp/protocol.h |   3 ++
>  3 files changed, 115 insertions(+), 10 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0b122b2a9c69..c1f806f03021 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -776,6 +776,22 @@ static void update_una(struct mptcp_sock *msk,
>  	}
>  }
>  =

> +bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq)
> +{
> +	/* Skip if DATA_FIN was already received.
> +	 * If updating simultaneously with the recvmsg loop, values
> +	 * should match. If they mismatch, the peer is misbehaving and
> +	 * we will prefer the most recent information.
> +	 */
> +	if (READ_ONCE(msk->rcv_data_fin) || !READ_ONCE(msk->first))
> +		return false;
> +
> +	WRITE_ONCE(msk->rcv_data_fin_seq, data_fin_seq);
> +	WRITE_ONCE(msk->rcv_data_fin, 1);
> +
> +	return true;
> +}
> +
>  static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>  				struct mptcp_options_received *mp_opt)
>  {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 35b93ffeebc3..6231531e1867 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -16,6 +16,7 @@
>  #include <net/inet_hashtables.h>
>  #include <net/protocol.h>
>  #include <net/tcp.h>
> +#include <net/tcp_states.h>
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  #include <net/transp_v6.h>
>  #endif
> @@ -163,6 +164,101 @@ static bool mptcp_subflow_dsn_valid(const struct mp=
tcp_sock *msk,
>  	return mptcp_subflow_data_available(ssk);
>  }
>  =

> +static bool mptcp_pending_data_fin(struct sock *sk, u64* seq)

Just a minor nit I got while applying these patches on top of export for
testing:

s/u64* seq/u64 *seq



Christoph

> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	if (READ_ONCE(msk->rcv_data_fin) &&
> +	    ((1 << sk->sk_state) &
> +	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
> +		u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
> +
> +		if (msk->ack_seq + 1 =3D=3D rcv_data_fin_seq) {
> +			if (seq)
> +				*seq =3D rcv_data_fin_seq;
> +
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static void mptcp_set_timeout(const struct sock *sk, const struct sock *=
ssk)
> +{
> +	long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
> +				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
> +
> +	if (tout <=3D 0)
> +		tout =3D mptcp_sk(sk)->timer_ival;
> +	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
> +}
> +
> +static void mptcp_check_data_fin(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	u64 rcv_data_fin_seq;
> +
> +	if (__mptcp_check_fallback(msk) || !msk->first)
> +		return;
> +
> +	/* Need to ack a DATA_FIN received from a peer while this side
> +	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
> +	 * msk->rcv_data_fin was set when parsing the incoming options
> +	 * at the subflow level and the msk lock was not held, so this
> +	 * is the first opportunity to act on the DATA_FIN and change
> +	 * the msk state.
> +	 *
> +	 * If we are caught up to the sequence number of the incoming
> +	 * DATA_FIN, send the DATA_ACK now and do state transition.  If
> +	 * not caught up, do nothing and let the recv code send DATA_ACK
> +	 * when catching up.
> +	 */
> +
> +	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
> +		struct mptcp_subflow_context *subflow;
> +
> +		msk->ack_seq++;
> +		WRITE_ONCE(msk->rcv_data_fin, 0);
> +
> +		sk->sk_shutdown |=3D RCV_SHUTDOWN;
> +
> +		switch (sk->sk_state) {
> +		case TCP_ESTABLISHED:
> +			inet_sk_state_store(sk, TCP_CLOSE_WAIT);
> +			break;
> +		case TCP_FIN_WAIT1:
> +			inet_sk_state_store(sk, TCP_CLOSING);
> +			break;
> +		case TCP_FIN_WAIT2:
> +			inet_sk_state_store(sk, TCP_CLOSE);
> +			// @@ Close subflows now?
> +			break;
> +		default:
> +			/* Other states not expected */
> +			WARN_ON_ONCE(1);
> +			break;
> +		}
> +
> +		mptcp_set_timeout(sk, NULL);
> +		mptcp_for_each_subflow(msk, subflow) {
> +			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +			lock_sock(ssk);
> +			tcp_send_ack(ssk);
> +			release_sock(ssk);
> +		}
> +
> +		sk->sk_state_change(sk);
> +
> +		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
> +		    sk->sk_state =3D=3D TCP_CLOSE)
> +			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
> +		else
> +			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
> +	}
> +}
> +
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  					   struct sock *ssk,
>  					   unsigned int *bytes)
> @@ -303,16 +399,6 @@ static void __mptcp_flush_join_list(struct mptcp_soc=
k *msk)
>  	spin_unlock_bh(&msk->join_list_lock);
>  }
>  =

> -static void mptcp_set_timeout(const struct sock *sk, const struct sock *=
ssk)
> -{
> -	long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
> -				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
> -
> -	if (tout <=3D 0)
> -		tout =3D mptcp_sk(sk)->timer_ival;
> -	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
> -}
> -
>  static bool mptcp_timer_pending(struct sock *sk)
>  {
>  	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 67634b595466..2cbcbfc79871 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -193,12 +193,14 @@ struct mptcp_sock {
>  	u64		remote_key;
>  	u64		write_seq;
>  	u64		ack_seq;
> +	u64		rcv_data_fin_seq;
>  	atomic64_t	snd_una;
>  	unsigned long	timer_ival;
>  	u32		token;
>  	unsigned long	flags;
>  	bool		can_ack;
>  	bool		fully_established;
> +	bool		rcv_data_fin;
>  	spinlock_t	join_list_lock;
>  	struct work_struct work;
>  	struct list_head conn_list;
> @@ -386,6 +388,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *s=
sk);
>  bool mptcp_finish_join(struct sock *sk);
>  void mptcp_data_acked(struct sock *sk);
>  void mptcp_subflow_eof(struct sock *sk);
> +bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq);
>  =

>  void __init mptcp_token_init(void);
>  static inline void mptcp_token_init_request(struct request_sock *req)
> -- =

> 2.27.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============2091065282134704374==--
