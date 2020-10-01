Content-Type: multipart/mixed; boundary="===============8727454281132672568=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 07/13] mptcp: introduce MPTCP snd_nxt
Date: Thu, 01 Oct 2020 16:08:08 +0200
Message-ID: <82295a73665537a6ff9f9458a1167bffb963da13.1601552158.git.pabeni@redhat.com>
In-Reply-To: cover.1601552158.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6134

--===============8727454281132672568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Track the next MPTCP sequence numer used on xmit,
currently always equal to write_next.

Signed-of-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  4 ++--
 net/mptcp/protocol.c |  7 +++++--
 net/mptcp/protocol.h | 17 +++++++++--------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dde4340fca1f..902f98a0f039 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -794,7 +794,7 @@ static void update_una(struct mptcp_sock *msk,
 		       struct mptcp_options_received *mp_opt)
 {
 	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
-	u64 write_seq =3D READ_ONCE(msk->write_seq);
+	u64 snd_nxt =3D READ_ONCE(msk->snd_nxt);
 =

 	/* avoid ack expansion on update conflict, to reduce the risk of
 	 * wrongly expanding to a future ack sequence number, which is way
@@ -803,7 +803,7 @@ static void update_una(struct mptcp_sock *msk,
 	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 =

 	/* ACK for data not even sent yet? Ignore. */
-	if (after64(new_snd_una, write_seq))
+	if (after64(new_snd_una, snd_nxt))
 		new_snd_una =3D old_snd_una;
 =

 	while (after64(new_snd_una, old_snd_una)) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a0f459f9aaf0..5b8376710df6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -814,7 +814,7 @@ static void mptcp_clean_una(struct sock *sk)
 	 * plain TCP
 	 */
 	if (__mptcp_check_fallback(msk))
-		atomic64_set(&msk->snd_una, msk->write_seq);
+		atomic64_set(&msk->snd_una, msk->snd_nxt);
 	snd_una =3D atomic64_read(&msk->snd_una);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
@@ -1327,6 +1327,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	release_sock(ssk);
 out:
+	msk->snd_nxt =3D msk->write_seq;
 	ssk_check_wmem(msk);
 	release_sock(sk);
 	return copied ? : ret;
@@ -1618,7 +1619,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->write_seq)) {
+	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->snd_nxt)) {
 		mptcp_stop_timer(sk);
 	} else {
 		set_bit(MPTCP_WORK_RTX, &msk->flags);
@@ -2075,6 +2076,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	WRITE_ONCE(msk->fully_established, false);
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
+	msk->snd_nxt =3D msk->write_seq;
 	atomic64_set(&msk->snd_una, msk->write_seq);
 	if (mp_opt->mp_capable) {
 		msk->can_ack =3D true;
@@ -2386,6 +2388,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->local_key, subflow->local_key);
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	atomic64_set(&msk->snd_una, msk->write_seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 683497e0375e..f7ffed685640 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,6 +91,13 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
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
@@ -200,6 +207,7 @@ struct mptcp_sock {
 	u64		local_key;
 	u64		remote_key;
 	u64		write_seq;
+	u64		snd_nxt;
 	u64		ack_seq;
 	u64		rcv_data_fin_seq;
 	struct sock	*last_snd;
@@ -274,7 +282,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_tail(co=
nst struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (list_empty(&msk->rtx_queue))
+	if (!before64(msk->snd_nxt, atomic64_read(&msk->snd_una)))
 		return NULL;
 =

 	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
@@ -524,13 +532,6 @@ static inline struct mptcp_ext *mptcp_get_ext(struct s=
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

--===============8727454281132672568==--
