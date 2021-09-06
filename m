Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BD72
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 06:06:38 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mN7m8-0008R7-Js; Mon, 06 Sep 2021 08:06:36 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [mptcp-next 2/2] mptcp: re-set push-pending bit on retransmit failure
Date: Mon,  6 Sep 2021 08:06:14 +0200
Message-Id: <20210906060614.25217-3-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906060614.25217-1-fw@strlen.de>
References: <20210906060614.25217-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The retransmit head will be NULL in case there is no in-flight data
(meaning all data injected into network has been acked).

In that case the retransmit timer is stopped.

This is only correct if there is no more pending, not-yet-sent data.

If there is, the retransmit timer needs to set the PENDING bit again so
that mptcp tries to send the remaining (new) data once a subflow can accept
more data.

Also, mptcp_subflow_get_retrans() has to be called unconditionally.
This function checks for subflows that have become unresponsive and marks
them as stale, so in the case where the rtx queue is empty, subflows
will never be marked stale which prevents available backup subflows from
becoming eligible for transmit.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c0e0ee4cb24f..b88a9b61025b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1105,7 +1105,8 @@ static void __mptcp_clean_una(struct sock *sk)
 	if (cleaned && tcp_under_memory_pressure(sk))
 		__mptcp_mem_reclaim_partial(sk);
 
-	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
+	if (snd_una == READ_ONCE(msk->snd_nxt) &&
+	    snd_una == READ_ONCE(msk->write_seq)) {
 		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_timer(sk);
 	} else {
@@ -1547,6 +1548,13 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_check_and_set_pending(struct sock *sk)
+{
+	if (mptcp_send_head(sk) &&
+	    !test_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
+		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
@@ -1603,6 +1611,13 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_push_release(sk, ssk, &info);
 
 out:
+	/* Set PENDING again in case we found an ssk
+	 * that could not accept more data
+	 */
+	if (unlikely(copied == 0) &&
+	    READ_ONCE(msk->snd_una) == msk->snd_nxt && ssk)
+		mptcp_check_and_set_pending(sk);
+
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -2414,6 +2429,9 @@ static void __mptcp_retrans(struct sock *sk)
 	int ret;
 
 	mptcp_clean_una_wakeup(sk);
+
+	/* first check ssk: need to kick "stale" logic */
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2426,10 +2444,12 @@ static void __mptcp_retrans(struct sock *sk)
 			goto reset_timer;
 		}
 
-		return;
+		if (!mptcp_send_head(sk))
+			return;
+
+		goto reset_timer;
 	}
 
-	ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_timer;
 
@@ -2456,6 +2476,8 @@ static void __mptcp_retrans(struct sock *sk)
 	release_sock(ssk);
 
 reset_timer:
+	mptcp_check_and_set_pending(sk);
+
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 }
-- 
2.32.0

