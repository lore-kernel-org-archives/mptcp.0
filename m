Content-Type: multipart/mixed; boundary="===============9210351374542705629=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 07/13] mptcp: introduce MPTCP snd_nxt
Date: Thu, 12 Nov 2020 11:48:05 +0100
Message-ID: <2386f88b27df9919e96da14b59576be9b4b9f490.1605175834.git.pabeni@redhat.com>
In-Reply-To: cover.1605175834.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6677

--===============9210351374542705629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Track the next MPTCP sequence number used on xmit,
currently always equal to write_next.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  4 ++--
 net/mptcp/protocol.c |  7 +++++--
 net/mptcp/protocol.h | 17 +++++++++--------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a044dd43411d..a6b57021b6d0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -813,7 +813,7 @@ static void update_una(struct mptcp_sock *msk,
 		       struct mptcp_options_received *mp_opt)
 {
 	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
-	u64 write_seq =3D READ_ONCE(msk->write_seq);
+	u64 snd_nxt =3D READ_ONCE(msk->snd_nxt);
 =

 	/* avoid ack expansion on update conflict, to reduce the risk of
 	 * wrongly expanding to a future ack sequence number, which is way
@@ -822,7 +822,7 @@ static void update_una(struct mptcp_sock *msk,
 	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 =

 	/* ACK for data not even sent yet? Ignore. */
-	if (after64(new_snd_una, write_seq))
+	if (after64(new_snd_una, snd_nxt))
 		new_snd_una =3D old_snd_una;
 =

 	while (after64(new_snd_una, old_snd_una)) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c07bed2bd28..441d283cf9df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -834,7 +834,7 @@ static void mptcp_clean_una(struct sock *sk)
 	 * plain TCP
 	 */
 	if (__mptcp_check_fallback(msk))
-		atomic64_set(&msk->snd_una, msk->write_seq);
+		atomic64_set(&msk->snd_una, msk->snd_nxt);
 	snd_una =3D atomic64_read(&msk->snd_una);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
@@ -1338,6 +1338,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	release_sock(ssk);
 out:
+	msk->snd_nxt =3D msk->write_seq;
 	ssk_check_wmem(msk);
 	release_sock(sk);
 	return copied ? : ret;
@@ -1629,7 +1630,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->write_seq)) {
+	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->snd_nxt)) {
 		mptcp_stop_timer(sk);
 	} else {
 		set_bit(MPTCP_WORK_RTX, &msk->flags);
@@ -2100,6 +2101,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	WRITE_ONCE(msk->fully_established, false);
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
+	msk->snd_nxt =3D msk->write_seq;
 	atomic64_set(&msk->snd_una, msk->write_seq);
 	if (mp_opt->mp_capable) {
 		msk->can_ack =3D true;
@@ -2409,6 +2411,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->local_key, subflow->local_key);
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	atomic64_set(&msk->snd_una, msk->write_seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ec17f9c367c5..946319cf9cca 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -92,6 +92,13 @@
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
 =

+static inline bool before64(__u64 seq1, __u64 seq2)
+{
+	return (__s64)(seq1 - seq2) < 0;
+}
+
+#define after64(seq2, seq1)	before64(seq1, seq2)
+
 struct mptcp_options_received {
 	u64	sndr_key;
 	u64	rcvr_key;
@@ -201,6 +208,7 @@ struct mptcp_sock {
 	u64		local_key;
 	u64		remote_key;
 	u64		write_seq;
+	u64		snd_nxt;
 	u64		ack_seq;
 	u64		rcv_data_fin_seq;
 	struct sock	*last_snd;
@@ -276,7 +284,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_tail(co=
nst struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (list_empty(&msk->rtx_queue))
+	if (!before64(msk->snd_nxt, atomic64_read(&msk->snd_una)))
 		return NULL;
 =

 	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
@@ -528,13 +536,6 @@ static inline struct mptcp_ext *mptcp_get_ext(struct s=
k_buff *skb)
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
 }
 =

-static inline bool before64(__u64 seq1, __u64 seq2)
-{
-	return (__s64)(seq1 - seq2) < 0;
-}
-
-#define after64(seq2, seq1)	before64(seq1, seq2)
-
 void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops);
 =

 static inline bool __mptcp_check_fallback(const struct mptcp_sock *msk)
-- =

2.26.2

--===============9210351374542705629==--
