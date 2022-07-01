Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532D1855
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656669941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajOjvh9cevBNeFaEoFAdQs9ZvNpnwdFg2bunoUFettw=;
	b=NrmETKv2r2cQjNqulpYgG/bxrrgVIrfkLJgv7GlNYrCBNE4rZ87Hw1utZ32i8o1sGxKDah
	4Cn7c+djPFestpGRTeWza9mAcZ4D123aCmTjNVnoYDB2+ACG/++uZHT92/gjKyL8knxkku
	nUzVvty7ST6tbOUsCy2U2a9rfX6Yqic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-kFf2HrQBMjSYJWPpUnyfUA-1; Fri, 01 Jul 2022 06:05:40 -0400
X-MC-Unique: kFf2HrQBMjSYJWPpUnyfUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DD58801231
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13612400DEFC
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/6]  mptcp: introduce and use mptcp_pm_send_ack()
Date: Fri,  1 Jul 2022 12:05:22 +0200
Message-Id: <6de116ad2229ddd1c557fca592b9c56fd2836823.1656669391.git.pabeni@redhat.com>
In-Reply-To: <cover.1656669391.git.pabeni@redhat.com>
References: <cover.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The in-kernel PM has a bit of duplicate code related to ack
generation. Create a new helper factoring out the PM-specific
needs and use it in a couple of places.

As a bonus, mptcp_subflow_send_ack() is not used anymore
outside its own compilation unit and can become static.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 56 +++++++++++++++++++++++++-----------------
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   |  1 -
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f1909006a859..8dc7ff9953b9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -463,6 +463,37 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	return i;
 }
 
+static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+			        bool prio, bool backup)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool slow;
+
+	pr_debug("send ack for %s",
+		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
+
+	slow = lock_sock_fast(ssk);
+	if (prio) {
+		if (subflow->backup != backup)
+			msk->last_snd = NULL;
+
+		subflow->send_mp_prio = 1;
+		subflow->backup = backup;
+		subflow->request_bkup = backup;
+	}
+
+	__mptcp_subflow_send_ack(ssk);
+	unlock_sock_fast(ssk, slow);
+}
+
+static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+			      bool prio, bool backup)
+{
+	spin_unlock_bh(&msk->pm.lock);
+	__mptcp_pm_send_ack(msk, subflow, prio, backup);
+	spin_lock_bh(&msk->pm.lock);
+}
+
 static struct mptcp_pm_addr_entry *
 __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
@@ -705,16 +736,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
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
@@ -728,23 +751,12 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local;
-		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
-		slow = lock_sock_fast(ssk);
-		if (subflow->backup != bkup)
-			msk->last_snd = NULL;
-		subflow->backup = bkup;
-		subflow->send_mp_prio = 1;
-		subflow->request_bkup = bkup;
-
-		pr_debug("send ack for mp_prio");
-		__mptcp_subflow_send_ack(ssk);
-		unlock_sock_fast(ssk, slow);
-
+		__mptcp_pm_send_ack(msk, subflow, true, bkup);
 		return 0;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 10bfa2b78206..874344f7e0fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -508,7 +508,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk)
 		tcp_send_ack(ssk);
 }
 
-void mptcp_subflow_send_ack(struct sock *ssk)
+static void mptcp_subflow_send_ack(struct sock *ssk)
 {
 	bool slow;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9a7ec7773e8c..a92b6276a03c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -610,7 +610,6 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
 void __mptcp_subflow_send_ack(struct sock *ssk);
-void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-- 
2.35.3

