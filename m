Content-Type: multipart/mixed; boundary="===============5379073512292016346=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 2/2] mptcp: add receive buffer
 auto-tuning
Date: Thu, 28 May 2020 09:26:30 -0700
Message-ID: <20200528162630.GD64606@MacBook-Pro-64.local>
In-Reply-To: 20200528130239.16498-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4532

--===============5379073512292016346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 05/28/20 - 15:02, Florian Westphal wrote:
> When mptcp is used, userspace doesn't read from the tcp (subflow)
> socket but from the parent (mptcp) socket receive queue.
> =

> skbs are moved from the subflow socket to the mptcp rx queue either from
> 'data_ready' callback (if mptcp socket can be locked), a work queue, or
> the socket receive function.
> =

> This means tcp_rcv_space_adjust() is never called and thus no receive
> buffer size auto-tuning is done.
> =

> An earlier (not merged) patch added tcp_rcv_space_adjust() calls to the
> function that moves skbs from subflow to mptcp socket.
> While this enabled autotuning, it also meant tuning was done even if
> userspace was reading the mptcp socket very slowly.
> =

> This adds mptcp_rcv_space_adjust() and calls it after userspace has
> read data from the mptcp socket rx queue.
> =

> Its very similar to tcp_rcv_space_adjust, with two differences:
> =

> 1. The rtt estimate is the largest one observed on a subflow
> 2. The rcvbuf size and window clamp of all subflows is adjusted
>    to the mptcp-level rcvbuf.
> =

> Otherwise, we get spurious drops at tcp (subflow) socket level if
> the skbs are not moved to the mptcp socket fast enough and reduced
> throughput..
> =

> Before:
> time mptcp_connect.sh -t -f $((4*1024*1024)) -d 300 -l 0.01% -r 0 -e "" -=
m mmap
> [..]
> ns4 MPTCP -> ns3 (10.0.3.2:10108      ) MPTCP   (duration 40562ms) [ OK ]
> ns4 MPTCP -> ns3 (10.0.3.2:10109      ) TCP     (duration  5415ms) [ OK ]
> ns4 TCP   -> ns3 (10.0.3.2:10110      ) MPTCP   (duration  5413ms) [ OK ]
> ns4 MPTCP -> ns3 (dead:beef:3::2:10111) MPTCP   (duration 41331ms) [ OK ]
> ns4 MPTCP -> ns3 (dead:beef:3::2:10112) TCP     (duration  5415ms) [ OK ]
> ns4 TCP   -> ns3 (dead:beef:3::2:10113) MPTCP   (duration  5714ms) [ OK ]
> Time: 846 seconds
> =

> After:
> ns4 MPTCP -> ns3 (10.0.3.2:10108      ) MPTCP   (duration  5417ms) [ OK ]
> ns4 MPTCP -> ns3 (10.0.3.2:10109      ) TCP     (duration  5429ms) [ OK ]
> ns4 TCP   -> ns3 (10.0.3.2:10110      ) MPTCP   (duration  5418ms) [ OK ]
> ns4 MPTCP -> ns3 (dead:beef:3::2:10111) MPTCP   (duration  5423ms) [ OK ]
> ns4 MPTCP -> ns3 (dead:beef:3::2:10112) TCP     (duration  5715ms) [ OK ]
> ns4 TCP   -> ns3 (dead:beef:3::2:10113) MPTCP   (duration  5415ms) [ OK ]
> Time: 275 seconds
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 117 ++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |   6 +++
>  2 files changed, 116 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b2c8b57e7942..7c1b50ee751b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -207,13 +207,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mp=
tcp_sock *msk,
>  		return false;
>  	}
>  =

> -	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> -		int rcvbuf =3D max(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> -
> -		if (rcvbuf > sk->sk_rcvbuf)
> -			sk->sk_rcvbuf =3D rcvbuf;
> -	}
> -
>  	tp =3D tcp_sk(ssk);
>  	do {
>  		u32 map_remaining, offset;
> @@ -928,6 +921,95 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *m=
sk,
>  	return copied;
>  }
>  =

> +/* receive buffer autotuning.  See tcp_rcv_space_adjust for more informa=
tion.
> + *
> + * Only difference: Use highest rtt estimate of the subflows in use.
> + */
> +static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)

Overall, I think this is the right way to go, but I'm a bit confused by the
logic here.

It seems that rcvq_space.copied is a cumulative counter of the number of by=
tes copied
to user during this measurement period (in TCP-terms copied_seq - rcvq_spac=
e.seq).

So, it seems to me like rcvq_space.seq is not needed (?).
The substraction further below (msk->rcvq_space.copied - msk->rcvq_space.se=
q) seems
to be giving rather the increment compared to the previous measurement.


Christoph

> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk =3D (struct sock *)msk;
> +	u32 time, advmss =3D 1;
> +	u64 rtt_us, mstamp;
> +
> +	sock_owned_by_me(sk);
> +
> +	if (copied <=3D 0)
> +		return;
> +
> +	msk->rcvq_space.copied +=3D copied;
> +
> +	rtt_us =3D 0;
> +	mptcp_for_each_subflow(msk, subflow) {
> +		const struct tcp_sock *tp;
> +		u64 sf_rtt_us;
> +		u32 sf_advmss;
> +
> +		tp =3D tcp_sk(mptcp_subflow_tcp_sock(subflow));
> +
> +		sf_rtt_us =3D READ_ONCE(tp->rcv_rtt_est.rtt_us);
> +		sf_advmss =3D READ_ONCE(tp->advmss);
> +
> +		rtt_us =3D max(sf_rtt_us, rtt_us);
> +		advmss =3D max(sf_advmss, advmss);
> +	}
> +
> +	mstamp =3D div_u64(tcp_clock_ns(), NSEC_PER_USEC);
> +
> +	time =3D tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
> +	if (time < (rtt_us >> 3) || rtt_us =3D=3D 0)
> +		return;
> +
> +	copied =3D msk->rcvq_space.copied - msk->rcvq_space.seq;
> +	if (copied <=3D msk->rcvq_space.space)
> +		goto new_measure;
> +
> +	if (sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf &&
> +	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> +		int rcvmem, rcvbuf;
> +		u64 rcvwin, grow;
> +
> +		rcvwin =3D ((u64)copied << 1) + 16 * advmss;
> +
> +		grow =3D rcvwin * (copied - msk->rcvq_space.space);
> +		do_div(grow, msk->rcvq_space.space);
> +		rcvwin +=3D (grow << 1);
> +
> +		rcvmem =3D SKB_TRUESIZE(advmss + MAX_TCP_HEADER);
> +		while (tcp_win_from_space(sk, rcvmem) < advmss)
> +			rcvmem +=3D 128;
> +
> +		do_div(rcvwin, advmss);
> +		rcvbuf =3D min_t(u64, rcvwin * rcvmem,
> +			       sock_net(sk)->ipv4.sysctl_tcp_rmem[2]);
> +
> +		if (rcvbuf > sk->sk_rcvbuf) {
> +			u32 window_clamp;
> +
> +			window_clamp =3D tcp_win_from_space(sk, rcvbuf);
> +			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> +
> +			/* Make subflows follow along.  If we do not do this, we
> +			 * get drops at subflow level if skbs can't be moved to
> +			 * the mptcp rx queue fast enough (announced rcv_win can
> +			 * exceed ssk->sk_rcvbuf).
> +			 */
> +			mptcp_for_each_subflow(msk, subflow) {
> +				struct sock *ssk;
> +
> +				ssk =3D mptcp_subflow_tcp_sock(subflow);
> +				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
> +				tcp_sk(ssk)->window_clamp =3D window_clamp;
> +			}
> +		}
> +	}
> +
> +	msk->rcvq_space.space =3D copied;
> +new_measure:
> +	msk->rcvq_space.seq =3D msk->rcvq_space.copied;
> +	msk->rcvq_space.time =3D mstamp;
> +}
> +
>  static bool __mptcp_move_skbs(struct mptcp_sock *msk)
>  {
>  	unsigned int moved =3D 0;
> @@ -1050,6 +1132,8 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		set_bit(MPTCP_DATA_READY, &msk->flags);
>  	}
>  out_err:
> +	mptcp_rcv_space_adjust(msk, copied);
> +
>  	release_sock(sk);
>  	return copied;
>  }
> @@ -1280,6 +1364,7 @@ static int mptcp_init_sock(struct sock *sk)
>  		return ret;
>  =

>  	sk_sockets_allocated_inc(sk);
> +	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
>  	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[2];
>  =

>  	return 0;
> @@ -1475,6 +1560,21 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  	return nsk;
>  }
>  =

> +static void mptcp_rcv_space_init(struct mptcp_sock *msk, struct sock *ss=
k)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(ssk);
> +
> +	msk->rcvq_space.seq =3D 0;
> +	msk->rcvq_space.copied =3D 0;
> +
> +	tcp_mstamp_refresh(tp);
> +	msk->rcvq_space.time =3D tp->tcp_mstamp;
> +
> +	/* initial rcv_space offering made to peer */
> +	msk->rcvq_space.space =3D min_t(u32, tp->rcv_wnd,
> +				      TCP_INIT_CWND * tp->advmss);
> +}
> +
>  static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
>  				 bool kern)
>  {
> @@ -1524,6 +1624,7 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
>  		list_add(&subflow->node, &msk->conn_list);
>  		inet_sk_state_store(newsk, TCP_ESTABLISHED);
>  =

> +		mptcp_rcv_space_init(msk, ssk);
>  		bh_unlock_sock(new_mptcp_sock);
>  =

>  		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
> @@ -1678,6 +1779,8 @@ void mptcp_finish_connect(struct sock *ssk)
>  	atomic64_set(&msk->snd_una, msk->write_seq);
>  =

>  	mptcp_pm_new_connection(msk, 0);
> +
> +	mptcp_rcv_space_init(msk, ssk);
>  }
>  =

>  static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 809687d3f410..f39cfecc22f9 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -210,6 +210,12 @@ struct mptcp_sock {
>  	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
>  	struct sock	*first;
>  	struct mptcp_pm_data	pm;
> +	struct {
> +		u32	space;
> +		u32	copied;
> +		u32	seq;
> +		u64	time;
> +	} rcvq_space;
>  };
>  =

>  #define mptcp_for_each_subflow(__msk, __subflow)			\
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============5379073512292016346==--
