Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1FB2FAF
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKR7Q1eKFIjxHZMopGUslG52zEzJeD6uqPnigoD1sf4=;
	b=eHnLvzSL4SrVYXi6WHtvlBV4qzW2HjIi6/+4CSJ2FOb/qhivdyRytlVsOLy5pWci0aqOwh
	WPf13fRET5sX2oNn13NNxPKPQ3MmR7NRERAMt2I4TGREcDPoq7Rx07sDXPtQMQkRhdQB0o
	blhTMgItkBNYQY6S9R2sljSalhJKLtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-71zI64vrPHCFqga-TwuwOA-1; Tue, 13 Jul 2021 17:13:54 -0400
X-MC-Unique: 71zI64vrPHCFqga-TwuwOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A56C804140
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:53 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5B8B60C9F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/8] mptcp: handle pending data on closed subflow
Date: Tue, 13 Jul 2021 23:13:33 +0200
Message-Id: <e673c86fec66674209eb663eae277562649a2fc2.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The PM can close active subflow, e.g. due to ingress RM_ADDR
option. Such subflow could carry data still unacked at the
MPTCP-level, both in the write and the rtx_queue, which has
never reached the other peer.

Currently the mptcp-level retransmission will deliver such data,
but at a very low rate (at most 1 DSM for each MPTCP rtx interval).

We can speed-up the recovery a lot, moving all the unacked in the
tcp write_queue, so that it will be pushed again via other
subflows, at the speed allowed by them.

Also make available the new helper for later patches.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/207
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - drop ssk argument from __mptcp_retransmit_pending_data() - Mat
 - in recovery mode clean_una() must accept moving after first_pending
 - move 'recovery' under data_lock protection, to avoid a bunch of
   ONCE annotation
---
 net/mptcp/options.c  |  8 +++--
 net/mptcp/protocol.c | 76 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  6 ++++
 3 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4452455aef7f..e37b6f2fb514 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -975,9 +975,11 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	old_snd_una = msk->snd_una;
 	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 
-	/* ACK for data not even sent yet? Ignore. */
-	if (after64(new_snd_una, snd_nxt))
-		new_snd_una = old_snd_una;
+	/* ACK for data not even sent yet and even above recovery bound? Ignore.*/
+	if (unlikely(after64(new_snd_una, snd_nxt))) {
+		if (!msk->recovery || after64(new_snd_una, msk->recovery_snd_nxt))
+			new_snd_una = old_snd_una;
+	}
 
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9000ca326225..7fe4c17fb4f5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1055,8 +1055,14 @@ static void __mptcp_clean_una(struct sock *sk)
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
 
-		if (WARN_ON_ONCE(dfrag == msk->first_pending))
-			break;
+		if (unlikely(dfrag == msk->first_pending)) {
+			/* in recovery mode can see ack after the current snd head */
+			if (WARN_ON_ONCE(!msk->recovery))
+				break;
+
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		}
+
 		dfrag_clear(sk, dfrag);
 		cleaned = true;
 	}
@@ -1065,8 +1071,14 @@ static void __mptcp_clean_una(struct sock *sk)
 	if (dfrag && after64(snd_una, dfrag->data_seq)) {
 		u64 delta = snd_una - dfrag->data_seq;
 
-		if (WARN_ON_ONCE(delta > dfrag->already_sent))
-			goto out;
+		/* prevent wrap around in recovery mode */
+		if (unlikely(delta > dfrag->already_sent)) {
+			if (WARN_ON_ONCE(!msk->recovery))
+				goto out;
+			if (WARN_ON_ONCE(delta > dfrag->data_len))
+				goto out;
+			dfrag->already_sent += delta - dfrag->already_sent;
+		}
 
 		dfrag->data_seq += delta;
 		dfrag->offset += delta;
@@ -1077,6 +1089,10 @@ static void __mptcp_clean_una(struct sock *sk)
 		cleaned = true;
 	}
 
+	/* all retransmitted data acked, recovery completed */
+	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt))
+		msk->recovery = false;
+
 out:
 	if (cleaned) {
 		if (tcp_under_memory_pressure(sk)) {
@@ -1085,7 +1101,7 @@ static void __mptcp_clean_una(struct sock *sk)
 		}
 	}
 
-	if (snd_una == READ_ONCE(msk->snd_nxt)) {
+	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
 		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_timer(sk);
 	} else {
@@ -2148,6 +2164,50 @@ static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 	}
 }
 
+bool __mptcp_retransmit_pending_data(struct sock *sk)
+{
+	struct mptcp_data_frag *cur, *rtx_head;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (__mptcp_check_fallback(mptcp_sk(sk)))
+		return false;
+
+	if (tcp_rtx_and_write_queues_empty(sk))
+		return false;
+
+	/* the closing socket has some data untransmitted and/or unacked:
+	 * some data in the mptcp rtx queue has not really xmitted yet.
+	 * keep it simple and re-inject the whole mptcp level rtx queue
+	 */
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	rtx_head = mptcp_rtx_head(sk);
+	if (!rtx_head) {
+		mptcp_data_unlock(sk);
+		return false;
+	}
+
+	/* will accept ack for reijected data before re-sending them */
+	if (!msk->recovery || after64(msk->snd_nxt, msk->recovery_snd_nxt))
+		msk->recovery_snd_nxt = msk->snd_nxt;
+	msk->recovery = true;
+	mptcp_data_unlock(sk);
+
+	msk->first_pending = rtx_head;
+	msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
+	msk->snd_nxt = rtx_head->data_seq;
+	msk->snd_burst = 0;
+
+	/* be sure to clear the "sent status" on all re-injected fragments */
+	list_for_each_entry(cur, &msk->rtx_queue, list) {
+		if (!cur->already_sent)
+			break;
+		cur->already_sent = 0;
+	}
+
+	return true;
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2160,6 +2220,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			      struct mptcp_subflow_context *subflow)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool need_push;
 
 	list_del(&subflow->node);
 
@@ -2171,6 +2232,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (ssk->sk_socket)
 		sock_orphan(ssk);
 
+	need_push = __mptcp_retransmit_pending_data(sk);
 	subflow->disposable = 1;
 
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
@@ -2198,6 +2260,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	if (msk->subflow && ssk == msk->subflow->sk)
 		mptcp_dispose_initial_subflow(msk);
+
+	if (need_push)
+		__mptcp_push_pending(sk, 0);
 }
 
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
@@ -2410,6 +2475,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6a3cbdb597e2..6f55784a2efd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -230,12 +230,17 @@ struct mptcp_sock {
 	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
+	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
+						 * recovery related fields are under data_lock
+						 * protection
+						 */
 	u64		snd_una;
 	u64		wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
 	int		rmem_released;
 	unsigned long	flags;
+	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
 	bool		rcv_data_fin;
@@ -557,6 +562,7 @@ int mptcp_is_checksum_enabled(struct net *net);
 int mptcp_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
+bool __mptcp_retransmit_pending_data(struct sock *sk);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
-- 
2.26.3

