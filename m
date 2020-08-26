Content-Type: multipart/mixed; boundary="===============1359928085473941327=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: keep track of receivers
 advertised window
Date: Tue, 25 Aug 2020 17:10:20 -0700
Message-ID: <alpine.OSX.2.23.453.2008251627090.25312@ticede-or-125.amr.corp.intel.com>
In-Reply-To: 20200823011559.28689-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5622

--===============1359928085473941327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Aug 2020, Florian Westphal wrote:

> Before sending 'x' new bytes also check that the new snd_una would
> be within the permitted receive window.
>
> Track the largest rcv_win seen on a subflow in the mptcp socket itself.
> Its updated for every ACK that also contains a DSS ack.
>
> When the window is exhausted, behave as if all subflow sockets are busy,
> i.e. re-use existing wait logic.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/options.c  | 16 +++++++++++++---
> net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++---
> net/mptcp/protocol.h |  1 +
> 3 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index a52a05effac9..9ff2e85b398a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -784,11 +784,14 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, boo=
l use_64bit)
> 	return cur_ack;
> }
>
> -static void update_una(struct mptcp_sock *msk,
> -		       struct mptcp_options_received *mp_opt)
> +static void ack_update_msk(struct mptcp_sock *msk,
> +			   const struct sock *ssk,
> +			   struct mptcp_options_received *mp_opt)
> {
> 	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
> +	u32 sk_snd_wnd, old_sk_snd_wnd =3D atomic_read(&msk->snd_wnd);
> 	u64 write_seq =3D READ_ONCE(msk->write_seq);
> +	u32 ssk_snd_wnd =3D tcp_sk(ssk)->snd_wnd;
>
> 	/* avoid ack expansion on update conflict, to reduce the risk of
> 	 * wrongly expanding to a future ack sequence number, which is way
> @@ -800,6 +803,13 @@ static void update_una(struct mptcp_sock *msk,
> 	if (after64(new_snd_una, write_seq))
> 		new_snd_una =3D old_snd_una;
>
> +	while (unlikely(ssk_snd_wnd > old_sk_snd_wnd)) {
> +		sk_snd_wnd =3D old_sk_snd_wnd;
> +
> +		old_sk_snd_wnd =3D atomic_cmpxchg(&msk->snd_wnd, sk_snd_wnd,
> +					        ssk_snd_wnd);
> +	}
> +


It looks like this would ratchet up msk->snd_wnd based on the largest =

subflow snd_wnd seen in the life of the connection.

Section 3.3.5 in the RFC says to "only update its local receive window =

values when the largest sequence number allowed (i.e., DATA_ACK + receive =

window) increases on the receipt of a DATA_ACK". So that would compare =

new_snd_una + ssk_snd_wnd and old_snd_una + sk_snd_wnd, and it would be =

possible to have mismatched values for msk->snd_wnd and msk->snd_una if =

there were concurrent reads or writes.

What if this patch added msk->wnd_end instead of msk->snd_wnd? Then the =

msk window information used at transmit time would always be valid, and it =

doesn't really matter if the msk->snd_una update lags a little bit.


Mat



> 	while (after64(new_snd_una, old_snd_una)) {
> 		snd_una =3D old_snd_una;
> 		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
> @@ -900,7 +910,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
> 	 * monodirectional flows will stuck
> 	 */
> 	if (mp_opt.use_ack)
> -		update_una(msk, &mp_opt);
> +		ack_update_msk(msk, sk, &mp_opt);
>
> 	/* Zero-data-length packets are dropped by the caller and not
> 	 * propagated to the MPTCP layer, so the skb extension does not
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4dd5d35a8f39..994704f85f4c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -55,6 +55,12 @@ static struct socket *__mptcp_nmpc_socket(const struct=
 mptcp_sock *msk)
> 	return msk->subflow;
> }
>
> +/* Returns end sequence number of the receiver's advertised window */
> +static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
> +{
> +	return atomic64_read(&msk->snd_una) + atomic_read(&msk->snd_wnd);
> +}
> +
> static bool mptcp_is_tcpsk(struct sock *sk)
> {
> 	struct socket *sock =3D sk->sk_socket;
> @@ -769,6 +775,9 @@ static bool mptcp_is_writeable(struct mptcp_sock *msk)
> 	if (!sk_stream_is_writeable((struct sock *)msk))
> 		return false;
>
> +	if (!before64(msk->write_seq, mptcp_wnd_end(msk)))
> +		return false;
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		if (READ_ONCE(subflow->writable))
> 			return true;
> @@ -915,6 +924,17 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
> 	}
>
> 	if (!retransmission) {
> +		u64 window_end =3D mptcp_wnd_end(msk);
> +
> +		if (!before64(*write_seq + avail_size, window_end)) {
> +			int allowed_size =3D window_end - *write_seq;
> +
> +			if (allowed_size <=3D 0)
> +				return -EAGAIN;
> +
> +			avail_size =3D allowed_size;
> +		}
> +
> 		/* reuse tail pfrag, if possible, or carve a new one from the
> 		 * page allocator
> 		 */
> @@ -1070,7 +1090,8 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk,
> 	sock_owned_by_me((struct sock *)msk);
>
> 	*sndbuf =3D 0;
> -	if (!mptcp_ext_cache_refill(msk))
> +	if (!mptcp_ext_cache_refill(msk) ||
> +	    !before64(msk->write_seq, mptcp_wnd_end(msk)))
> 		return NULL;
>
> 	if (__mptcp_check_fallback(msk)) {
> @@ -1221,6 +1242,7 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 	tx_ok =3D msg_data_left(msg);
> 	while (tx_ok) {
> 		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +		bool zero_win;
>
> 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
> 					 &size_goal);
> @@ -1233,6 +1255,8 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 			break;
> 		}
>
> +		zero_win =3D !before64(msk->write_seq, mptcp_wnd_end(msk));
> +
> 		/* burst can be negative, we will try move to the next subflow
> 		 * at selection time, if possible.
> 		 */
> @@ -1269,11 +1293,12 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
> 		 * tcp level only.  So, we must also check the MPTCP socket
> 		 * limits before we send more data.
> 		 */
> -		if (unlikely(!sk_stream_memory_free(sk))) {
> +		if (unlikely(!sk_stream_memory_free(sk) || zero_win)) {
> 			tcp_push(ssk, msg->msg_flags, mss_now,
> 				 tcp_sk(ssk)->nonagle, size_goal);
> 			mptcp_clean_una(sk);
> -			if (!sk_stream_memory_free(sk)) {
> +			zero_win =3D !before64(msk->write_seq, mptcp_wnd_end(msk));
> +			if (!sk_stream_memory_free(sk) || zero_win) {
> 				/* can't send more for now, need to wait for
> 				 * MPTCP-level ACKs from peer.
> 				 *
> @@ -2079,6 +2104,8 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, c=
onst struct sock *ssk)
> 				      TCP_INIT_CWND * tp->advmss);
> 	if (msk->rcvq_space.space =3D=3D 0)
> 		msk->rcvq_space.space =3D TCP_INIT_CWND * TCP_MSS_DEFAULT;
> +
> +	atomic_set(&msk->snd_wnd, tp->snd_wnd);
> }
>
> static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4b8a5308aeed..e3d0e1faea05 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -200,6 +200,7 @@ struct mptcp_sock {
> 	u64		ack_seq;
> 	u64		rcv_data_fin_seq;
> 	struct sock	*last_snd;
> +	atomic_t	snd_wnd;
> 	int		snd_burst;
> 	atomic64_t	snd_una;
> 	unsigned long	timer_ival;
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============1359928085473941327==--
