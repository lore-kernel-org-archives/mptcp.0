Content-Type: multipart/mixed; boundary="===============4860436064281196076=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 9/9] mptcp: keep track of advertised windows right
 edge
Date: Mon, 28 Sep 2020 17:05:01 +0200
Message-ID: <4bc9483aae0f4a9b83ec551f10fb008904c8fb11.1601304622.git.pabeni@redhat.com>
In-Reply-To: cover.1601304622.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6084

--===============4860436064281196076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

Before sending 'x' new bytes also check that the new snd_una would
be within the permitted receive window.

For every ACK that also contains a DSS ack, check wheter its tcp-level
receive window would advance the current mptcp window right edge and
update it if so.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  | 18 +++++++++++---
 net/mptcp/protocol.c | 58 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3b9f7b2e706e..d8c844ae176a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -790,10 +790,12 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool =
use_64bit)
 	return cur_ack;
 }
 =

-static void update_una(struct mptcp_sock *msk,
-		       struct mptcp_options_received *mp_opt)
+static void ack_update_msk(struct mptcp_sock *msk,
+			   const struct sock *ssk,
+			   struct mptcp_options_received *mp_opt)
 {
 	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
+	u64 new_wnd_end, wnd_end, old_wnd_end =3D atomic64_read(&msk->wnd_end);
 	u64 snd_nxt =3D READ_ONCE(msk->snd_nxt);
 =

 	/* avoid ack expansion on update conflict, to reduce the risk of
@@ -806,6 +808,16 @@ static void update_una(struct mptcp_sock *msk,
 	if (after64(new_snd_una, snd_nxt))
 		new_snd_una =3D old_snd_una;
 =

+	new_wnd_end =3D new_snd_una + tcp_sk(ssk)->snd_wnd;
+
+	while (after64(new_wnd_end, old_wnd_end)) {
+		wnd_end =3D old_wnd_end;
+		old_wnd_end =3D atomic64_cmpxchg(&msk->wnd_end, wnd_end,
+							       new_wnd_end);
+		if (old_wnd_end =3D=3D wnd_end)
+			break;
+	}
+
 	while (after64(new_snd_una, old_snd_una)) {
 		snd_una =3D old_snd_una;
 		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
@@ -910,7 +922,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb)
 	 * monodirectional flows will stuck
 	 */
 	if (mp_opt.use_ack)
-		update_una(msk, &mp_opt);
+		ack_update_msk(msk, sk, &mp_opt);
 =

 	/* Zero-data-length packets are dropped by the caller and not
 	 * propagated to the MPTCP layer, so the skb extension does not
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4cd033b8fdac..03c581cdb7f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -57,6 +57,22 @@ static struct socket *__mptcp_nmpc_socket(const struct m=
ptcp_sock *msk)
 	return msk->subflow;
 }
 =

+/* Returns end sequence number of the receiver's advertised window */
+static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+{
+	return atomic64_read(&msk->wnd_end);
+}
+
+static bool mptcp_has_zero_window(const struct mptcp_sock *msk)
+{
+	return msk->write_seq =3D=3D mptcp_wnd_end(msk);
+}
+
+static bool mptcp_has_unacked_data(const struct mptcp_sock *msk)
+{
+	return mptcp_rtx_head((const struct sock *)msk) !=3D NULL;
+}
+
 static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock =3D sk->sk_socket;
@@ -174,6 +190,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk=
, struct sk_buff *skb)
 	if (after64(seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
+		pr_info("oow by %ld\n", (unsigned long)seq - (unsigned long)max_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
@@ -829,8 +846,11 @@ static void mptcp_clean_una(struct sock *sk)
 	/* on fallback we just need to ignore snd_una, as this is really
 	 * plain TCP
 	 */
-	if (__mptcp_check_fallback(msk))
+	if (__mptcp_check_fallback(msk)) {
 		atomic64_set(&msk->snd_una, msk->snd_nxt);
+		atomic64_set(&msk->wnd_end, msk->snd_nxt + 1);
+	}
+
 	snd_una =3D atomic64_read(&msk->snd_una);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
@@ -933,6 +953,28 @@ struct mptcp_sendmsg_info {
 	unsigned int flags;
 };
 =

+static int mptcp_check_allowed_size(struct mptcp_sock *msk, const struct m=
ptcp_sendmsg_info *info)
+{
+	u64 window_end =3D mptcp_wnd_end(msk);
+
+	if (__mptcp_check_fallback(msk))
+		return info->size_goal;
+
+	if (!before64(msk->snd_nxt + info->size_goal, window_end)) {
+		u64 allowed_size =3D window_end - msk->snd_nxt;
+
+		/* Zero window and all data acked? Probe. */
+		if (allowed_size =3D=3D 0 && !mptcp_has_unacked_data(msk)) {
+			pr_info_ratelimited("%s: avail_size %d, allowed %d use mss_now %d\n", _=
_func__, info->size_goal, (int)allowed_size, info->mss_now);
+			allowed_size =3D info->mss_now;
+		}
+
+		return min_t(unsigned int, allowed_size, info->size_goal);
+	}
+
+	return info->size_goal;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -950,7 +992,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 =

 	/* compute send limit */
 	info->mss_now =3D tcp_send_mss(ssk, &info->size_goal, info->flags);
-	avail_size =3D info->size_goal;
+	avail_size =3D mptcp_check_allowed_size(msk, info);
 	skb =3D tcp_write_queue_tail(ssk);
 	if (skb) {
 		/* Limit the write to the size available in the
@@ -964,8 +1006,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 			 mptcp_skb_can_collapse_to(data_seq, skb, mpext);
 		if (!can_collapse)
 			TCP_SKB_CB(skb)->eor =3D 1;
+		else if (avail_size > skb->len)
+			avail_size -=3D skb->len;
 		else
-			avail_size =3D info->size_goal - skb->len;
+			avail_size =3D 0;
 	}
 =

 	if (WARN_ON_ONCE(info->sent > info->limit ||
@@ -1077,6 +1121,10 @@ static struct sock *mptcp_subflow_get_send(struct mp=
tcp_sock *msk,
 		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 =

+	/* Probe if we have zero window while everything has been acked */
+	if (mptcp_has_zero_window(msk) && mptcp_has_unacked_data(msk))
+		return NULL;
+
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
@@ -2171,6 +2219,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->write_seq =3D subflow_req->idsn + 1;
 	msk->snd_nxt =3D msk->write_seq;
 	atomic64_set(&msk->snd_una, msk->write_seq);
+	atomic64_set(&msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
+
 	if (mp_opt->mp_capable) {
 		msk->can_ack =3D true;
 		msk->remote_key =3D mp_opt->sndr_key;
@@ -2205,6 +2255,8 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, con=
st struct sock *ssk)
 				      TCP_INIT_CWND * tp->advmss);
 	if (msk->rcvq_space.space =3D=3D 0)
 		msk->rcvq_space.space =3D TCP_INIT_CWND * TCP_MSS_DEFAULT;
+
+	atomic64_set(&msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 =

 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6a4472709444..fec0a50a542a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -214,6 +214,7 @@ struct mptcp_sock {
 	struct sock	*last_snd;
 	int		snd_burst;
 	atomic64_t	snd_una;
+	atomic64_t	wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
-- =

2.26.2

--===============4860436064281196076==--
