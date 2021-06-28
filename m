Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A370
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624896431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzgr9QyEyXxYc62/8mK4xCy3WdPNc8XILao2YCxQLsw=;
	b=bDc70HwwJajxTNCKTXBQ3MrlOolrg8ft4Hg/QGZo9F6ja+GSaH3+Ls8GR4rXn/wyMRNPwa
	Eb54pGQj9O5Kyv79Ckil7Rqr1mzyH2GNx39vaLzQChQN1VDVuS3FWRsdU4QJeweVF+YRgk
	m4LuaYzt1fIulXvkwThOtNfiJh+Jb+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-i9c-_5GiM9ifBesse2dKwg-1; Mon, 28 Jun 2021 12:05:53 -0400
X-MC-Unique: i9c-_5GiM9ifBesse2dKwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E24F48BB8B6
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 15:54:28 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-129.ams2.redhat.com [10.36.114.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC4660875;
	Mon, 28 Jun 2021 15:54:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [PATCH mptcp-next 3/7] mptcp: handle pending data on closed subflow
Date: Mon, 28 Jun 2021 17:54:07 +0200
Message-Id: <081be14b501647e52b6fc0647ef6b46738dde78a.1624895054.git.pabeni@redhat.com>
In-Reply-To: <cover.1624895054.git.pabeni@redhat.com>
References: <cover.1624895054.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 net/mptcp/options.c  |  9 ++++++---
 net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b5850afea343..c82ad34a0abc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -975,9 +975,12 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	old_snd_una = msk->snd_una;
 	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 
-	/* ACK for data not even sent yet? Ignore. */
-	if (after64(new_snd_una, snd_nxt))
-		new_snd_una = old_snd_una;
+	/* ACK for data not even sent yet and even above recovery bound? Ignore.*/
+	if (unlikely(after64(new_snd_una, snd_nxt))) {
+		if (!READ_ONCE(msk->recovery) ||
+		    after64(new_snd_una, READ_ONCE(msk->recovery_snd_nxt)))
+			new_snd_una = old_snd_una;
+	}
 
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 51f608831fae..b0a7eba202fc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1032,6 +1032,9 @@ static void __mptcp_clean_una(struct sock *sk)
 	if (__mptcp_check_fallback(msk))
 		msk->snd_una = READ_ONCE(msk->snd_nxt);
 
+	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt))
+		WRITE_ONCE(msk->recovery, false);
+
 	snd_una = msk->snd_una;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
@@ -2135,6 +2138,45 @@ static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 	}
 }
 
+bool __mptcp_retransmit_pending_data(struct sock *sk, const struct sock *ssk)
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
+	mptcp_clean_una_wakeup(sk);
+	rtx_head = mptcp_rtx_head(sk);
+	if (!rtx_head)
+		return false;
+
+	/* will accept ack for reijected data before re-sending them */
+	if (!msk->recovery || after64(msk->snd_nxt, msk->recovery_snd_nxt))
+		WRITE_ONCE(msk->recovery_snd_nxt, msk->snd_nxt);
+	WRITE_ONCE(msk->recovery, true);
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
+	return true;
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2147,6 +2189,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			      struct mptcp_subflow_context *subflow)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool need_push;
 
 	list_del(&subflow->node);
 
@@ -2158,6 +2201,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (ssk->sk_socket)
 		sock_orphan(ssk);
 
+	need_push = __mptcp_retransmit_pending_data(sk, ssk);
 	subflow->disposable = 1;
 
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
@@ -2185,6 +2229,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	if (msk->subflow && ssk == msk->subflow->sk)
 		mptcp_dispose_initial_subflow(msk);
+
+	if (need_push)
+		__mptcp_push_pending(sk, 0);
 }
 
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
@@ -2397,6 +2444,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->recovery, false);
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6a3cbdb597e2..0218b777cdc3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -222,6 +222,7 @@ struct mptcp_sock {
 	u64		local_key;
 	u64		remote_key;
 	u64		write_seq;
+	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq */
 	u64		snd_nxt;
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
@@ -236,6 +237,7 @@ struct mptcp_sock {
 	u32		token;
 	int		rmem_released;
 	unsigned long	flags;
+	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
 	bool		rcv_data_fin;
@@ -557,6 +559,7 @@ int mptcp_is_checksum_enabled(struct net *net);
 int mptcp_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
+bool __mptcp_retransmit_pending_data(struct sock *sk, const struct sock *ssk);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
-- 
2.26.3

