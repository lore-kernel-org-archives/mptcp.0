Content-Type: multipart/mixed; boundary="===============2260218119407621632=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 08/12] mptcp: Use full MPTCP-level
 disconnect state machine
Date: Fri, 17 Jul 2020 11:51:40 -0700
Message-ID: <alpine.OSX.2.23.453.2007171139590.39222@kdpetti-mobl.amr.corp.intel.com>
In-Reply-To: ef02ff3c1821558acde3600c025ebd9ec8480891.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5089

--===============2260218119407621632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2020, Paolo Abeni wrote:

> On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
>> RFC 8684 appendix D describes the connection state machine for
>> MPTCP. This patch implements the DATA_FIN / DATA_ACK exchanges and
>> MPTCP-level socket state changes described in that appendix, rather than
>> simply sending DATA_FIN along with TCP FIN when disconnecting subflows.
>>
>> DATA_FIN is now sent and acknowledged before shutting down the
>> subflows. Received DATA_FIN information (if not part of a data packet)
>> is written to the MPTCP socket when the incoming DSS option is parsed by
>> the subflow, and the MPTCP worker is scheduled to process the
>> flag. DATA_FIN received as part of a full DSS mapping will be handled
>> when the mapping is processed.
>>
>> The DATA_FIN is acknowledged by the worker if the reader is caught
>> up. If there is still data to be moved to the MPTCP-level queue, ack_seq
>> will be incremented to account for the DATA_FIN when it reaches the end
>> of the stream and a DATA_ACK will be sent to the peer.
>>
>> In this RFC patch, DATA_FIN is sent when calling shutdown(fd, SHUT_WR)
>> on the MPTCP socket. mptcp_close() has not yet been updated to wait for
>> the peer to DATA_ACK before forcing all the subflows to be closed and
>> cleaned up. The handshake is working with both peers using test programs
>> with shutdown() and delays, but is not yet working consistently with the
>> self tests. It also doesn't currently detect if fallback has happened,
>> so there are extra acks sent on fallback connections.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/mptcp/options.c  | 11 ++++++
>>  net/mptcp/protocol.c | 83 +++++++++++++++++++++++++++++++++++---------
>>  net/mptcp/subflow.c  | 11 ++++--
>>  3 files changed, 86 insertions(+), 19 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 4e2378369691..72d41c239acf 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -864,6 +864,17 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb,
>>  	if (mp_opt.use_ack)
>>  		update_una(msk, &mp_opt);
>>
>> +	/* Zero-length packets, like bare ACKs carrying a DATA_FIN, are
>> +	 * dropped by the caller and not propagated to the MPTCP layer.
>> +	 * Copy the DATA_FIN information now.
>> +	 */
>> +	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
>> +		if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
>> +		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq) &&
>> +		    schedule_work(&msk->work))
>> +			sock_hold(subflow->conn);
>> +	}
>> +
>>  	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
>>  	if (!mpext)
>>  		return;
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 9eef1fbe300b..d19e7ba5163c 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -299,6 +299,12 @@ static void mptcp_check_data_fin(struct sock *sk)
>>  	}
>>  }
>>
>> +static void mptcp_schedule_work(struct sock *sk)
>> +{
>> +	if (schedule_work(&mptcp_sk(sk)->work))
>> +		sock_hold(sk);
>> +}
>> +
>>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>>  					   struct sock *ssk,
>>  					   unsigned int *bytes)
>> @@ -356,6 +362,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mp=
tcp_sock *msk,
>>  			seq +=3D len;
>>  			moved +=3D len;
>>
>> +			if (mptcp_pending_data_fin(sk))
>> +				mptcp_schedule_work(sk);
>> +
>>  			if (WARN_ON_ONCE(map_remaining < len))
>>  				break;
>>  		} else {
>> @@ -375,6 +384,16 @@ static bool __mptcp_move_skbs_from_subflow(struct m=
ptcp_sock *msk,
>>
>>  	*bytes =3D moved;
>>
>> +	/* If the moves have caught up with the DATA_FIN sequence number
>> +	 * it's time to ack the DATA_FIN and change socket state, but
>> +	 * this is not a good place to change state. Let the workqueue
>> +	 * do it.
>> +	 */
>> +	if (READ_ONCE(msk->rcv_data_fin) &&
>> +	    msk->ack_seq + 1 =3D=3D READ_ONCE(msk->rcv_data_fin_seq) &&
>> +	    schedule_work(&msk->work))
>> +		sock_hold(sk);
>> +
>>  	return done;
>>  }
>>
>> @@ -460,7 +479,8 @@ void mptcp_data_acked(struct sock *sk)
>>  {
>>  	mptcp_reset_timer(sk);
>>
>> -	if (!sk_stream_is_writeable(sk) &&
>> +	if ((!sk_stream_is_writeable(sk) ||
>> +	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
>>  	    schedule_work(&mptcp_sk(sk)->work))
>>  		sock_hold(sk);
>>  }
>> @@ -1378,6 +1398,7 @@ static void mptcp_worker(struct work_struct *work)
>>
>>  	lock_sock(sk);
>>  	mptcp_clean_una(sk);
>> +	mptcp_check_data_fin_ack(sk);
>>  	__mptcp_flush_join_list(msk);
>>  	__mptcp_move_skbs(msk);
>>
>> @@ -1387,6 +1408,8 @@ static void mptcp_worker(struct work_struct *work)
>>  	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
>>  		mptcp_check_for_eof(msk);
>>
>> +	mptcp_check_data_fin(sk);
>> +
>>  	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>>  		goto unlock;
>>
>> @@ -1525,8 +1548,15 @@ static void mptcp_subflow_shutdown(struct sock *s=
k, struct sock *ssk, int how)
>>  		tcp_disconnect(ssk, O_NONBLOCK);
>>  		break;
>>  	default:
>> -		mptcp_set_timeout(sk, ssk);
>> -		tcp_send_ack(ssk);
>> +		if (__mptcp_check_fallback(mptcp_sk(sk))) {
>> +			pr_debug("Fallback");
>> +			ssk->sk_shutdown |=3D how;
>> +			tcp_shutdown(ssk, how);
>> +		} else {
>> +			pr_debug("Sending DATA_FIN on subflow %p", ssk);
>> +			mptcp_set_timeout(sk, ssk);
>> +			tcp_send_ack(ssk);
>> +		}
>>  		break;
>>  	}
>>
>> @@ -1565,13 +1595,36 @@ static void mptcp_close(struct sock *sk, long ti=
meout)
>>  	struct mptcp_subflow_context *subflow, *tmp;
>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>>  	LIST_HEAD(conn_list);
>> -	int prev_state;
>>
>>  	lock_sock(sk);
>> +	sk->sk_shutdown =3D SHUTDOWN_MASK;
>> +
>> +	if (sk->sk_state =3D=3D TCP_LISTEN) {
>> +		inet_sk_state_store(sk, TCP_CLOSE);
>> +		goto cleanup;
>> +	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
>> +		goto cleanup;
>> +	}
>>
>> -	prev_state =3D sk->sk_state;
>> +	if (__mptcp_check_fallback(msk)) {
>> +		goto update_state;
>> +	} else if (mptcp_close_state(sk)) {
>> +		pr_debug("Sending DATA_FIN sk=3D%p", sk);
>> +		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
>> +		WRITE_ONCE(msk->snd_data_fin_enable, 1);
>
> Why don't we need anymore to check the prev_state ?!?

That's handled inside mptcp_close_state() (return value tells this =

function whether DATA_FIN needs to be sent), and the inet_sk_state_store =

has not yet happened at this point in the code.

>> +
>> +		mptcp_for_each_subflow(msk, subflow) {
>> +			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
>> +			mptcp_subflow_shutdown(sk, tcp_sk, SHUTDOWN_MASK);
>> +		}
>> +	}
>> +
>> +	sk_stream_wait_close(sk, timeout);
>> +
>> +update_state:
>>  	inet_sk_state_store(sk, TCP_CLOSE);
>>
>> +cleanup:
>>  	/* be sure to always acquire the join list lock, to sync vs
>>  	 * mptcp_finish_join().
>>  	 */
>> @@ -1580,16 +1633,6 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
>>  	spin_unlock_bh(&msk->join_list_lock);
>>  	list_splice_init(&msk->conn_list, &conn_list);
>>
>> -	if ((1 << prev_state) &
>> -	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>> -	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
>> -		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
>> -		WRITE_ONCE(msk->snd_data_fin_enable, 1);
>> -	} else {
>> -		/* DATA_FIN has already been sent in other states */
>> -		WRITE_ONCE(msk->snd_data_fin_enable, 0);
>> -	}
>> -
>
> Is a bit confusing that this patch undos [part of] the code introduced
> by the previous one. Perhaps this chunk and the _shutdown one should be
> moved to the previous one ? Or perhaps the 2 patches could be squashed?

I should have read ahead before replying to the previous patch. Squashing =

the two sounds good to me.

>
>>  	__mptcp_clear_xmit(sk);
>>
>>  	release_sock(sk);
>> @@ -2289,7 +2332,15 @@ static int mptcp_shutdown(struct socket *sock, in=
t how)
>>  	}
>>
>>  	/* If we've already sent a FIN, or it's a closed state, skip this. */
>> -	if ((how & SEND_SHUTDOWN) &&
>> +	if (__mptcp_check_fallback(msk)) {
>> +		if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
>> +			inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>> +
>> +		mptcp_for_each_subflow(msk, subflow) {
>> +			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
>> +			mptcp_subflow_shutdown(sock->sk, tcp_sk, how);
>> +		}
>> +	} else if ((how & SEND_SHUTDOWN) &&
>>  	    ((1 << sock->sk->sk_state) &
>>  	     (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>>  	      TCPF_SYN_RECV | TCPF_CLOSE_WAIT))) {
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 07c6b3a65bb6..d2b61dbbf503 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -594,7 +594,8 @@ static bool validate_mapping(struct sock *ssk, struc=
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
>> @@ -644,7 +645,8 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk)
>>
>>  	if (mpext->data_fin =3D=3D 1) {
>>  		if (data_len =3D=3D 1) {
>> -			pr_debug("DATA_FIN with no payload");
>> +			mptcp_update_rcv_data_fin(msk, mpext->data_seq);
>> +			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
>>  			if (subflow->map_valid) {
>>  				/* A DATA_FIN might arrive in a DSS
>>  				 * option before the previous mapping
>> @@ -656,6 +658,9 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk)
>>  			} else {
>>  				return MAPPING_DATA_FIN;
>>  			}
>> +		} else {
>> +			mptcp_update_rcv_data_fin(msk, mpext->data_seq + data_len);
>> +			pr_debug("DATA_FIN with mapping seq=3D%llu", mpext->data_seq + data_=
len);
>>  		}
>>
>>  		/* Adjust for DATA_FIN using 1 byte of sequence space */
>> @@ -744,7 +749,7 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
>>  		u64 ack_seq;
>>  		u64 old_ack;
>>
>> -		status =3D get_mapping_status(ssk);
>> +		status =3D get_mapping_status(ssk, msk);
>>  		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
>>  		if (status =3D=3D MAPPING_INVALID) {
>>  			ssk->sk_err =3D EBADMSG;
>
>
>

--
Mat Martineau
Intel
--===============2260218119407621632==--
