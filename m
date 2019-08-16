Content-Type: multipart/mixed; boundary="===============4265608899557119008=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PRE-RFC 3/6] mptcp: update msk unacked sequence in sendmsg()
Date: Fri, 16 Aug 2019 18:48:01 +0200
Message-ID: <165e8c8bb1924963f285a6025e7582487758c561.1565970525.git.pabeni@redhat.com>
In-Reply-To: cover.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1648

--===============4265608899557119008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to walk all the subflows to update the msk unacked; so we
try to avoid doing it too often using the following heuristic:
we do the update only when the current value is outside the current
subflow's window size.

Note that any retransmission policy must be consistent with the above
heuristic.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 38 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b7ddbe64e4b..b7468f770d25 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -67,6 +67,40 @@ static inline bool mptcp_skb_can_collapse_to(const struc=
t mptcp_sock *msk,
 	return mpext && mpext->data_seq + mpext->data_len =3D=3D msk->write_seq;
 }
 =

+static u64 mptcp_update_msk_una(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct subflow_context *subflow;
+	u64 snd_una =3D msk->snd_una;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		u64 subflow_snd_una =3D READ_ONCE(subflow->snd_una);
+
+		if (after64(subflow_snd_una, snd_una))
+			snd_una =3D subflow_snd_una;
+	}
+	msk->snd_una =3D snd_una;
+	return snd_una;
+}
+
+static void mptcp_update_subflow_una(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct subflow_context *subflow;
+	u64 snd_una =3D msk->snd_una;
+
+	/* heuristic to avoid doing the expensive data ack update frequently */
+	if (snd_una + tcp_sk(sk)->snd_cwnd <=3D msk->write_seq)
+		snd_una =3D mptcp_update_msk_una(sk);
+
+	/* if we msk just switched to this subflow, update subflow's una
+	 * to allow 32 bit ack update to be more accurate
+	 */
+	subflow =3D subflow_ctx(ssk);
+	if (after64(snd_una, subflow->snd_una))
+		subflow->snd_una =3D snd_una;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, long *timeo, int *pmss_now,
 			      int *ps_goal)
@@ -209,6 +243,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	}
 =

 	lock_sock(ssk);
+	mptcp_update_subflow_una(sk, ssk);
+
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo, &mss_now,
@@ -668,6 +704,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
+		msk->snd_una =3D msk->write_seq;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
@@ -804,6 +841,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
+		msk->snd_una =3D msk->write_seq;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e37fd4bcd904..9220afe0d362 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		ack_seq;
+	u64		snd_una;
 	u32		token;
 	u16		dport;
 	struct list_head conn_list;
-- =

2.20.1


--===============4265608899557119008==--
