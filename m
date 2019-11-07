Content-Type: multipart/mixed; boundary="===============0475945295521538251=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Wed, 06 Nov 2019 16:37:35 -0800
Message-ID: <alpine.OSX.2.21.1911061303310.42057@cavianch-mobl1.amr.corp.intel.com>
In-Reply-To: b57d3b96a0fc6dbdc055e51b68bd905fe6db5307.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2433

--===============0475945295521538251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2019, Paolo Abeni wrote:

> Hi,
>
> Thanks for doing this!
>
> I have quite a few comments below... As a general note, this patch
> looks quite complex, what about splitting it in a [small] series? I
> think it would be nice:
>
> - introducing the state machine in a separate patch,
> - possibly another one to deal with state update on fallback,
> - possibly a separate patch to fix status update on listen
> - data fin handling code
>
> On Tue, 2019-11-05 at 20:50 -0800, Mat Martineau wrote:
>> @@ -632,6 +663,18 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb,
>>
>>  	mpext->data_fin =3D mp_opt->data_fin;
>>
>> +	if (mp_opt->data_fin &&
>> +	    TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
>> +		/* The DATA_FIN is on a packet that will be discarded by
>> +		 * tcp_data_queue() and will not get propagated to the MPTCP
>> +		 * socket.
>> +		 *
>> +		 * Use workqueue or subflow error queue?
>> +		 */
>> +		pr_warn("Ignored DATA_FIN");
>> +	}
>> +
>> +
>>  	if (msk)
>>  		mptcp_pm_fully_established(msk);
>>  }
>
> I think we don't need a workqueue here: subflow could simply set
> (WRITE_ONCE) one/some msk level field[s].
>
> I don't think we need to deal with subflows concurrently writing
> different values there - it will be a protocol violation, the stream
> will be corrupted anyway.

The goal of the workqueue would be to process the DATA_FIN (and ack it if =

the recv side is caught up) even when there's no pending send/recv from =

userspace to wake up. That means the subflow error queue wouldn't work =

either.

>
> [...]
>> @@ -383,6 +383,13 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>>  	lock_sock(ssk);
>>  	mptcp_clean_una(sk);
>>  	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>> +
>> +	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
>> +		ret =3D sk_stream_wait_connect(sk, &timeo);
>> +		if (ret !=3D 0)
>> +			goto put_out_subflow;
>> +	}
>> +
>>  	while (msg_data_left(msg)) {
>>  		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
>>  					 &size_goal);
>
> I think waiting is not needed here?!? we could just bail out with
> ENOTCONN if state is >=3D TCP_FIN_WAIT1. Such check could be located
> before selecting the egress subflow: it should be outside the ssk lock.

I agree that the sk state check and possible waiting need to happen =

outside the ssk lock, thank you for spotting that.

Waiting isn't needed for the states at the end of the connection, but I =

saw that TCP sendmsg/do_tcp_sendpages verified the connection state prior =

to sending in this way. What if I move this check very early in the =

function, before the fallback sock_sendmsg()? If there's an attempt to =

send before the handshake is done, we don't want to be waiting in the =

regular TCP sendmsg().


