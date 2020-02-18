Content-Type: multipart/mixed; boundary="===============2373455800820480654=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 5/6] mptcp: protocol: re-check dsn before reading
 from subflow
Date: Tue, 18 Feb 2020 13:21:09 +0100
Message-ID: <20200218122110.23817-6-fw@strlen.de>
In-Reply-To: 20200218122110.23817-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3697

--===============2373455800820480654==
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
 net/mptcp/protocol.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 75ae03931963..02aba8b31f1f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -205,8 +205,24 @@ static struct sock *mptcp_subflow_recv_lookup(const st=
ruct mptcp_sock *msk)
 	sock_owned_by_me(sk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		if (subflow->data_avail)
-			return mptcp_subflow_tcp_sock(subflow);
+		if (subflow->data_avail) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			u64 dsn =3D mptcp_subflow_get_mapped_dsn(subflow);
+
+			/* revalidate data sequence number.
+			 *
+			 * mptcp_subflow_data_available() is usually called
+			 * without msk lock.  Its unlikely (but possible)
+			 * that msk->ack_seq has been advanced since the last
+			 * call found in-sequence data.
+			 */
+			if (likely(dsn =3D=3D msk->ack_seq))
+				return ssk;
+
+			subflow->data_avail =3D 0;
+			if (mptcp_subflow_data_available(ssk))
+				return ssk;
+		}
 	}
 =

 	return NULL;
-- =

2.24.1

--===============2373455800820480654==--
