Content-Type: multipart/mixed; boundary="===============3644001448501562946=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 5/6] mptcp: protocol: re-check dsn before
 reading from subflow
Date: Tue, 18 Feb 2020 09:33:25 +0100
Message-ID: <0c6321cd1c79637e0794c20b078c7723b1918c1e.camel@redhat.com>
In-Reply-To: 20200217221440.GI19559@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3689

--===============3644001448501562946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 23:14 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Mon, 2020-02-17 at 16:01 +0100, Florian Westphal wrote:
> > > mptcp_subflow_data_available() is commonly called via
> > > ssk->sk_data_ready(), in this case the mptcp socket lock
> > > cannot be acquired.
> > > =

> > > Therefore, while we can safely discard subflow data that
> > > was already received up to msk->ack_seq, we cannot be sure
> > > that 'subflow->data_avail' will still be valid at the time
> > > userspace wants to read the data -- a previous read on a
> > > different subflow might have carried this data already.
> > > =

> > > In that (unlikely) event, msk->ack_seq will have been updated
> > > and will be ahead of the subflow dsn.
> > =

> > Does the above mean that we can get wake-up events and found no actual
> > data in the msk socket? (read will block)
> > =

> > Something alike:
> > - user space is blocked on mptcp_recvmsg()/mptcp_wait_data() ->
> > wait_data =3D=3D true
> > - subflow 1 delivers new in order data, wakes the user space which
> > start reading
> > - before mptcp_recvmsg updates the msk->ack_seq, subflow 2 delivers the
> > same DSS as subflow 1, consider that to be in order and sets the
> > MPTCP_DATA_READY bit
> > - mptcp_recvmsg fills the user-space buffer and completes. Since
> > wait_data =3D=3D true, the MPTCP_DATA_READY bit is left untouched.
> > - next mptcp_poll will return EPOLLIN even if no data is really
> > available.
> > =

> > Should we move the 'wait_data =3D false' initialization inside some inn=
er
> > loop?
> =

> Hmm, what about this (delta, would squash this to "mptcp: update mptcp ack
> sequence from work queue".
> =

> In your scenario above, we would now hit the 'msk->rx_queue is empty'
> branch, DATA_READY gets cleared:
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -787,10 +787,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>  			 int nonblock, int flags, int *addr_len)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	bool more_data_avail =3D true;
> -	bool wait_data =3D false;
>  	struct socket *ssock;
> -	struct sock *ssk;
>  	int copied =3D 0;
>  	int target;
>  	long timeo;
> @@ -814,7 +811,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
>  	__mptcp_flush_join_list(msk);
>  =

> -	while (more_data_avail) {
> +	while (len > (size_t)copied) {
>  		int bytes_read;
>  =

>  		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
> @@ -826,12 +823,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>  =

>  		copied +=3D bytes_read;
>  =

> -		if (skb_queue_empty(&sk->sk_receive_queue)) {
> -			if (!__mptcp_move_skbs(msk))
> -				more_data_avail =3D false;
> -
> +		if (skb_queue_empty(&sk->sk_receive_queue) &&
> +		    __mptcp_move_skbs(msk))
>  			continue;
> -		}
>  =

>  		/* only the master socket status is relevant here. The exit
>  		 * conditions mirror closely tcp_recvmsg()
> @@ -872,26 +866,24 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		}
>  =

>  		pr_debug("block timeout %ld", timeo);
> -		wait_data =3D true;
>  		mptcp_wait_data(sk, &timeo);
>  		if (unlikely(__mptcp_tcp_fallback(msk)))
>  			goto fallback;
>  	}
>  =

> -	if (more_data_avail) {
> -		if (!test_bit(MPTCP_DATA_READY, &msk->flags))
> -			set_bit(MPTCP_DATA_READY, &msk->flags);
> -	} else if (!wait_data) {
> +	if (skb_queue_empty(&sk->sk_receive_queue)) {
> +		/* entire backlog drained, clear DATA_READY. */
>  		clear_bit(MPTCP_DATA_READY, &msk->flags);
>  =

> -		/* .. race-breaker: ssk might get new data after last
> -		 * data_available() returns false.
> +		/* .. race-breaker: ssk might have gotten new data
> +		 * after last __mptcp_move_skbs() returned false.
>  		 */
> -		ssk =3D mptcp_subflow_recv_lookup(msk);
> -		if (unlikely(ssk))
> +		if (unlikely(__mptcp_move_skbs(msk)))
>  			set_bit(MPTCP_DATA_READY, &msk->flags);
> +	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
> +		/* data to read but mptcp_wait_data() cleared DATA_READY */
> +		set_bit(MPTCP_DATA_READY, &msk->flags);
>  	}
> -
>  out_err:
>  	release_sock(sk);
>  	return copied;
> =


LGTM, thanks for takling the concerns of my twisted mind ;)

Cheers,

Paolo

--===============3644001448501562946==--
