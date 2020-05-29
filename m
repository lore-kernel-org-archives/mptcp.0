Content-Type: multipart/mixed; boundary="===============0808146311009617174=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: add receive buffer
 auto-tuning
Date: Fri, 29 May 2020 09:56:03 -0700
Message-ID: <20200529165603.GN64606@MacBook-Pro-64.local>
In-Reply-To: 20200529091728.2679-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4557

--===============0808146311009617174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/29/20 - 11:17, Florian Westphal wrote:
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
>  changes in v2:
>   - cache last rtt_us value used
>   - don't store seq value
>   - reset 'copied' to 0 when starting
>     new measurement to simplify adjust function.
>   - make sure space.space is not inited to 0, else div-by-0 occurs
> =

>  net/mptcp/protocol.c | 124 ++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |   6 +++
>  2 files changed, 123 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b2c8b57e7942..3827e4004877 100644
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
> @@ -928,6 +921,100 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *=
msk,
>  	return copied;
>  }
>  =

> +/* receive buffer autotuning.  See tcp_rcv_space_adjust for more informa=
tion.
> + *
> + * Only difference: Use highest rtt estimate of the subflows in use.
> + */
> +static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
> +	mstamp =3D div_u64(tcp_clock_ns(), NSEC_PER_USEC);
> +	time =3D tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
> +
> +	rtt_us =3D msk->rcvq_space.rtt_us;
> +	if (rtt_us && time < (rtt_us >> 3))
> +		return;
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
> +	msk->rcvq_space.rtt_us =3D rtt_us;
> +	if (time < (rtt_us >> 3) || rtt_us =3D=3D 0)
> +		return;
> +
> +	if (msk->rcvq_space.copied <=3D msk->rcvq_space.space)
> +		goto new_measure;
> +
> +	if (sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf &&
> +	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> +		int rcvmem, rcvbuf;
> +		u64 rcvwin, grow;
> +
> +		rcvwin =3D ((u64)msk->rcvq_space.copied << 1) + 16 * advmss;
> +
> +		grow  =3D rcvwin *(msk->rcvq_space.copied - msk->rcvq_space.space);
> +
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
> +	msk->rcvq_space.space =3D msk->rcvq_space.copied;
> +new_measure:
> +	msk->rcvq_space.copied =3D 0;
> +	msk->rcvq_space.time =3D mstamp;
> +}
> +
>  static bool __mptcp_move_skbs(struct mptcp_sock *msk)
>  {
>  	unsigned int moved =3D 0;
> @@ -1050,6 +1137,8 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		set_bit(MPTCP_DATA_READY, &msk->flags);
>  	}
>  out_err:
> +	mptcp_rcv_space_adjust(msk, copied);
> +
>  	release_sock(sk);
>  	return copied;
>  }
> @@ -1280,6 +1369,7 @@ static int mptcp_init_sock(struct sock *sk)
>  		return ret;
>  =

>  	sk_sockets_allocated_inc(sk);
> +	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
>  	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[2];
>  =

>  	return 0;
> @@ -1475,6 +1565,23 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  	return nsk;
>  }
>  =

> +static void mptcp_rcv_space_init(struct mptcp_sock *msk, struct sock *ss=
k)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(ssk);
> +
> +	msk->rcvq_space.copied =3D 0;
> +	msk->rcvq_space.rtt_us =3D 0;
> +
> +	tcp_mstamp_refresh(tp);
> +	msk->rcvq_space.time =3D tp->tcp_mstamp;
> +
> +	/* initial rcv_space offering made to peer */
> +	msk->rcvq_space.space =3D min_t(u32, tp->rcv_wnd,
> +				      TCP_INIT_CWND * tp->advmss);
> +	if (msk->rcvq_space.space =3D=3D 0)
> +		msk->rcvq_space.space =3D TCP_INIT_CWND * TCP_MSS_DEFAULT;
> +}
> +
>  static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
>  				 bool kern)
>  {
> @@ -1524,6 +1631,7 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
>  		list_add(&subflow->node, &msk->conn_list);
>  		inet_sk_state_store(newsk, TCP_ESTABLISHED);
>  =

> +		mptcp_rcv_space_init(msk, ssk);
>  		bh_unlock_sock(new_mptcp_sock);
>  =

>  		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
> @@ -1678,6 +1786,8 @@ void mptcp_finish_connect(struct sock *ssk)
>  	atomic64_set(&msk->snd_una, msk->write_seq);
>  =

>  	mptcp_pm_new_connection(msk, 0);
> +
> +	mptcp_rcv_space_init(msk, ssk);
>  }

