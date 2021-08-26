Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F523FCB
	for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 23:58:48 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mJP1x-000377-TU; Fri, 27 Aug 2021 01:43:33 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp] mptcp: do not shrink snd_nxt when recovering
Date: Fri, 27 Aug 2021 01:43:24 +0200
Message-Id: <20210826234324.27764-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When recovering after a link failure, snd_nxt should not be set to a
lower value.  Else, update of snd_nxt is broken because:

  msk->snd_nxt += ret; (where ret is number of bytes sent)

assumes that snd_nxt always moves forward.
After reduction, its possible that snd_nxt update gets out of sync:
dfrag we just sent might have had a data sequence number even past
snd_nxt_recovery.

This change factors the common msk state update to a helper
and updates snd_nxt based on the current dfrag data sequence number.

The conditional is required for the recovery phase where we may
re-transmit old dfrags that are before current snd_nxt.

After this change, snd_nxt only moves forward and covers all in-sequence
data that was transmitted.

recovery_snd_nxt is retained to detect when recovery has completed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Paolo, I think this is in line with what we discussed earlier today.

 This does NOT resolve issues/226, but as far as i can tell the
 failure rate is cut in half: 500 runs of mptcp_join -l had 24 vs. 7
 failures.

 I also no longer see

 ack_update_msk: invalid una (96072 or 424988 bytes, 1 below write_seq, cnt 22715

 debug log from ack_update_msk(), printed when we ignore advertised
 new_snd_una while msk->recovery flag is set.

 net/mptcp/options.c  |  8 +++-----
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f5fa8e7efd9c..12fcf7553d08 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1019,11 +1019,9 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	old_snd_una = msk->snd_una;
 	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 
-	/* ACK for data not even sent yet and even above recovery bound? Ignore.*/
-	if (unlikely(after64(new_snd_una, snd_nxt))) {
-		if (!msk->recovery || after64(new_snd_una, msk->recovery_snd_nxt))
-			new_snd_una = old_snd_una;
-	}
+	/* ACK for data not even sent yet? Ignore.*/
+	if (unlikely(after64(new_snd_una, snd_nxt)))
+		new_snd_una = old_snd_una;
 
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index af8f677162f3..385405cf4626 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1507,6 +1507,34 @@ static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 	release_sock(ssk);
 }
 
+static void mptcp_update_post_push(struct mptcp_sock *msk,
+				   struct mptcp_data_frag *dfrag,
+				   u32 sent)
+{
+	u64 snd_nxt_new = dfrag->data_seq;
+
+	dfrag->already_sent += sent;
+
+	msk->snd_burst -= sent;
+	msk->tx_pending_data -= sent;
+
+	snd_nxt_new += dfrag->already_sent;
+
+	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
+	 * is recovering after a failover. In that event, this re-sends
+	 * old segments.
+	 *
+	 * Thus compute snd_nxt_new candidate based on
+	 * the dfrag->data_seq that was sent and the data
+	 * that has been handed to the subflow for transmission
+	 * and skip update in case it was old dfrag.
+	 */
+	if (likely(after64(snd_nxt_new, msk->snd_nxt)))
+		msk->snd_nxt = snd_nxt_new;
+
+	WARN_ON_ONCE(after64(msk->snd_nxt, msk->write_seq));
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
@@ -1550,12 +1578,10 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			}
 
 			info.sent += ret;
-			dfrag->already_sent += ret;
-			msk->snd_nxt += ret;
-			msk->snd_burst -= ret;
-			msk->tx_pending_data -= ret;
 			copied += ret;
 			len -= ret;
+
+			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
@@ -1608,13 +1634,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 				goto out;
 
 			info.sent += ret;
-			dfrag->already_sent += ret;
-			msk->snd_nxt += ret;
-			msk->snd_burst -= ret;
-			msk->tx_pending_data -= ret;
 			copied += ret;
 			len -= ret;
 			first = false;
+
+			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
@@ -2212,15 +2236,12 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 		return false;
 	}
 
-	/* will accept ack for reijected data before re-sending them */
-	if (!msk->recovery || after64(msk->snd_nxt, msk->recovery_snd_nxt))
-		msk->recovery_snd_nxt = msk->snd_nxt;
+	msk->recovery_snd_nxt = msk->snd_nxt;
 	msk->recovery = true;
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
 	msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
-	msk->snd_nxt = rtx_head->data_seq;
 	msk->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
-- 
2.31.1

