Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1E3D9D
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656088699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/KXnaRDceVKGvSF2PXEkNM1NbH19YquXzFEqGc6IuY=;
	b=L0GeI/v+lulJADOddsQTt72MFLH9Kn4NcnUguhVyzY6d9CNU8yc4PXkDQhZKvG06kLxi1V
	F3U6yN4J+CwMWzh1NzAuEG4y20CfOco/rJ4SmADLO9FrVABoNEUeKxHbutX359u4f569B5
	icrXYWW8c37UX28mHJjcj5oa7UsA4L4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-3EHx58E8NYWegcI_UzkD4w-1; Fri, 24 Jun 2022 12:38:17 -0400
X-MC-Unique: 3EHx58E8NYWegcI_UzkD4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AE1B2919EB2
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD60D2026D64
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC 2/4]  mptcp: introduce and use mptcp_pm_send_ack()
Date: Fri, 24 Jun 2022 18:38:08 +0200
Message-Id: <a59c3eb1e47c5c32f97c87d66c52f6c0021846bc.1656088406.git.pabeni@redhat.com>
In-Reply-To: <cover.1656088406.git.pabeni@redhat.com>
References: <cover.1656088406.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The in-kernel PM has a bit of duplicate code related to ack
generation. Create a new helper factoring out the PM-specific
needs and use it in a couple of places.

Note that this additionally moves a few unsafe subflow socket
access under the relevant socket lock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 45 ++++++++++++++++++++++++------------------
 net/mptcp/protocol.c   | 11 ++++++++---
 net/mptcp/protocol.h   |  2 +-
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2b2bb3599781..91f6ed2a076a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -463,6 +463,29 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	return i;
 }
 
+static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+			      bool prio, bool backup)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool slow;
+
+	spin_unlock_bh(&msk->pm.lock);
+	pr_debug("send ack for %s",
+		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
+
+	slow = lock_sock_fast(ssk);
+	if (prio) {
+		subflow->send_mp_prio = 1;
+		subflow->backup = backup;
+		subflow->request_bkup = backup;
+	}
+
+	__mptcp_subflow_send_ack(ssk);
+	unlock_sock_fast(ssk, slow);
+
+	spin_lock_bh(&msk->pm.lock);
+}
+
 static struct mptcp_pm_addr_entry *
 __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
@@ -705,16 +728,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
-
-		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
-	}
+	if (subflow)
+		mptcp_pm_send_ack(msk, subflow, false, false);
 }
 
 static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
@@ -736,16 +751,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
-		subflow->backup = bkup;
-		subflow->send_mp_prio = 1;
-		subflow->request_bkup = bkup;
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
-
-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for mp_prio");
-		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
-
+		mptcp_pm_send_ack(msk, subflow, true, bkup);
 		return 0;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1fae2f747c9..874344f7e0fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -502,13 +502,18 @@ static inline bool tcp_can_send_ack(const struct sock *ssk)
 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
 }
 
-void mptcp_subflow_send_ack(struct sock *ssk)
+void __mptcp_subflow_send_ack(struct sock *ssk)
+{
+	if (tcp_can_send_ack(ssk))
+		tcp_send_ack(ssk);
+}
+
+static void mptcp_subflow_send_ack(struct sock *ssk)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
-	if (tcp_can_send_ack(ssk))
-		tcp_send_ack(ssk);
+	__mptcp_subflow_send_ack(ssk);
 	unlock_sock_fast(ssk, slow);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95c9ace1437b..a92b6276a03c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -609,7 +609,7 @@ void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
-void mptcp_subflow_send_ack(struct sock *ssk);
+void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-- 
2.35.3