Need to also handle the fallback to TCP-case. Otherwise there is a
divide-by-0:

server login: [ 1998.037445] divide error: 0000 [#1] SMP KASAN PTI
[ 1998.038321] CPU: 3 PID: 1671 Comm: http Kdump: loaded Not tainted 5.7.0-=
rc6.mptcp #43
[ 1998.039599] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[ 1998.041526] RIP: 0010:mptcp_recvmsg+0x6ae/0xa40
[ 1998.042370] Code: 44 89 e0 89 da 4c 8b 44 24 08 45 8d b4 24 40 03 00 00 =
c1 e0 04 48 8d 0c 50 89 d8 49 8d b8 60 04 00 00 31 d2 29 e8 48 0f af c1 <48=
> f7 f5 4c 8d 2c 41 e8 66 6b 6a ff 4c 8b 44 24 08 41 8b a8 64
[ 1998.045394] RSP: 0018:ffff8881174bf968 EFLAGS: 00010206
[ 1998.046237] RAX: 0000000140764000 RBX: 000000000000b500 RCX: 00000000000=
1c540
[ 1998.047397] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff829=
1b460
[ 1998.048564] RBP: 0000000000000000 R08: ffffffff8291b000 R09: ffffffff82f=
1d0c8
[ 1998.049724] R10: ffffffff82f1d0c3 R11: fffffbfff05e3a18 R12: 00000000000=
005b4
[ 1998.050872] R13: 000000000022b368 R14: 00000000000008f4 R15: ffff8881187=
40000
[ 1998.052059] FS:  00007f081dd1ea40(0000) GS:ffff88811b980000(0000) knlGS:=
0000000000000000
[ 1998.053357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1998.054189] CR2: 000055b5364a7000 CR3: 0000000115d5e000 CR4: 00000000000=
006e0
[ 1998.055231] Call Trace:
[ 1998.057574]  inet_recvmsg+0x207/0x220
[ 1998.058832]  sock_read_iter+0x1fe/0x230
[ 1998.060656]  new_sync_read+0x33a/0x350
[ 1998.063934]  vfs_read+0xbc/0x1b0
[ 1998.064466]  ksys_read+0x11b/0x150
[ 1998.066975]  do_syscall_64+0xbc/0x790
[ 1998.070940]  entry_SYSCALL_64_after_hwframe+0x44/0xa9


This diff fixes it:

=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2820da7c787a..a5b36a4c04f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1533,7 +1533,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	return nsk;
 }

-static void mptcp_rcv_space_init(struct mptcp_sock *msk, struct sock *ssk)
+void mptcp_rcv_space_init(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct tcp_sock *tp =3D tcp_sk(ssk);

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e53410830ec3..cef677ebfd09 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -383,6 +383,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);

+void mptcp_rcv_space_init(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_finish_connect(struct sock *sk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7222503b9583..0bf2b9d575fb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -259,8 +259,10 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 	}

-	if (mptcp_check_fallback(sk))
+	if (mptcp_check_fallback(sk)) {
+		mptcp_rcv_space_init(mptcp_sk(parent), sk);
 		return;
+	}

 	if (subflow->mp_capable) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),

--===============0808146311009617174==--
