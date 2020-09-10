Content-Type: multipart/mixed; boundary="===============9173591611661825199=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: split mptcp_clean_una function
Date: Thu, 10 Sep 2020 18:36:30 +0200
Message-ID: <20200910163630.8137-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5787

--===============9173591611661825199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_clean_una() will wake writers in case memory could be reclaimed.
When called from mptcp_sendmsg the wakeup code isn't needed.

Move the wakeup to a new helper and then use that from the mptcp worker.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

 Sending this ahead of the rebase on top of paolos patchset,
 I think this can be integrated stand-alone as it has no dependency
 on sendmsg refactor or poll rework.

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7469e89b3d7a..3c2476baae2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -831,19 +831,25 @@ static void mptcp_clean_una(struct sock *sk)
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
+static void mptcp_clean_una_wakeup(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-			/* set SEND_SPACE before sk_stream_write_space clears
-			 * NOSPACE
-			 */
-			sk_stream_write_space(sk);
-		}
+	mptcp_clean_una(sk);
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

@@ -1724,7 +1730,7 @@ static void mptcp_worker(struct work_struct *work)
 	long timeo =3D 0;
 =

 	lock_sock(sk);
-	mptcp_clean_una(sk);
+	mptcp_clean_una_wakeup(sk);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 	__mptcp_move_skbs(msk);
-- =

2.26.2

--===============9173591611661825199==--
