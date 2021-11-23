Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164C2C83
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637685457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd/YCQW1YuEO93rtA/yjURMJ3AIGgmCeJeXKy58/Ft8=;
	b=TIUiQI1wPK0KTnv+2OCJKThFRFCGKzTTmEh9lX5iEI1x6Xb8NAhvFJph5Fiqn6Bl4bwV/I
	jvwfTt2IaOEsOkAsIZf7iDK7q3zrVLZuWG2MPb9k/B5SVihHt7RiRojKgut+cB1oZelnHk
	RBbp0JKs9xbNvhnGwaFT2+s8mrMKkbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-585-6VlsBpwFNUGyMS-2j9REew-1; Tue, 23 Nov 2021 11:37:34 -0500
X-MC-Unique: 6VlsBpwFNUGyMS-2j9REew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80ED41926DA1;
	Tue, 23 Nov 2021 16:37:33 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A66DA57CAD;
	Tue, 23 Nov 2021 16:37:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH mptcp-next 2/3] mptcp: do not block subflows creation on errors
Date: Tue, 23 Nov 2021 17:37:11 +0100
Message-Id: <c080cc1785cbe3bb3c049a683f2cc6d55f95f17a.1637684792.git.pabeni@redhat.com>
In-Reply-To: <cover.1637684792.git.pabeni@redhat.com>
References: <cover.1637684792.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

If the MPTCP configuration allows for multiple subflows
creation, and the first additional subflows never reach
the fully established status - e.g. due to packets drop or
reset - the in kernel path manager do not move to the
next subflow.

Let's trigger subflow creation on both the above event.
Note that we don't need an additional timer to catch timeout
and/or long delay in connection completion: we just need to
measure the time elapsed since the subflow creation every
time we emit an MPJ sub-option.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 19 ++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 12 +++++++++++-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7a6a39b71633..d6c4f5c82d09 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1257,10 +1257,10 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
 
+	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
 		subflow = mptcp_subflow_ctx(ssk);
 		subflow->send_mp_fail = 0;
 
@@ -1382,6 +1382,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		/* MPC is additionally mutually exclusive with MP_PRIO */
 		goto mp_capable_done;
 	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
+		if (ssk) {
+			subflow = mptcp_subflow_ctx(ssk);
+			if (subflow->start_stamp &&
+			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ/10))) {
+				/* we are not established yet and "a lot" of time passed
+				 * e.g. due to syn retranmissions. We can attempt next
+				 * subflow creation
+				 */
+				mptcp_pm_subflow_established(mptcp_sk(subflow->conn));
+				subflow->start_stamp = 0;
+			}
+		}
+
 		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
 					      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a6a4bd7de5b4..d5df04d5b3f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -432,6 +432,7 @@ struct mptcp_subflow_context {
 		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
+	u32	start_stamp;
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_token;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0f90bd61de01..85986f3b58ed 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1273,7 +1273,16 @@ void __mptcp_error_report(struct sock *sk)
 
 static void subflow_error_report(struct sock *ssk)
 {
-	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
+
+	/* subflow aborted before reaching the fully_established status
+	 * attempt the creation of the next subflow
+	 */
+	if (unlikely(!subflow->fully_established && subflow->start_stamp)) {
+		mptcp_pm_subflow_established(mptcp_sk(sk));
+		subflow->start_stamp = 0;
+	}
 
 	mptcp_data_lock(sk);
 	if (!sock_owned_by_user(sk))
@@ -1444,6 +1453,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->start_stamp = tcp_jiffies32;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	mptcp_add_pending_subflow(msk, subflow);
-- 
2.33.1

