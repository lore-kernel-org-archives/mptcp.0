Content-Type: multipart/mixed; boundary="===============8079282087466712437=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: Use full MPTCP-level disconnect state
 machine
Date: Mon, 29 Jun 2020 13:04:37 -0700
Message-ID: <alpine.OSX.2.23.453.2006291042090.11066@jlbliss-mobl.amr.corp.intel.com>
In-Reply-To: 4b1a38cfc7ff6e8c3cee6563e444981a43b6b8d6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4846

--===============8079282087466712437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

Thanks for your review!

On Mon, 29 Jun 2020, Paolo Abeni wrote:

> Hi Mat,
>
> This patch is quite complex, could you please try splitting in multiple
> pices the next iteration, if any?
>
> e.g. one patch refactoring the existing code, one patch to create the
> new helpers, one patch using them

Yes, that would be better. Will probably do something like:

1. Use data_fin_tx_enable/etc instead of sending DATA_FIN with TCP FIN
2. New checks that don't break anything (like EPIPE error in sendmsg)
3. New helpers
4. Add state machine.

>
> On Fri, 2020-06-26 at 17:15 -0700, Mat Martineau wrote:
>> @@ -854,6 +867,9 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
>>  	if (mp_opt.use_ack)
>>  		update_una(msk, &mp_opt);
>>
>> +	if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1)
>> +		update_data_fin(subflow->conn, &mp_opt);
>> +
>
> I initially did not understand why check was needed. I see data packets
> will be update the data_fin later in the stack, but we need early check
> for 0len pkts.

I'll add a comment explaining this. 0-length packets (other than FIN) are =

dropped soon after this check.

