Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DF70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624896467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqR2LavF/5vzTaRIvKRrUdNHpt2CpaD8EO3O0yVGOi0=;
	b=ceS1y/FffeWoT31THDuAY1gbDn71kAuOwBm4TTTewg75SSlifAjPXZys7VDYI3a4VKHgXV
	ZP0jGTN4vJJIKHzFjlKypmWsXIylrxNCw8m4fLkB31RVLgXWoIOyzCUVQMQO8T6Q3NOtTz
	m54TWOWeqcSVzbhg1XT59iOtP4zQKhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-ecBZ-BNCPz6gSAt1W-HPPw-1; Mon, 28 Jun 2021 12:07:45 -0400
X-MC-Unique: ecBZ-BNCPz6gSAt1W-HPPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA014101F7A8
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 15:54:26 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-129.ams2.redhat.com [10.36.114.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0722D60875;
	Mon, 28 Jun 2021 15:54:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [PATCH mptcp-next 1/7] mptcp: more accurate timeout
Date: Mon, 28 Jun 2021 17:54:05 +0200
Message-Id: <730d62f1c48b6ce0e736722583cc9cea8c58694c.1624895054.git.pabeni@redhat.com>
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

As reported by Maxim, we have a lot of MPTCP-level
retransmissions when multilple links with different latencies
are in use.

This patch refactor the mptcp-level timeout accounting so that
the maximum of all the active subflow timeout is used. To avoid
traversing the subflow list multiple times, the update is
perfomed inside the packet scheduler.

Additionally clean-up a bit timeout handling.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4cc94ee425e4..291f0e2279a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -411,13 +411,8 @@ static void mptcp_set_datafin_timeout(const struct sock *sk)
 				       TCP_RTO_MIN << icsk->icsk_retransmits);
 }
 
-static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
+static void mptcp_set_timeout(struct sock *sk, long tout)
 {
-	long tout = ssk && inet_csk(ssk)->icsk_pending ?
-				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
-
-	if (tout <= 0)
-		tout = mptcp_sk(sk)->timer_ival;
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
@@ -531,7 +526,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		}
 
 		ret = true;
-		mptcp_set_timeout(sk, NULL);
 		mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
@@ -791,10 +785,7 @@ static void mptcp_reset_timer(struct sock *sk)
 	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
 		return;
 
-	/* should never be called with mptcp level timer cleared */
-	tout = READ_ONCE(mptcp_sk(sk)->timer_ival);
-	if (WARN_ON_ONCE(!tout))
-		tout = TCP_RTO_MIN;
+	tout = mptcp_sk(sk)->timer_ival;
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
 
@@ -1366,20 +1357,32 @@ struct subflow_send_info {
 	u64 ratio;
 };
 
+static long mptcp_timeout_from_ssk(const struct sock *ssk)
+{
+	return inet_csk(ssk)->icsk_pending ? inet_csk(ssk)->icsk_timeout - jiffies : 0;
+}
+
+/* implement the mptcp packet scheduler;
+ * returns the subflow that will transmit the next DSS
+ * additionally updates the rtx timeout
+ */
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[2];
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
 	int i, nr_active = 0;
 	struct sock *ssk;
+	long tout = 0;
 	u64 ratio;
 	u32 pace;
 
-	sock_owned_by_me((struct sock *)msk);
+	sock_owned_by_me(sk);
 
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
 			return NULL;
+		mptcp_set_timeout(sk, mptcp_timeout_from_ssk(msk->first));
 		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 
@@ -1400,6 +1403,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
+		tout = max(tout, mptcp_timeout_from_ssk(ssk));
 		nr_active += !subflow->backup;
 		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
 			continue;
@@ -1415,6 +1419,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 			send_info[subflow->backup].ratio = ratio;
 		}
 	}
+	mptcp_set_timeout(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
@@ -1433,7 +1438,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 			       struct mptcp_sendmsg_info *info)
 {
-	mptcp_set_timeout(sk, ssk);
 	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
 }
@@ -1567,7 +1571,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	 */
 	__mptcp_update_wmem(sk);
 	if (copied) {
-		mptcp_set_timeout(sk, ssk);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
@@ -2313,7 +2316,6 @@ static void __mptcp_retrans(struct sock *sk)
 			 info.size_goal);
 	}
 
-	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
 
 reset_timer:
@@ -2384,6 +2386,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->wmem_reserved = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->tx_pending_data = 0;
+	msk->timer_ival = TCP_RTO_MIN;
 
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -2476,7 +2479,6 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			tcp_shutdown(ssk, how);
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
-			mptcp_set_timeout(sk, ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_timer_pending(sk))
 				mptcp_reset_timer(sk);
-- 
2.26.3

