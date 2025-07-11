Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800E27A44A
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226203; cv=none; b=a1JPhHGvS+lHqsvSVF7Eb/HdcD3+dJFspeK6XBnbvnikvCcHKhYMs+frN9t/mk7QEyXCEwjcINlAi6X8jR4M8QJay94Xd4AKLZk6ZKyf915mF7+n7LF87KnhWtEp72M7hEtOkuwCpr1ruHwfccMy8jstG/Pqg8MmIWRdoEJfaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226203; c=relaxed/simple;
	bh=b5junekmRqQSUXh7yXxmNWuneIufCOQ1ZmVkDnv7H0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oIEvlBXYerdYSNsh0S9FZrFOyXBOYcS+XYSzvlwbKj8TX6Nm3brnn9S6d4q8f9BuPt5yO6hNEb8YX9hQXSSRUrh92L2Uo/vqkzEmTsNdpldlh1XAXpeX0o1TlVXXlhnhKkJ8KuenjbjMYvt0O8imeKJFV24H/hJe28xv6HIviNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTA387kB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTA387kB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752226200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vJRda906NWEC2na7hvzJ364+UL7WMLISTn9a7UhzKU=;
	b=LTA387kB6lV5O2B/6i0V9Zc6BQXtGbF/oHw6GiEXyLVujgGiHk5A3K1Ey7JflCGfF2DeNn
	P/6+i7WuSOqpIVBBRz53rWOMUrnNdP7SQInBY54uzKhhzsVsjHEftvIJMkBVzItB13J+rd
	omQXfOeMvgBU6CITtyiGNyHgPWYMxCo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-q-YyRdF5P56dTiDwPWSq0g-1; Fri,
 11 Jul 2025 05:29:58 -0400
X-MC-Unique: q-YyRdF5P56dTiDwPWSq0g-1
X-Mimecast-MFC-AGG-ID: q-YyRdF5P56dTiDwPWSq0g_1752226198
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AF6E1955EC9
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C030F1800EC8
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-net 2/5] mptcp: plug races between subflow fail and subflow creation
Date: Fri, 11 Jul 2025 11:29:42 +0200
Message-ID: <cdda481cd6ceb6019de3625a9b31bf761cc45093.1752221786.git.pabeni@redhat.com>
In-Reply-To: <cover.1752221786.git.pabeni@redhat.com>
References: <cover.1752221786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qrUYClshC4PsvjS8HbvFtB8VwjXVrc8Vax14jhcbKIs_1752226198
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We have races similar to the one addressed by the previous patch
between subflow failing and additional subflow creation. They are
just harder to trigger.

The solution is similar. Use a separate flag to track the condition
'socket state prevent any additional subflow creation' protected by
the fallback lock.

The socket fallback makes such flag true, and also receiving or sending
a MPTCP fail option.

The field 'allow_infinite_fallback' is now always touched under the
relevant lock, we can drop the ONCE annotation on write.

Fixes: 478d770008b0 ("mptcp: send out MP_FAIL when data checksum fails")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c       |  8 +++++++-
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  8 +++++++-
 net/mptcp/subflow.c  | 19 ++++++++++++++-----
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 25ce2d5135bc..687dbb59d084 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -765,8 +765,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	if (!READ_ONCE(msk->allow_infinite_fallback))
+	/* After accepting the fail, we can't create any other subflows */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
 		return;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map\n");
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ddf3a1e0085..49498cdd17f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -791,7 +791,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -803,7 +803,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2625,7 +2625,7 @@ static void __mptcp_retrans(struct sock *sk)
 				len = max(copied, len);
 				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 					 info.size_goal);
-				WRITE_ONCE(msk->allow_infinite_fallback, false);
+				msk->allow_infinite_fallback = false;
 			}
 			spin_unlock_bh(&msk->fallback_lock);
 
@@ -2753,7 +2753,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 	msk->subflow_id = 1;
 	msk->last_data_sent = tcp_jiffies32;
@@ -3549,7 +3550,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (__mptcp_check_fallback(msk)) {
+		if (!msk->allow_subflows) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 61a9ff467501..c8b4ebe198dc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -348,11 +348,16 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
+	bool		allow_subflows;
 
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
-	spinlock_t	fallback_lock;	/* protects fallback && allow_infinite_fallback */
+
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
+					 */
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -1227,6 +1232,7 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 		return false;
 	}
 
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a6a35985e551..1802bc5435a1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1302,20 +1302,29 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
+static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
+	/* we are really failing, prevent any later subflow join */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* graceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
-		return;
+		return false;
 
 	/* since the close timeout take precedence on the fail one,
 	 * no need to start the latter when the first is already set
 	 */
 	if (sock_flag((struct sock *)msk, SOCK_DEAD))
-		return;
+		return true;
 
 	/* we don't need extreme accuracy here, use a zero fail_tout as special
 	 * value meaning no fail timeout at all;
@@ -1327,6 +1336,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1387,12 +1397,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
 			subflow->send_mp_fail = 1;
 
-			if (!READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!mptcp_subflow_fail(msk, ssk)) {
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			mptcp_subflow_fail(msk, ssk);
 			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
-- 
2.50.0

