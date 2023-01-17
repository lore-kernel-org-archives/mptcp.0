Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC801FA7
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1R/zNJXy/zImUspA339/XCm8+fn1opSE/YPAqPAbyY=;
	b=hpeqopCG2CPpFNZpmNEynBk/RxSc60Me8BiwvM/2Y5HBjrpuDNsdZMpTwfP/N1Wdyrg/4i
	RZ1I2KXFfF+UJWBv09DVaoXL4wD3vagAPbv/xy6oTkYfglLBAytKNSdFYbC/WbPlalw8vr
	jZODjbJvbhguO6JgbUG4eR0jRLlTNsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-Nty0h3SzOv-KhpYaiF7qeg-1; Tue, 17 Jan 2023 02:37:15 -0500
X-MC-Unique: Nty0h3SzOv-KhpYaiF7qeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82006101A521
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1077340C2004
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 04/13] mptcp: drop unneeded argument
Date: Tue, 17 Jan 2023 08:36:24 +0100
Message-Id: <d5039d7be2a794652d8cf16534f79146ecbf1579.1673940640.git.pabeni@redhat.com>
In-Reply-To: <cover.1673940640.git.pabeni@redhat.com>
References: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the previous commit every mptcp_pm_fully_established() is
always invoked with a GFP_ATOMIC argument. We can drop it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 4 ++--
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b30cea2fbf3f..99c4f9e9bb90 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1001,7 +1001,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		clear_3rdack_retransmission(ssk);
 		mptcp_pm_subflow_established(msk);
 	} else {
-		mptcp_pm_fully_established(msk, ssk, GFP_ATOMIC);
+		mptcp_pm_fully_established(msk, ssk);
 	}
 	return true;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8e0cf6275e94..4ed4d29d9c11 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -126,7 +126,7 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 	return true;
 }
 
-void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp)
+void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
@@ -150,7 +150,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 	spin_unlock_bh(&pm->lock);
 
 	if (announce)
-		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, gfp);
+		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 871ec3e93314..5f1a30959b5c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -799,7 +799,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
-void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp);
+void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5e6752cd280b..7b91dc57049e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -860,7 +860,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 */
 			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK) {
 				mptcp_subflow_fully_established(ctx, &mp_opt);
-				mptcp_pm_fully_established(owner, child, GFP_ATOMIC);
+				mptcp_pm_fully_established(owner, child);
 				ctx->pm_notified = 1;
 			}
 		} else if (ctx->mp_join) {
-- 
2.39.0

