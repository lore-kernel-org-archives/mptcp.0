Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14772
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635241348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YifkauvL8mqeFIzNrIl2oEUnPlFjIbawwgu22jFfot8=;
	b=MujTcVGHZRRdde5Qa1l6siFKKP9BUNJfUgqojljAV2Qyyrl4wndJpyDflM7Mlk43e1qqxU
	LnYX7GxWhC8ecOHasFL/c+UHr+DEWzZm6LiX8zT/dFeqQhrKcEAtd9ethj3SLq65fHBYwM
	UCxWsruR6jKcmz033Tzgh5tSUOnfHNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-rHhgdOBHNMiBPnf6oCmK0A-1; Tue, 26 Oct 2021 05:42:20 -0400
X-MC-Unique: rHhgdOBHNMiBPnf6oCmK0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B320779
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 09:42:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E437B5BAE5
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 09:42:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next] mptcp: enforce HoL-blocking estimation
Date: Tue, 26 Oct 2021 11:42:12 +0200
Message-Id: <d3477a25f27b733d33a85800713949dae0e1ea4a.1635241330.git.pabeni@redhat.com>
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

The MPTCP packet scheduler has sub-optimal behavior with asymmetric
subflows: if the faster subflow-level cwin is closed, the packet
scheduler can enqueue "too much" data on a slower subflow.

When all the data on the faster subflow is acked, if the mptcp-level
cwin is closed, and link utilization becomes suboptimal.

The solution is implementing blest-like[1] HoL-blocking estimation,
transmitting only on the subflow with the shorter estimated time to
flush the queued memory. If such subflows cwin is closed, we wait
even if other subflows are available.

This is quite simpler than the original blest implementation, as we
leverage the pacing rate provided by the TCP socket. To get a more
accurate estimation for the subflow linger-time, we maintain a
per-subflow weighted average of such info.

Additionally drop magic numbers usage in favor of newly defined
macros and use more meaningful names for status variable.

[1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix checkpatch issue (mat)
 - rename ratio as linger_time (mat)
---
 net/mptcp/protocol.c | 72 +++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7803b0dbb1be..582f5f88d6ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1370,7 +1370,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 struct subflow_send_info {
 	struct sock *ssk;
-	u64 ratio;
+	u64 linger_time;
 };
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow)
@@ -1395,20 +1395,24 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return __mptcp_subflow_active(subflow);
 }
 
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
 /* implement the mptcp packet scheduler;
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
-	struct subflow_send_info send_info[2];
+	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
+	u32 pace, burst, wmem;
 	int i, nr_active = 0;
 	struct sock *ssk;
+	u64 linger_time;
 	long tout = 0;
-	u64 ratio;
-	u32 pace;
 
 	sock_owned_by_me(sk);
 
@@ -1427,10 +1431,11 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	/* pick the subflow with the lower wmem/wspace ratio */
-	for (i = 0; i < 2; ++i) {
+	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
-		send_info[i].ratio = -1;
+		send_info[i].linger_time = -1;
 	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
@@ -1439,34 +1444,51 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
 		nr_active += !subflow->backup;
-		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
-			continue;
-
-		pace = READ_ONCE(ssk->sk_pacing_rate);
-		if (!pace)
-			continue;
+		pace = subflow->avg_pacing_rate;
+		if (unlikely(!pace)) {
+			/* init pacing rate from socket */
+			subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);
+			pace = subflow->avg_pacing_rate;
+			if (!pace)
+				continue;
+		}
 
-		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
-				pace);
-		if (ratio < send_info[subflow->backup].ratio) {
+		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+		if (linger_time < send_info[subflow->backup].linger_time) {
 			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].ratio = ratio;
+			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-		send_info[0].ssk = send_info[1].ssk;
-
-	if (send_info[0].ssk) {
-		msk->last_snd = send_info[0].ssk;
-		msk->snd_burst = min_t(int, MPTCP_SEND_BURST_SIZE,
-				       tcp_sk(msk->last_snd)->snd_wnd);
-		return msk->last_snd;
-	}
+		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+
+	/* According to the blest algorithm, to avoid HoL blocking for the
+	 * faster flow, we need to:
+	 * - estimate the faster flow linger time
+	 * - use the above to estimate the amount of byte transferred
+	 *   by the faster flow
+	 * - check that the amount of queued data is greter than the above,
+	 *   otherwise do not use the picked, slower, subflow
+	 * We select the subflow with the shorter estimated time to flush
+	 * the queued mem, which basically ensure the above. We just need
+	 * to check that subflow has a non empty cwin.
+	 */
+	ssk = send_info[SSK_MODE_ACTIVE].ssk;
+	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
+		return NULL;
 
-	return NULL;
+	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
+	wmem = READ_ONCE(ssk->sk_wmem_queued);
+	subflow = mptcp_subflow_ctx(ssk);
+	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
+					   READ_ONCE(ssk->sk_pacing_rate) * burst,
+					   burst + wmem);
+	msk->last_snd = ssk;
+	msk->snd_burst = burst;
+	return ssk;
 }
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 67a61ac48b20..46691acdea24 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -391,6 +391,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
+	unsigned long avg_pacing_rate; /* protected by msk socket lock */
 	u64	local_key;
 	u64	remote_key;
 	u64	idsn;
-- 
2.26.3

