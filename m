Content-Type: multipart/mixed; boundary="===============1535048742275513982=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 12/13] mptcp: keep track of advertised windows
 right edge
Date: Fri, 02 Oct 2020 11:26:22 +0200
Message-ID: <6e1d4bb3e0e972a65a7d9005ea633b239b4e3433.1601630384.git.pabeni@redhat.com>
In-Reply-To: cover.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6162

--===============1535048742275513982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

Before sending 'x' new bytes also check that the new snd_una would
be within the permitted receive window.

For every ACK that also contains a DSS ack, check whether its tcp-level
receive window would advance the current mptcp window right edge and
update it if so.

Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  | 24 ++++++++++++++++++----
 net/mptcp/protocol.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b992d8d45c52..71452f0ebf53 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -790,11 +790,14 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool =
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
+	struct sock *sk =3D (struct sock *)msk;
 =

 	/* avoid ack expansion on update conflict, to reduce the risk of
 	 * wrongly expanding to a future ack sequence number, which is way
@@ -806,12 +809,25 @@ static void update_una(struct mptcp_sock *msk,
 	if (after64(new_snd_una, snd_nxt))
 		new_snd_una =3D old_snd_una;
 =

+	new_wnd_end =3D new_snd_una + tcp_sk(ssk)->snd_wnd;
+
+	while (after64(new_wnd_end, old_wnd_end)) {
+		wnd_end =3D old_wnd_end;
+		old_wnd_end =3D atomic64_cmpxchg(&msk->wnd_end, wnd_end,
+					       new_wnd_end);
+		if (old_wnd_end =3D=3D wnd_end) {
+			if (mptcp_send_head(sk))
+				mptcp_schedule_work(sk);
+			break;
+		}
+	}
+
 	while (after64(new_snd_una, old_snd_una)) {
 		snd_una =3D old_snd_una;
 		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
 					       new_snd_una);
 		if (old_snd_una =3D=3D snd_una) {
-			mptcp_data_acked((struct sock *)msk);
+			mptcp_data_acked(sk);
 			break;
 		}
 	}
@@ -911,7 +927,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
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
index af98a8643091..ba1209c75994 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -57,6 +57,12 @@ static struct socket *__mptcp_nmpc_socket(const struct m=
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
 static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock =3D sk->sk_socket;
@@ -174,6 +180,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk=
, struct sk_buff *skb)
 	if (after64(seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
+		pr_info("oow by %ld\n", (unsigned long)seq - (unsigned long)max_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
@@ -818,6 +825,7 @@ static void mptcp_clean_una(struct sock *sk)
 	 */
 	if (__mptcp_check_fallback(msk))
 		atomic64_set(&msk->snd_una, msk->snd_nxt);
+
 	snd_una =3D atomic64_read(&msk->snd_una);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
@@ -915,12 +923,30 @@ struct mptcp_sendmsg_info {
 	unsigned int flags;
 };
 =

+static int mptcp_check_allowed_size(struct mptcp_sock *msk, u64 data_seq,
+				    int avail_size)
+{
+	u64 window_end =3D mptcp_wnd_end(msk);
+
+	if (__mptcp_check_fallback(msk))
+		return avail_size;
+
+	if (!before64(data_seq + avail_size, window_end)) {
+		u64 allowed_size =3D window_end - data_seq;
+
+		return min_t(unsigned int, allowed_size, avail_size);
+	}
+
+	return avail_size;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
 {
 	u64 data_seq =3D dfrag->data_seq + info->sent;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	bool zero_window_probe =3D false;
 	struct mptcp_ext *mpext =3D NULL;
 	struct sk_buff *skb, *tail;
 	bool can_collapse =3D false;
@@ -950,6 +976,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 			avail_size =3D info->size_goal - skb->len;
 	}
 =

+	/* Zero window and all data acked? Probe. */
+	avail_size =3D mptcp_check_allowed_size(msk, data_seq, avail_size);
+	if (avail_size =3D=3D 0 && atomic64_read(&msk->snd_una) =3D=3D msk->snd_n=
xt) {
+		zero_window_probe =3D true;
+		data_seq =3D atomic64_read(&msk->snd_una) - 1;
+		avail_size =3D 1;
+	}
+
 	if (WARN_ON_ONCE(info->sent > info->limit ||
 			 info->limit > dfrag->data_len))
 		return 0;
@@ -973,6 +1007,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
 		WARN_ON_ONCE(!can_collapse);
 		mpext->data_len +=3D ret;
+		WARN_ON_ONCE(zero_window_probe);
 		goto out;
 	}
 =

@@ -991,6 +1026,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 =

+	if (zero_window_probe) {
+		mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
+		mpext->frozen =3D 1;
+		ret =3D 0;
+		tcp_push_pending_frames(ssk);
+	}
 out:
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
 	return ret;
@@ -1811,7 +1852,7 @@ static void mptcp_worker(struct work_struct *work)
 	info.limit =3D dfrag->already_sent;
 	while (info.sent < dfrag->already_sent) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret < 0)
+		if (ret <=3D 0)
 			break;
 =

 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
@@ -2162,6 +2203,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->write_seq =3D subflow_req->idsn + 1;
 	msk->snd_nxt =3D msk->write_seq;
 	atomic64_set(&msk->snd_una, msk->write_seq);
+	atomic64_set(&msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
+
 	if (mp_opt->mp_capable) {
 		msk->can_ack =3D true;
 		msk->remote_key =3D mp_opt->sndr_key;
@@ -2196,6 +2239,8 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, con=
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
index 482e982a706d..d33e9676a1a3 100644
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

--===============1535048742275513982==--
