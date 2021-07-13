Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F552F80
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTfQ+edTGC+0sRxo8MduzJD4IpBx14QFWV8OqEDbnD0=;
	b=I1ZbehACO4a9FKTK3DhZArpD4vIYH7PCHFhR1fdgoj141Ct2m9djAgXo409+KShuAjBgj9
	zBOtjFI+hIDhK8wk1803acQ+eLkC8aKl30Pu/sm7PtU2Yd9ztV88h48NatpjvArDT9RWAn
	ySd583syXvGRf4060GvKnJ2+9BzaA1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-qCcdC7M8OKqkFUONrEm-vw-1; Tue, 13 Jul 2021 17:13:52 -0400
X-MC-Unique: qCcdC7M8OKqkFUONrEm-vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373F38015C6
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:52 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2E060C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/8] mptcp: less aggressive retransmission stragegy
Date: Tue, 13 Jul 2021 23:13:32 +0200
Message-Id: <207a921d8455b68061b4438b8b9441c871add744.1626210682.git.pabeni@redhat.com>
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

The current mptcp re-inject strategy is very aggressive,
we have mptcp-level retransmissions even on single subflow
connection, if the link in-use is lossy.

Let's be a little more conservative: we do retransmit
only if at least a subflow has write and rtx queue empty.

Additionally use the backup subflows only if the active
subflows are stale - no progresses in at least an rtx period
and ignore stale subflows for rtx timeout update

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/207
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - skip subflow with stale_count > 0 in rtx time update
---
 net/mptcp/pm.c       | 17 +++++++++++++++++
 net/mptcp/protocol.c | 25 ++++++++++++++++---------
 net/mptcp/protocol.h |  5 ++++-
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 639271e09604..9ff17c5205ce 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -308,6 +308,23 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	u32 rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
+
+	/* keep track of rtx periods with no progress */
+	if (!subflow->stale_count) {
+		subflow->stale_rcv_tstamp = rcv_tstamp;
+		subflow->stale_count++;
+	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
+		if (subflow->stale_count < U8_MAX)
+			subflow->stale_count++;
+	} else {
+		subflow->stale_count = 0;
+	}
+}
+
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	msk->pm.add_addr_signaled = 0;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 19d734825928..9000ca326225 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -420,7 +420,8 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-	return inet_csk(ssk)->icsk_pending ? inet_csk(ssk)->icsk_timeout - jiffies : 0;
+	return inet_csk(ssk)->icsk_pending && !subflow->stale_count ?
+	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
 static void mptcp_set_timeout(struct sock *sk)
@@ -2100,8 +2101,9 @@ static void mptcp_timeout_timer(struct timer_list *t)
  */
 static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
+	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
-	struct sock *backup = NULL;
+	int min_stale_count = INT_MAX;
 
 	sock_owned_by_me((const struct sock *)msk);
 
@@ -2114,11 +2116,11 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		/* still data outstanding at TCP level?  Don't retransmit. */
-		if (!tcp_write_queue_empty(ssk)) {
-			if (inet_csk(ssk)->icsk_ca_state >= TCP_CA_Loss)
-				continue;
-			return NULL;
+		/* still data outstanding at TCP level? skip this */
+		if (!tcp_rtx_and_write_queues_empty(ssk)) {
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
+			continue;
 		}
 
 		if (subflow->backup) {
@@ -2127,10 +2129,15 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 			continue;
 		}
 
-		return ssk;
+		if (!pick)
+			pick = ssk;
 	}
 
-	return backup;
+	if (pick)
+		return pick;
+
+	/* use backup only if there are no progresses anywhere */
+	return min_stale_count > 1 ? backup : NULL;
 }
 
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0f0c026c5f8b..6a3cbdb597e2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -439,11 +439,13 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
+	u8	stale_count;
 
 	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
-	u32 setsockopt_seq;
+	u32	setsockopt_seq;
+	u32	stale_rcv_tstamp;
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
@@ -690,6 +692,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
 
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
+void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
-- 
2.26.3

