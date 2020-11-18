Content-Type: multipart/mixed; boundary="===============1241155825998691365=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 5/7] mptcp: avoid a few atomic ops in the rx path
Date: Wed, 18 Nov 2020 19:04:44 +0100
Message-ID: <fcdc103f43bf67b69395535bdb1f4ce39cde73db.1605718134.git.pabeni@redhat.com>
In-Reply-To: cover.1605718134.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6790

--===============1241155825998691365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extending the data_lock scope in mptcp_incoming_option
we can use that to protect both snd_una and wnd_end.
In the typical case we will have a single atomic op instead of 2

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/mptcp_diag.c |  2 +-
 net/mptcp/options.c    | 33 +++++++++++++--------------------
 net/mptcp/protocol.c   | 34 ++++++++++++++++------------------
 net/mptcp/protocol.h   |  8 ++++----
 4 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 5f390a97f556..b70ae4ba3000 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -140,7 +140,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct=
 inet_diag_msg *r,
 	info->mptcpi_flags =3D flags;
 	info->mptcpi_token =3D READ_ONCE(msk->token);
 	info->mptcpi_write_seq =3D READ_ONCE(msk->write_seq);
-	info->mptcpi_snd_una =3D atomic64_read(&msk->snd_una);
+	info->mptcpi_snd_una =3D READ_ONCE(msk->snd_una);
 	info->mptcpi_rcv_nxt =3D READ_ONCE(msk->ack_seq);
 	unlock_sock_fast(sk, slow);
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a59b3e44599..3986454a0340 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -833,15 +833,17 @@ static void ack_update_msk(struct mptcp_sock *msk,
 			   const struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
 {
-	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
-	u64 new_wnd_end, wnd_end, old_wnd_end =3D atomic64_read(&msk->wnd_end);
-	u64 snd_nxt =3D READ_ONCE(msk->snd_nxt);
+	u64 new_wnd_end, new_snd_una, snd_nxt =3D READ_ONCE(msk->snd_nxt);
 	struct sock *sk =3D (struct sock *)msk;
+	u64 old_snd_una;
+
+	mptcp_data_lock(sk);
 =

 	/* avoid ack expansion on update conflict, to reduce the risk of
 	 * wrongly expanding to a future ack sequence number, which is way
 	 * more dangerous than missing an ack
 	 */
+	old_snd_una =3D msk->snd_una;
 	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 =

 	/* ACK for data not even sent yet? Ignore. */
@@ -850,26 +852,17 @@ static void ack_update_msk(struct mptcp_sock *msk,
 =

 	new_wnd_end =3D new_snd_una + tcp_sk(ssk)->snd_wnd;
 =

-	while (after64(new_wnd_end, old_wnd_end)) {
-		wnd_end =3D old_wnd_end;
-		old_wnd_end =3D atomic64_cmpxchg(&msk->wnd_end, wnd_end,
-					       new_wnd_end);
-		if (old_wnd_end =3D=3D wnd_end) {
-			if (mptcp_send_head(sk))
-				mptcp_schedule_work(sk);
-			break;
-		}
+	if (after64(new_wnd_end, msk->wnd_end)) {
+		msk->wnd_end =3D new_wnd_end;
+		if (mptcp_send_head(sk))
+			mptcp_schedule_work(sk);
 	}
 =

-	while (after64(new_snd_una, old_snd_una)) {
-		snd_una =3D old_snd_una;
-		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
-					       new_snd_una);
-		if (old_snd_una =3D=3D snd_una) {
-			mptcp_data_acked(sk);
-			break;
-		}
+	if (after64(new_snd_una, old_snd_una)) {
+		msk->snd_una =3D new_snd_una;
+		__mptcp_data_acked(sk);
 	}
+	mptcp_data_unlock(sk);
 }
 =

 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, b=
ool use_64bit)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cf90426ab725..313d488aae15 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -72,7 +72,7 @@ static struct socket *__mptcp_nmpc_socket(const struct mp=
tcp_sock *msk)
 /* Returns end sequence number of the receiver's advertised window */
 static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
-	return atomic64_read(&msk->wnd_end);
+	return READ_ONCE(msk->wnd_end);
 }
 =

 static bool mptcp_is_tcpsk(struct sock *sk)
@@ -370,7 +370,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 	/* Look for an acknowledged DATA_FIN */
 	if (((1 << sk->sk_state) &
 	     (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
-	    msk->write_seq =3D=3D atomic64_read(&msk->snd_una)) {
+	    msk->write_seq =3D=3D READ_ONCE(msk->snd_una)) {
 		mptcp_stop_timer(sk);
 =

 		WRITE_ONCE(msk->snd_data_fin_enable, 0);
@@ -750,7 +750,7 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 =

-void mptcp_data_acked(struct sock *sk)
+void __mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 =

@@ -983,11 +983,11 @@ static void mptcp_clean_una(struct sock *sk)
 	 * plain TCP
 	 */
 	if (__mptcp_check_fallback(msk))
-		atomic64_set(&msk->snd_una, msk->snd_nxt);
+		msk->snd_una =3D READ_ONCE(msk->snd_nxt);
 =

-	mptcp_data_lock(sk);
-	snd_una =3D atomic64_read(&msk->snd_una);
 =

+	mptcp_data_lock(sk);
+	snd_una =3D msk->snd_una;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
@@ -1268,10 +1268,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
 	/* Zero window and all data acked? Probe. */
 	avail_size =3D mptcp_check_allowed_size(msk, data_seq, avail_size);
 	if (avail_size =3D=3D 0) {
-		if (skb || atomic64_read(&msk->snd_una) !=3D msk->snd_nxt)
+		u64 snd_una =3D READ_ONCE(msk->snd_una);
+
+		if (skb || snd_una !=3D msk->snd_nxt)
 			return 0;
 		zero_window_probe =3D true;
-		data_seq =3D atomic64_read(&msk->snd_una) - 1;
+		data_seq =3D snd_una - 1;
 		avail_size =3D 1;
 	}
 =

@@ -1975,12 +1977,8 @@ static void mptcp_retransmit_handler(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->snd_nxt)) {
-		mptcp_stop_timer(sk);
-	} else {
-		set_bit(MPTCP_WORK_RTX, &msk->flags);
-		mptcp_schedule_work(sk);
-	}
+	set_bit(MPTCP_WORK_RTX, &msk->flags);
+	mptcp_schedule_work(sk);
 }
 =

 static void mptcp_retransmit_timer(struct timer_list *t)
@@ -2605,8 +2603,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
 	msk->snd_nxt =3D msk->write_seq;
-	atomic64_set(&msk->snd_una, msk->write_seq);
-	atomic64_set(&msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
+	msk->snd_una =3D msk->write_seq;
+	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 =

 	if (mp_opt->mp_capable) {
 		msk->can_ack =3D true;
@@ -2644,7 +2642,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, con=
st struct sock *ssk)
 	if (msk->rcvq_space.space =3D=3D 0)
 		msk->rcvq_space.space =3D TCP_INIT_CWND * TCP_MSS_DEFAULT;
 =

-	atomic64_set(&msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 =

 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
@@ -2902,7 +2900,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->ack_seq, ack_seq);
 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
-	atomic64_set(&msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->snd_una, msk->write_seq);
 =

 	mptcp_pm_new_connection(msk, 0);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5997d1ca5323..76a6a82d2585 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -222,8 +222,8 @@ struct mptcp_sock {
 	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
-	atomic64_t	snd_una;
-	atomic64_t	wnd_end;
+	u64		snd_una;
+	u64		wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
 	int		rmem_pending;
@@ -323,7 +323,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_tail(co=
nst struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (!before64(msk->snd_nxt, atomic64_read(&msk->snd_una)))
+	if (!before64(msk->snd_nxt, READ_ONCE(msk->snd_una)))
 		return NULL;
 =

 	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
@@ -497,7 +497,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const=
 struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
-void mptcp_data_acked(struct sock *sk);
+void __mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, b=
ool use_64bit);
 void __mptcp_flush_join_list(struct mptcp_sock *msk);
-- =

2.26.2

--===============1241155825998691365==--