>
>>  	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
>>  	if (!mpext)
>>  		return;
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 8e9cef974f4b1..60596ef097b88 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -16,6 +16,7 @@
>>  #include <net/inet_hashtables.h>
>>  #include <net/protocol.h>
>>  #include <net/tcp.h>
>> +#include <net/tcp_states.h>
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>  #include <net/transp_v6.h>
>>  #endif
>> @@ -141,6 +142,14 @@ static void __mptcp_move_skb(struct mptcp_sock *msk=
, struct sock *ssk,
>>  	MPTCP_SKB_CB(skb)->offset =3D offset;
>>  }
>>
>> +static void mptcp_stop_timer(struct sock *sk)
>> +{
>> +	struct inet_connection_sock *icsk =3D inet_csk(sk);
>> +
>> +	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
>> +	mptcp_sk(sk)->timer_ival =3D 0;
>> +}
>> +
>>  /* both sockets must be locked */
>>  static bool mptcp_subflow_dsn_valid(const struct mptcp_sock *msk,
>>  				    struct sock *ssk)
>> @@ -162,6 +171,116 @@ static bool mptcp_subflow_dsn_valid(const struct m=
ptcp_sock *msk,
>>  	return mptcp_subflow_data_available(ssk);
>>  }
>>
>> +static void mptcp_check_data_fin_ack(struct sock *sk)
>> +{
> Can we hook this code into mptcp_clean_una(), under the 'if (cleared)'
> condition?
>
The rtx_queue could be empty already when we're trying to process an ack =

of a DATA_FIN, so there aren't always dfrags to clean up.

> Looks more readable to me, and should be more robust (we need to check
> even when una is updated by sendmsg()).

Do you mean when write_seq is updated by sendmsg()? If DATA_FIN has been =

sent, no more data is sent after that so write_seq can't move again.

I do need to take another look at how retransmission of the DATA_FIN is =

handled.

>
>> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +
>> +	/* Look for an acknowledged DATA_FIN */
>> +	if (((1 << sk->sk_state) &
>> +	    (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
>> +	    (msk->write_seq =3D=3D atomic64_read(&msk->snd_una))) {
>> +		struct mptcp_subflow_context *subflow;
>> +
>> +		mptcp_stop_timer(sk);
>
> +
>> +		mptcp_for_each_subflow(msk, subflow) {
>> +			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>> +
>> +			lock_sock(ssk);
>> +			subflow->data_fin_tx_enable =3D 0;
>> +			release_sock(ssk);
>> +		}
>
> If we move data_fin_tx_enable at msk level we can rid of this loop and
> possibly clean-up the code elsewhere.
>

That would be cleaner. In trying to simplify the locking issues in the =

subflow option writing, it got more complicated in places like this. =

Should be simpler to handle at the msk level using READ_ONCE/WRITE_ONCE.

>
>> +
>> +		switch (sk->sk_state) {
>> +		case TCP_FIN_WAIT1:
>> +			inet_sk_state_store(sk, TCP_FIN_WAIT2);
>> +			break;
>> +		case TCP_CLOSING:
>> +			fallthrough;
>> +		case TCP_LAST_ACK:
>> +			inet_sk_state_store(sk, TCP_CLOSE);
>> +			// @@ Close subflows now?
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static bool mptcp_pending_data_fin(struct sock *sk)
>> +{
>> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +
>> +	return (READ_ONCE(msk->rcv_data_fin) &&
>> +		((1 << sk->sk_state) &
>> +		 (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2)) &&
>> +		msk->ack_seq =3D=3D READ_ONCE(msk->rcv_data_fin_seq));
>> +}
>> +
>> +static void mptcp_check_data_fin(struct sock *sk)
>> +{
>> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +
>> +	/* Need to ack a DATA_FIN in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
>> +	 * If we are caught up to the sequence number of the incoming
>> +	 * DATA_FIN, send the DATA_ACK now and do state transition.
>> +	 * If not caught up, do nothing and let the recv code DATA_ACK
>> +	 * along with the received data.
>> +	 */
>> +
>> +	if (READ_ONCE(msk->rcv_data_fin) &&
>> +	    ((1 << sk->sk_state) &
>> +	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
>
> Why considering also the established state? It looks dangerous,
> as mptcp_check_data_fin() is called every time the workqueue kick-in.
> I fear we can miss-detect a "no more data to write now - but I'll send
> more in the future" for an EoF ?!?

This is detecting a DATA_FIN that was sent by a peer, and the sk_state is =

only examined if the rcv_data_fin was already set to 'true' indicating =

that the peer will not be sending more data.

>
> Also It's not entirely clear to me why can't do this check/actions
> in __mptcp_move_skbs_from_subflow(), which will not require additional
> work scheduling?

I'll look at that - I was trying to limit the conditions where the msk =

sock changes state so it didn't happen in unexpected places during =

send/recv. The latency in acknowledging a DATA_FIN didn't seem as critical =

at the end of a connection, but it would be nice to avoid the scheduling.

>
>> +		u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
>> +		struct mptcp_subflow_context *subflow;
>> +
>> +		if (msk->ack_seq =3D=3D rcv_data_fin_seq) {
>> +			msk->ack_seq++;
>> +			WRITE_ONCE(msk->rcv_data_fin, 0);
>> +
>> +			sk->sk_shutdown |=3D RCV_SHUTDOWN;
>> +
>> +			switch (sk->sk_state) {
>> +			case TCP_ESTABLISHED:
>> +				inet_sk_state_store(sk, TCP_CLOSE_WAIT);
>
> I think TCP_ESTABLISHED is not possible here/is a bad state??! We
> already received a data_fin, right?

The DATA_FIN has been seen at the subflow level, but it hasn't been seen =

by the msk yet. That's what is happening here: the subflow has propagated =

an incoming DATA_FIN to the msk, and the msk is now processing that =

DATA_FIN to change the msk state.

>> +				break;
>> +			case TCP_FIN_WAIT1:
>> +				inet_sk_state_store(sk, TCP_CLOSING);
>> +				break;
>> +			case TCP_FIN_WAIT2:
>> +				inet_sk_state_store(sk, TCP_CLOSE);
>> +				// @@ Close subflows now?
>> +				break;
>> +			default:
>> +				/* Other states not expected */
>> +				WARN_ON_ONCE(1);
>> +				break;
>> +			}
>> +
>> +			mptcp_set_timeout(sk, NULL);
>> +			mptcp_for_each_subflow(msk, subflow) {
>> +				struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>> +
>> +				lock_sock(ssk);
>> +				tcp_send_ack(ssk);
>> +				release_sock(ssk);
>> +			}
>
> Do we need to send the ack on all the subflows ?

No, it could only be sent on the subflow that received the DATA_FIN, but =

it wouldn't be as reliable. The msk would have to keep track of which =

subflow(s) the DATA_FIN arrived on in order to only ack on those, and it =

does not currently track that.

>> +
>> +			sk->sk_state_change(sk);
>> +
>> +			if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
>> +			    sk->sk_state =3D=3D TCP_CLOSE)
>> +				sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
>> +			else
>> +				sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
>> +		}
>> +	}
>> +}
>> +
>> +static void mptcp_schedule_work(struct sock *sk)
>> +{
>> +	if (schedule_work(&mptcp_sk(sk)->work))
>> +		sock_hold(sk);
>> +}
>> +
>>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>>  					   struct sock *ssk,
>>  					   unsigned int *bytes)
>> @@ -1249,6 +1371,7 @@ static void mptcp_worker(struct work_struct *work)
>>
>>  	lock_sock(sk);
>>  	mptcp_clean_una(sk);
>> +	mptcp_check_data_fin_ack(sk);
>>  	__mptcp_flush_join_list(msk);
>>  	__mptcp_move_skbs(msk);
>>
>> @@ -1258,6 +1381,8 @@ static void mptcp_worker(struct work_struct *work)
>>  	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
>>  		mptcp_check_for_eof(msk);
>
> Don't we need to drop the above code?

I'll try that out. I wasn't sure if it was catching edge cases outside the =

normal connection close.

>
>> +	mptcp_check_data_fin(sk);
>> +
>>  	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>>  		goto unlock;
>>
>> @@ -1383,30 +1508,28 @@ static void mptcp_cancel_work(struct sock *sk)
>>  		sock_put(sk);
>>  }
>>
>> -static void mptcp_subflow_shutdown(struct sock *ssk, int how,
>> -				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
>> +static void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk,
>> +				   u64 data_fin_tx_seq, int how)
>>  {
>> +	struct mptcp_subflow_context *subflow;
>> +
>>  	lock_sock(ssk);
>>
>>  	switch (ssk->sk_state) {
>>  	case TCP_LISTEN:
>>  		if (!(how & RCV_SHUTDOWN))
>>  			break;
>> -		/* fall through */
>> +		fallthrough;
>>  	case TCP_SYN_SENT:
>>  		tcp_disconnect(ssk, O_NONBLOCK);
>>  		break;
>>  	default:
>> -		if (data_fin_tx_enable) {
>> -			struct mptcp_subflow_context *subflow;
>> -
>> -			subflow =3D mptcp_subflow_ctx(ssk);
>> -			subflow->data_fin_tx_seq =3D data_fin_tx_seq;
>> -			subflow->data_fin_tx_enable =3D 1;
>> -		}
>> +		subflow =3D mptcp_subflow_ctx(ssk);
>> +		subflow->data_fin_tx_seq =3D data_fin_tx_seq;
>> +		subflow->data_fin_tx_enable =3D 1;
>>
>> -		ssk->sk_shutdown |=3D how;
>> -		tcp_shutdown(ssk, how);
>> +		mptcp_set_timeout(sk, ssk);
>> +		tcp_send_ack(ssk);
>>  		break;
>>  	}
>>
>> @@ -1418,11 +1541,14 @@ static void mptcp_close(struct sock *sk, long ti=
meout)
>>  {
>>  	struct mptcp_subflow_context *subflow, *tmp;
>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +	bool data_fin_tx_enable;
>>  	LIST_HEAD(conn_list);
>>  	u64 data_fin_tx_seq;
>> +	int prev_state;
>>
>>  	lock_sock(sk);
>> -
>> +pr_debug("closing");
>> +	prev_state =3D sk->sk_state;
>
> Looks like there is some tabulation errors here?

Oops, that was temporary debug output for troubleshooting that I meant to =

delete.

>
>
>>  	inet_sk_state_store(sk, TCP_CLOSE);
>>
>>  	/* be sure to always acquire the join list lock, to sync vs
>> @@ -1433,7 +1559,17 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
>>  	spin_unlock_bh(&msk->join_list_lock);
>>  	list_splice_init(&msk->conn_list, &conn_list);
>>
>> -	data_fin_tx_seq =3D msk->write_seq;
>> +	if ((1 << prev_state) &
>> +	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>> +	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
>> +		data_fin_tx_seq =3D msk->write_seq;
>> +		data_fin_tx_enable =3D 1;
>> +
>> +		msk->write_seq++;
>> +	} else {
>> +		/* DATA_FIN has already been sent in other states */
>> +		data_fin_tx_enable =3D 0;
>> +	}
>>
>>  	__mptcp_clear_xmit(sk);
>>
>> @@ -1442,8 +1578,11 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
>>  	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
>>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>>
>> -		subflow->data_fin_tx_seq =3D data_fin_tx_seq;
>> -		subflow->data_fin_tx_enable =3D 1;
>> +		if (data_fin_tx_enable) {
>> +			subflow->data_fin_tx_seq =3D data_fin_tx_seq;
>> +			subflow->data_fin_tx_enable =3D 1;
>> +		}
>> +
>>  		__mptcp_close_ssk(sk, ssk, subflow, timeout);
>>  	}
>>
>> @@ -2109,6 +2248,33 @@ static __poll_t mptcp_poll(struct file *file, str=
uct socket *sock,
>>  	return mask;
>>  }
>>
>> +static const unsigned char new_state[16] =3D {
>> +  /* current state:        new state:      action:	*/
>> +  [0 /* (Invalid) */]	=3D TCP_CLOSE,
>> +  [TCP_ESTABLISHED]	=3D TCP_FIN_WAIT1 | TCP_ACTION_FIN,
>> +  [TCP_SYN_SENT]	=3D TCP_CLOSE,
>> +  [TCP_SYN_RECV]	=3D TCP_FIN_WAIT1 | TCP_ACTION_FIN,
>> +  [TCP_FIN_WAIT1]	=3D TCP_FIN_WAIT1,
>> +  [TCP_FIN_WAIT2]	=3D TCP_FIN_WAIT2,
>> +  [TCP_TIME_WAIT]	=3D TCP_CLOSE,	/* should not happen ! */
>> +  [TCP_CLOSE]		=3D TCP_CLOSE,
>> +  [TCP_CLOSE_WAIT]	=3D TCP_LAST_ACK  | TCP_ACTION_FIN,
>> +  [TCP_LAST_ACK]	=3D TCP_LAST_ACK,
>> +  [TCP_LISTEN]		=3D TCP_CLOSE,
>> +  [TCP_CLOSING]		=3D TCP_CLOSING,
>> +  [TCP_NEW_SYN_RECV]	=3D TCP_CLOSE,	/* should not happen ! */
>> +};
>> +
>> +static int mptcp_close_state(struct sock *sk)
>> +{
>> +	int next =3D (int)new_state[sk->sk_state];
>> +	int ns =3D next & TCP_STATE_MASK;
>> +
>> +	inet_sk_state_store(sk, ns);
>> +
>> +	return next & TCP_ACTION_FIN;
>> +}
>> +
>>  static int mptcp_shutdown(struct socket *sock, int how)
>>  {
>>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
>> @@ -2118,11 +2284,8 @@ static int mptcp_shutdown(struct socket *sock, in=
t how)
>>  	pr_debug("sk=3D%p, how=3D%d", msk, how);
>>
>>  	lock_sock(sock->sk);
>> -	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
>> -		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>>
>>  	how++;
>> -
>>  	if ((how & ~SHUTDOWN_MASK) || !how) {
>>  		ret =3D -EINVAL;
>>  		goto out_unlock;
>> @@ -2136,11 +2299,28 @@ static int mptcp_shutdown(struct socket *sock, i=
nt how)
>>  			sock->state =3D SS_CONNECTED;
>>  	}
>>
>> -	__mptcp_flush_join_list(msk);
>> -	mptcp_for_each_subflow(msk, subflow) {
>> -		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
>> +	/* If we've already sent a FIN, or it's a closed state, skip this. */
>> +	if ((how & SEND_SHUTDOWN) &&
>> +	    ((1 << sock->sk->sk_state) &
>> +	     (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>> +	      TCPF_SYN_RECV | TCPF_CLOSE_WAIT))) {
>> +
>> +		if (mptcp_close_state(sock->sk)) {
>> +			u64 data_fin_tx_seq =3D msk->write_seq;
>
> Why do we need additional state check beyond mptcp_close_state() ?

I was trying to act as much like a TCP socket as possible. It looks like =

it's to avoid modifying the state of a TCP_LISTEN socket here in the =

shutdown function (for TCP as well).

>
>> -		mptcp_subflow_shutdown(tcp_sk, how, 1, msk->write_seq);
>> +			__mptcp_flush_join_list(msk);
>> +
>> +			msk->write_seq++;
>> +
>> +			mptcp_for_each_subflow(msk, subflow) {
>> +				struct sock *tcp_sk;
>> +
>> +				tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
>> +
>> +				mptcp_subflow_shutdown(sock->sk, tcp_sk,
>> +						       data_fin_tx_seq, how);
>> +			}
>> +		}
>>  	}
>>
>>  	/* Wake up anyone sleeping in poll. */
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index dfe67e8a86ed2..834312af5ac66 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -193,11 +193,13 @@ struct mptcp_sock {
>>  	u64		remote_key;
>>  	u64		write_seq;
>>  	u64		ack_seq;
>> +	u64		rcv_data_fin_seq;
>>  	atomic64_t	snd_una;
>>  	unsigned long	timer_ival;
>>  	u32		token;
>>  	unsigned long	flags;
>>  	bool		can_ack;
>> +	bool		rcv_data_fin;
>>  	spinlock_t	join_list_lock;
>>  	struct work_struct work;
>>  	struct list_head conn_list;
>> @@ -505,4 +507,6 @@ static inline bool subflow_simultaneous_connect(stru=
ct sock *sk)
>>  	       !subflow->conn_finished;
>>  }
>>
>> +void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk);
>> +
>>  #endif /* __MPTCP_PROTOCOL_H */
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 0f0fa1ba57a89..76d05bf05f14c 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -581,7 +581,8 @@ static bool validate_mapping(struct sock *ssk, struc=
t sk_buff *skb)
>>  	return true;
>>  }
>>
>> -static enum mapping_status get_mapping_status(struct sock *ssk)
>> +static enum mapping_status get_mapping_status(struct sock *ssk,
>> +					      struct mptcp_sock *msk)
>>  {
>>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>>  	struct mptcp_ext *mpext;
>> @@ -631,7 +632,9 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk)
>>
>>  	if (mpext->data_fin =3D=3D 1) {
>>  		if (data_len =3D=3D 1) {
>> -			pr_debug("DATA_FIN with no payload");
>> +			WRITE_ONCE(msk->rcv_data_fin_seq, mpext->data_seq);
>> +			WRITE_ONCE(msk->rcv_data_fin, 1);
>> +			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
>>  			if (subflow->map_valid) {
>>  				/* A DATA_FIN might arrive in a DSS
>>  				 * option before the previous mapping
>> @@ -643,6 +646,11 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk)
>>  			} else {
>>  				return MAPPING_DATA_FIN;
>>  			}
>> +		} else {
>> +			WRITE_ONCE(msk->rcv_data_fin_seq,
>> +				   mpext->data_seq + data_len);
>> +			WRITE_ONCE(msk->rcv_data_fin, 1);
>> +			pr_debug("DATA_FIN with mapping seq=3D%llu", mpext->data_seq + data_=
len);
>>  		}
>
> if you change update_data_fin() signature to take the data_fin seq
> number as the second argument, you can reuse it here.

Ok.

>>
>>  		/* Adjust for DATA_FIN using 1 byte of sequence space */
>> @@ -731,7 +739,25 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>>  		u64 ack_seq;
>>  		u64 old_ack;
>>
>> -		status =3D get_mapping_status(ssk);
>> +		if (READ_ONCE(msk->rcv_data_fin)) {
>> +			u64 rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
>> +
>> +			ack_seq =3D READ_ONCE(msk->ack_seq);
>> +
>> +			if (ack_seq =3D=3D rcv_data_fin_seq) {
>> +				return false;
>> +			} else if (ack_seq =3D=3D rcv_data_fin_seq - 1) {
>> +				/* Acknowledge the received DATA_FIN
>> +				 * by incrementing the sequence number
>> +				 */
>> +				msk->ack_seq++;
>> +				mptcp_set_timeout(subflow->conn, ssk);
>> +				tcp_send_ack(ssk);
>> +				return false;
>> +			}
>> +		}
>> +
>
> I think the above check should be moved
> into __mptcp_move_skbs_from_subflow(), after that msk->ack_seq is
> incremented - possibly togethat with mptcp_check_data_fin()
>

Ok, I will take a look. The check needs to be done in some different =

scenarios (with or without incoming data, etc), so I'll make sure those =

are all covered.

Thanks again,

--
Mat Martineau
Intel
--===============8079282087466712437==--
