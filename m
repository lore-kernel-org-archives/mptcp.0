Content-Type: multipart/mixed; boundary="===============4142324953250533021=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/6] mptcp: split mptcp_clean_una function
Date: Fri, 30 Oct 2020 15:45:04 -0700
Message-ID: <20201030224506.108377-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201030224506.108377-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6495

--===============4142324953250533021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

mptcp_clean_una() will wake writers in case memory could be reclaimed.
When called from mptcp_sendmsg the wakeup code isn't needed.

Move the wakeup to a new helper and then use that from the mptcp worker.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 25d12183d1ca..b84b84adc9ad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -853,19 +853,25 @@ static void mptcp_clean_una(struct sock *sk)
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

@@ -1769,7 +1775,7 @@ static void mptcp_worker(struct work_struct *work)
 	long timeo =3D 0;
 =

 	lock_sock(sk);
-	mptcp_clean_una(sk);
+	mptcp_clean_una_wakeup(sk);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-- =

2.29.2

--===============4142324953250533021==--
