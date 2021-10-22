Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F62C9F
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634902735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ElJh2t1+KeRDfaGFisxV9cfwtqisadUBrypGLrKqWCY=;
	b=fEbTt/aaXYzwvM+D7Hf/Li+MhpF8ty4NIVO6Opd2MylPysWA2v2dPicooW1RnzvSkcLsjQ
	m8VEAd/ZElVNoYJTCmQnMaK/bxpvuLpgF4QOH38fUbGH3VOWENQfxYxHQvqfqH+VZPtzpF
	sa0AGlomCdCBOAArCUuEdJ+XWj2xocE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-dKw1cMQTO_GupWzpRGkpEg-1; Fri, 22 Oct 2021 07:38:47 -0400
X-MC-Unique: dKw1cMQTO_GupWzpRGkpEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84A5801FCE
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 11:38:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36B5560BE5
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 11:38:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp <mptcp@lists.linux.dev>
Subject: [PATCH mptcp-next] mptcp: enforce HoL-blocking estimation
Date: Fri, 22 Oct 2021 13:38:27 +0200
Message-Id: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
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
macros.

[1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
notes:
- this apparently solves for good issue/137, with > 200 iterations with
no failures
- still to be investigated the impact on high-speed links, if any
---
 net/mptcp/protocol.c | 58 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7803b0dbb1be..cc9d32cb7bc7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
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
 	long tout = 0;
 	u64 ratio;
-	u32 pace;
 
 	sock_owned_by_me(sk);
 
@@ -1427,10 +1431,11 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	/* pick the subflow with the lower wmem/wspace ratio */
-	for (i = 0; i < 2; ++i) {
+	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
 		send_info[i].ratio = -1;
 	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
@@ -1439,12 +1444,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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
+			pace = subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);
+			if (!pace)
+				continue;
+		}
 
 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
 				pace);
@@ -1457,16 +1463,32 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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