>
> [...]
>> @@ -403,6 +410,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
>>  			mptcp_reset_timer(sk);
>>  	}
>>
>> +put_out_subflow:
>>  	release_sock(ssk);
>>
>>  out:
>> @@ -464,6 +472,41 @@ static void mptcp_wait_data(struct sock *sk, long *=
timeo)
>>  	remove_wait_queue(sk_sleep(sk), &wait);
>>  }
>>
>> +static int mptcp_close_state(int oldstate, bool fin, bool ack)
>> +{
>> +	switch (oldstate) {
>> +	case TCP_FIN_WAIT1:
>> +		if (fin && ack)
>> +			return TCP_TIME_WAIT;
>> +		else if (fin)
>> +			return TCP_FIN_WAIT2;
>> +		else
>> +			return TCP_CLOSING;
>
> As we are in 'TCP_FIN_WAIT1', we sent a DATA_FIN, I think we should:
>
> - move to TCP_FIN_WAIT2 when the fin is acked (snd_una =3D=3D data_fin_se=
q)
> - move to TCP_CLOSING when we receive a DATA_FIN
>

You're correct, that's what I was supposed to do based on the state =

diagram in RFC6824 appendix C.

> is the 'ack' argument true when there aren't any unacked data at the
> MPTCP level?!?

It will be up to the caller to set 'ack' to true only when the sequence =

number of the DATA_FIN is acked by the peer. That isn't implemented yet.

>
>> +	case TCP_FIN_WAIT2:
>> +		if (fin)
>> +			return TCP_TIME_WAIT;
>> +		else
>> +			return oldstate;
>
> When receiving the data fin in TCP_FIN_WAIT2 status, I think we can
> move directly to TCP_CLOSED and let the subflow handle the time wait.

The appendix C diagram transitions from TIME_WAIT to CLOSED when all the =

subflows have closed, but the state isn't explained further in RFC 6824. =

In RFC 6824bis, there is another mention of TIME_WAIT (section 3.3.3) and =

break-before-make - but this doesn't make sense to me since no DATA_FINs =

have been exchanged in a break-before-make scenario and the MPTCP-level =

connection would still be ESTABLISHED.

Since the DATA_FIN has been acked by the time we are exiting FIN_WAIT2 or =

CLOSING, there isn't anything to keep track of at the MPTCP level for =

retransmission purposes. I think you're right that we don't need =

TIME_WAIT.

>
> It's not clear to me if the 'fin' argument refears to 'ingress' or
> 'egress' fin (or has different meaning according to the current sk
> state).

The 'fin' and 'ack' arguments are referring to incoming DATA_FIN/DATA_ACK. =

I can modify those names to clarify.

>
>> +	case TCP_CLOSING:
>> +		if (ack)
>> +			return TCP_TIME_WAIT;
>> +		else
>> +			return oldstate;
>
> I think here we have to check (snd_una =3D=3D data_fin_seq), and move
> directly to TCP_CLOSED - the subflows will handle the time wait

I was planning to have the caller check that.

>
>> +	case TCP_LAST_ACK:
>> +		if (ack)
>> +			return TCP_CLOSE;
>> +		else
>> +			return oldstate;
>
>> +	case TCP_ESTABLISHED:
>> +		return TCP_CLOSE_WAIT;
>
> I think we should enter TCP_CLOSE_WAIT iff we received a data fin, and
> it looks like we need two additional cases:
> - TCP_CLOSE_WAIT -> TCP_LAST_ACK, when we send data fin

I handled that transition in mptcp_stream_shutdown, but it should be here =

for clarity.

> - TCP_LAST_ACK -> TCP_CLOSED when our fin is acked

That's what is above in the TCP_LAST_ACK case.

>
> Finally I think we can avoid the TCP_TIME_WAIT at all, and we could
> handle some additional corner cases:
> - all subflows are closed (due to TCP reset) -> move msk state to
> TCP_CLOSE
> - what if we receive TCP_FIN on all subflows, but no MPTCP data fin ?

Either of these could be a break-before-make scenario, but for now we do =

need to change the MPTCP state to TCP_CLOSE when all subflows are gone.

>
> [...]
>> @@ -545,6 +588,20 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>>  				continue;
>>  			}
>>  		}
>> +
>> +		if (!subflow->map_valid && subflow->incoming_data_fin) {
>> +			int newstate;
>> +
>> +			// TODO: Send on all subflows?
>> +			newstate =3D mptcp_close_state(sk->sk_state, true, false);
>> +			msk->ack_seq++;
>> +			subflow->incoming_data_fin =3D 0;
>> +			subflow->send_data_fin =3D 1;
>> +			subflow->data_fin_seq =3D msk->write_seq;
>
> The above means that the msk socket will send DATA_FIN after receiving
> one, regardless of shutdown(), right? I think that is not required ?!?

You're right - need to check newstate here and only send DATA_FIN in =

CLOSE_WAIT.

>
> [...]
>> @@ -747,11 +804,11 @@ static void mptcp_close(struct sock *sk, long time=
out)
>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>>  	struct socket *ssk =3D NULL;
>>
>> -	mptcp_token_destroy(msk->token);
>> -	inet_sk_state_store(sk, TCP_CLOSE);
>> -
>>  	lock_sock(sk);
>>
>> +	inet_sk_state_store(sk, TCP_CLOSE);
>> +	mptcp_token_destroy(msk->token);
>> +
>
> Don't we need to apply the above state machine here? and possibly use
> sk_stream_wait_close()? (with appropriate states handling, we can
> possibly re-use as it)

Yes, need the state machine here.

>
>>  	if (msk->subflow) {
>>  		ssk =3D msk->subflow;
>>  		msk->subflow =3D NULL;
>
> [...]
>> @@ -1262,6 +1330,18 @@ static int mptcp_shutdown(struct socket *sock, in=
t how)
>>  	pr_debug("sk=3D%p, how=3D%d", msk, how);
>>
>>  	lock_sock(sock->sk);
>> +
>> +	if (sock->sk->sk_state =3D=3D TCP_ESTABLISHED) {
>> +		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>> +	} else if (sock->sk->sk_state =3D=3D TCP_CLOSE_WAIT) {
>> +		inet_sk_state_store(sock->sk, TCP_LAST_ACK);
>> +	} else if (sock->sk->sk_state !=3D TCP_CLOSE) {
>> +		pr_warn("Shutdown from unexpected state %d",
>> +			sock->sk->sk_state);
>> +		release_sock(sock->sk);
>> +		return -EALREADY;
>> +	}
>> +
>
> I think we can re-use the state machine for the above transition?
> Shoul we need to check for: (how & SEND_SHUTDOWN) before doinf any
> mptcp level action?
> Should we apply the state changes only if !fallback, and ev copying the
> fallback socket status ?

Yes, yes, and yes.

>
>
>>  	ssock =3D __mptcp_fallback_get_ref(msk);
>>  	if (ssock) {
>>  		release_sock(sock->sk);
>> @@ -1276,6 +1356,8 @@ static int mptcp_shutdown(struct socket *sock, int=
 how)
>>
>>  		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
>>  		pr_debug("conn_list->subflow=3D%p", subflow);
>> +		subflow->send_data_fin =3D 1;
>> +		subflow->data_fin_seq =3D msk->write_seq;
>>  		ret =3D kernel_sock_shutdown(tcp_socket, how);
>>  	}
>>  	release_sock(sock->sk);
>
> I think here we must avoid shutting down the subflow (but likely we can
> shut them down when msk transition to TCP_FIN_WAIT2.
>
> Additionally we can consider calling tcp_close() on all subflows when
> msk transition to TCP_CLOSE state

Ok, both of those are part of the state diagram but not reflected in the =

code.

>
>> @@ -1303,7 +1385,7 @@ void mptcp_proto_init(void)
>>  	mptcp_stream_ops.accept =3D mptcp_stream_accept;
>>  	mptcp_stream_ops.getname =3D mptcp_getname;
>>  	mptcp_stream_ops.listen =3D mptcp_listen;
>> -	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
>> +	mptcp_stream_ops.shutdown =3D mptcp_stream_shutdown;
>>
>>  	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
>>  		panic("Failed to allocate MPTCP pcpu counter\n");
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 8fe5f9383d38..cf90014974ea 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -217,9 +217,12 @@ struct mptcp_subflow_context {
>>  		map_valid : 1,
>>  		backup : 1,
>>  		data_avail : 1,
>> -		rx_eof : 1;
>> +		rx_eof : 1,
>> +		incoming_data_fin : 1,
>> +		send_data_fin : 1;
>>  	u32	remote_nonce;
>>  	u64	thmac;
>> +	u64	data_fin_seq;
>>  	u32	local_nonce;
>>  	u32	remote_token;
>>  	u8	hmac[MPTCPOPT_HMAC_LEN];
>
> Possibly we can move this field to msk? and possibly we don't need
> send_data_fin?

Yeah, data_fin_seq can be moved up to msk.

>
> if we have a dss, we send data fin iff dss map matches msk data_fin_seq
> if this is not a data packet (no dss) we send the data_fin (once ???)
> if msk->write_seq =3D=3D data_fin_seq.

It's that "once" part that made me add send_data_fin. =

mptcp_write_data_fin() has this logic.

Thanks for your review!

--
Mat Martineau
Intel
--===============0475945295521538251==--
