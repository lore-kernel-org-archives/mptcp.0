Content-Type: multipart/mixed; boundary="===============0848245256266510505=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP stream performances
Date: Mon, 26 Oct 2020 16:46:49 +0100
Message-ID: <aa8d90d38dbbb5f97a5a883389378d979f32b186.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6438

--===============0848245256266510505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

as reported in yday mtg I'm doing perf test comparing MPTCP (single
stream) vs TCP on both net-next and export.

Test done on loopback using netperf and:

https://github.com/pabeni/mptcp-tools/tree/master/use_mptcp

branch		TCP	MPTCP	delta
		(Gbps)	(Gbps)	(%)

net-next	38	24	-36
export		38	[3,13]	[-92,-65]

as said, on the export branch the netperf tput decreases by 1 order of
magniuted or more after some, variable time. Since netperf reports the
average on the selected test time, the reported tput is both variable
and very low.

So var I could not find a reasonable way to investigate this. Dumping
the traffic or enabling debug make disapparing the issue. Even 'perf'
has been misleading so-far: without CPU pinning 'perf' may kick on the
same cpu running 'netperf' macking the timing inside the trace not
relevant. With CPU pinning (netserver, netperf and perf running on
different cores) I can't reproduce the issue.

Anyhow it looks like the receiver is not sending/delaying some required
acks, specifically when a recvmsg() syscall casues a relevant grow in
the receiver window.

If the receiver MPTCP] rcv window is full, and the data is sitting
inside the msk receive queue, we should send some additional ack when
some memory is freed by recvmsg(), but currently we don't.

Additionally, the current tcp_cleanup_rbuf()/mptcp_send_ack() hooks
in __mptcp_move_skbs_from_subflow()/__mptcp_move_skbs() are called when
the data is still sitting in the msk receive queue, so they can't catch
the above corner case.

The following hacksh patch somewhat addresses the issue here, but it
has some possibly serious problems:
- It needs to track the announced space - here a subject-to-race
WRITE_ONCE it is used, but we will need
 another atomic operation to do that properly.
- It creates a potentially high number of dup-ack due to the
unconditional tcp_send_ack(). looks like tcp_cleanup_rbuf() is not
enough/ is fooled too easily by the problem described above.

I *think* and wild guessing that a more correct solution would be:
- removing the workqueue [and]
- ensuring in-sequence data at subflow level is either moved to msk or
dropped (and not kept into the subflow due to msk receive queue being
full). =


With the above 2 things in place, than subflow_data_ready() will be
able to always update msk->ack_seq, and we should need any later
additional ack, except for window opening.

I'm pretty sure the above is far from clear, but please send any kind
of feedback, I really do feal this is a serious problem,

Thanks!

Paolo

---
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4e02c259134f..2d07d099d038 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -530,6 +530,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		opts->ext_copy.ack64 =3D 0;
 	}
 	opts->ext_copy.use_ack =3D 1;
+	WRITE_ONCE(msk->old_wspace, tcp_space((struct sock *)msk));
 =

 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size =3D=3D 0)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e69852fa32e2..328aa98c51f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -406,7 +406,7 @@ static void mptcp_set_timeout(const struct sock *sk, co=
nst struct sock *ssk)
 	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
 }
 =

-static void mptcp_send_ack(struct mptcp_sock *msk)
+static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
 {
 	struct mptcp_subflow_context *subflow;
 =

@@ -414,8 +414,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 		lock_sock(ssk);
-		tcp_send_ack(ssk);
+		if (force)
+			tcp_send_ack(ssk);
+		else
+			tcp_cleanup_rbuf(ssk, 1);
 		release_sock(ssk);
+		if (!force)
+			break;
 	}
 }
 =

@@ -467,7 +472,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 =

 		ret =3D true;
 		mptcp_set_timeout(sk, NULL);
-		mptcp_send_ack(msk);
+		mptcp_send_ack(msk, true);
 		if (sock_flag(sk, SOCK_DEAD))
 			return ret;
 =

@@ -490,7 +495,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	unsigned int moved =3D 0;
 	bool more_data_avail;
 	struct tcp_sock *tp;
-	u32 old_copied_seq;
 	bool done =3D false;
 	int sk_rbuf;
 =

@@ -507,7 +511,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 =

 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 	tp =3D tcp_sk(ssk);
-	old_copied_seq =3D tp->copied_seq;
 	do {
 		u32 map_remaining, offset;
 		u32 seq =3D tp->copied_seq;
@@ -572,10 +575,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 		}
 	} while (more_data_avail);
 =

-	*bytes +=3D moved;
-	if (tp->copied_seq !=3D old_copied_seq)
-		tcp_cleanup_rbuf(ssk, 1);
-
+	*bytes =3D moved;
 	return done;
 }
 =

@@ -1526,7 +1526,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock =
*msk, int copied)
 =

 static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 {
-	unsigned int moved =3D 0;
+	unsigned int moved_total =3D 0;
 	bool done;
 =

 	/* avoid looping forever below on racing close */
@@ -1536,6 +1536,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	__mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
+		unsigned int moved;
 		bool slowpath;
 =

 		if (!ssk)
@@ -1543,12 +1544,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k)
 =

 		slowpath =3D lock_sock_fast(ssk);
 		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		if (moved)
+			tcp_send_ack(ssk);
 		unlock_sock_fast(ssk, slowpath);
+		moved_total +=3D moved;
 	} while (!done);
 =

-	if (mptcp_ofo_queue(msk) || moved > 0) {
-		if (!mptcp_check_data_fin((struct sock *)msk))
-			mptcp_send_ack(msk);
+	if (mptcp_ofo_queue(msk) || moved_total > 0) {
+		mptcp_check_data_fin((struct sock *)msk);
 		return true;
 	}
 	return false;
@@ -1573,7 +1576,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	__mptcp_flush_join_list(msk);
 =

 	while (len > (size_t)copied) {
-		int bytes_read;
+		int bytes_read, old_space;
 =

 		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
 		if (unlikely(bytes_read < 0)) {
@@ -1588,6 +1591,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 		    __mptcp_move_skbs(msk))
 			continue;
 =

+		/* be sure to advertize window change */
+		old_space =3D READ_ONCE(msk->old_wspace);
+		if ((tcp_space(sk) - old_space) >=3D old_space)
+			mptcp_send_ack(msk, false);
+
 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
 		 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5117093a4de4..091ecb586f58 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	struct sock	*last_snd;
 	int		snd_burst;
+	int		old_wspace;
 	atomic64_t	snd_una;
 	atomic64_t	wnd_end;
 	unsigned long	timer_ival;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b210bc92fc32..07e44ffbeb30 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -850,8 +850,6 @@ static void mptcp_subflow_discard_data(struct sock *ssk=
, struct sk_buff *skb,
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
 		subflow->map_valid =3D 0;
-	if (incr)
-		tcp_cleanup_rbuf(ssk, incr);
 }
 =

 static bool subflow_check_data_avail(struct sock *ssk)

--===============0848245256266510505==--
