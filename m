Content-Type: multipart/mixed; boundary="===============4591124169105926982=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/8] mptcp: add accounting for pending data
Date: Thu, 24 Sep 2020 15:59:26 +0200
Message-ID: <c739dae79e30f700358f713fea3fefa3c437d1b5.1600955407.git.pabeni@redhat.com>
In-Reply-To: cover.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6018

--===============4591124169105926982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Preparation patch to track the data pending in the msk
write queue. No functional change introduced here

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index eb8c6d7a4b16..4338e43126fc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1829,6 +1829,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue =3D RB_ROOT;
+	msk->first_pending =3D NULL;
 =

 	msk->first =3D NULL;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d16b5fcaa9a8..ccabdfa8b2e3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -186,9 +186,10 @@ struct mptcp_pm_data {
 struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
-	int data_len;
-	int offset;
-	int overhead;
+	u16 data_len;
+	u16 offset;
+	u16 overhead;
+	u16 already_sent;
 	struct page *page;
 };
 =

@@ -217,6 +218,7 @@ struct mptcp_sock {
 	struct rb_root  out_of_order_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
+	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
@@ -238,6 +240,36 @@ static inline struct mptcp_sock *mptcp_sk(const struct=
 sock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *s=
k)
+{
+	const struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	return READ_ONCE(msk->first_pending);
+}
+
+static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_data_frag *cur;
+
+	cur =3D msk->first_pending;
+	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
+						     list_next_entry(cur, list);
+}
+
+static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock=
 *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (!msk->first_pending)
+		return NULL;
+
+	if (WARN_ON_ONCE(list_empty(&msk->rtx_queue)))
+		return NULL;
+
+	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
+}
+
 static inline struct mptcp_data_frag *mptcp_rtx_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-- =

2.26.2

--===============4591124169105926982==--
