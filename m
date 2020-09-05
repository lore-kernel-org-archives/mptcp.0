Content-Type: multipart/mixed; boundary="===============0843262226659207274=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC mptcp-next 1/3] mptcp: split mptcp_clean_una function
Date: Sat, 05 Sep 2020 12:33:22 +0200
Message-ID: <20200905103324.27066-2-fw@strlen.de>
In-Reply-To: 20200905103324.27066-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5728

--===============0843262226659207274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_clean_una() will wake writes in case memory could be reclaimed.
However, when called from mptcp_sendmsg the wakeup isn't needed.

Split the helper and then call the 'lighter' function when we do not
need a wakeup.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3b621a99c8c5..15ecb471602c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -791,7 +791,7 @@ static bool mptcp_is_writeable(struct mptcp_sock *msk)
 	return false;
 }
 =

-static void mptcp_clean_una(struct sock *sk)
+static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
@@ -829,19 +829,25 @@ static void mptcp_clean_una(struct sock *sk)
 	}
 =

 out:
-	if (cleaned) {
+	if (cleaned)
 		sk_mem_reclaim_partial(sk);
+}
 =

-		/* Only wake up writers if a subflow is ready */
-		if (mptcp_is_writeable(msk)) {
-			set_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags);
-			smp_mb__after_atomic();
+static void mptcp_clean_una(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-			/* set SEND_SPACE before sk_stream_write_space clears
-			 * NOSPACE
-			 */
-			sk_stream_write_space(sk);
-		}
+	__mptcp_clean_una(sk);
+
+	/* Only wake up writers if a subflow is ready */
+	if (mptcp_is_writeable(msk)) {
+		set_bit(MPTCP_SEND_SPACE, &msk->flags);
+		smp_mb__after_atomic();
+
+		/* set SEND_SPACE before sk_stream_write_space clears
+		 * NOSPACE
+		 */
+		sk_stream_write_space(sk);
 	}
 }
 =

@@ -1186,7 +1192,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	pfrag =3D sk_page_frag(sk);
 restart:
-	mptcp_clean_una(sk);
+	__mptcp_clean_una(sk);
 =

 	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
 		ret =3D -EPIPE;
@@ -1216,7 +1222,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		if (ret)
 			goto out;
 =

-		mptcp_clean_una(sk);
+		__mptcp_clean_una(sk);
 =

 		ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
 		if (list_empty(&msk->conn_list)) {
@@ -1282,7 +1288,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		if (unlikely(!sk_stream_memory_free(sk))) {
 			tcp_push(ssk, msg->msg_flags, mss_now,
 				 tcp_sk(ssk)->nonagle, size_goal);
-			mptcp_clean_una(sk);
+			__mptcp_clean_una(sk);
 			if (!sk_stream_memory_free(sk)) {
 				/* can't send more for now, need to wait for
 				 * MPTCP-level ACKs from peer.
-- =

2.26.2

--===============0843262226659207274==--
