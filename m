Content-Type: multipart/mixed; boundary="===============0223926465621727158=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] mptcp: re-check dsn before reading from subflow
Date: Thu, 27 Feb 2020 09:39:35 +0100
Message-ID: <20200227083935.11585-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3815

--===============0223926465621727158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_subflow_data_available() is commonly called via
ssk->sk_data_ready(), in this case the mptcp socket lock
cannot be acquired.

Therefore, while we can safely discard subflow data that
was already received up to msk->ack_seq, we cannot be sure
that 'subflow->data_avail' will still be valid at the time
userspace wants to read the data -- a previous read on a
different subflow might have carried this data already.

In that (unlikely) event, msk->ack_seq will have been updated
and will be ahead of the subflow dsn.

We can check for this condition and skip/resync to the expected
sequence number.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 I could also submit this directly for net-next, but this
 patch is only needed w. MP_JOIN support.

 net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 53a2b0ba2241..8f2fc72fc5ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -121,6 +121,27 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, s=
truct sock *ssk,
 	MPTCP_SKB_CB(skb)->offset =3D offset;
 }
 =

+/* both sockets must be locked */
+static bool mptcp_subflow_dsn_valid(const struct mptcp_sock *msk,
+				    struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	u64 dsn =3D mptcp_subflow_get_mapped_dsn(subflow);
+
+	/* revalidate data sequence number.
+	 *
+	 * mptcp_subflow_data_available() is usually called
+	 * without msk lock.  Its unlikely (but possible)
+	 * that msk->ack_seq has been advanced since the last
+	 * call found in-sequence data.
+	 */
+	if (likely(dsn =3D=3D msk->ack_seq))
+		return true;
+
+	subflow->data_avail =3D 0;
+	return mptcp_subflow_data_available(ssk);
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -133,6 +154,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 	bool done =3D false;
 	int rcvbuf;
 =

+	if (!mptcp_subflow_dsn_valid(msk, ssk)) {
+		*bytes =3D 0;
+		return false;
+	}
+
 	rcvbuf =3D max(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 	if (rcvbuf > sk->sk_rcvbuf)
 		sk->sk_rcvbuf =3D rcvbuf;
-- =

2.24.1

--===============0223926465621727158==--
