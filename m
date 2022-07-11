Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B44692
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 19:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657567000; x=1689103000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7KH8qBXV+0o1mxMLu306DNdEfP6w1tkeWJrivYbd+8=;
  b=d7LrO1+c7mNxZUA9HM5uRH4QE3ca7ZWGGkgPQTLsLWH2mCF5jcSaSm1g
   qDDTUsi/WYeLuIs4wW7tPuXLWnDYWnil2hzckkamuS38e/I4zPPr8P4+p
   qK/mChdQhdETS+WS8o+ZilISIu1/KaX4E4+suhMmlGNcy11mT3TQyqnII
   fXSWaYC9WR0TNCP74N8UH3hw42F4hyIvkSP/E/GH66qrUvkqmV/x7fn/t
   cZxqKW/XoHEhSqe4hAr7zk1IPemXw8LpZILFvwFMclyhsMOWDAzCz2bIY
   HF567GV6+6ByVp4vq2BpJ6OwyOeY1BSQWeSIPC4IYXuea5oU8k4qFWJnW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284775354"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284775354"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697742711"
Received: from eedeets-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.2.111])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:38 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/5] mptcp: introduce and use mptcp_pm_send_ack()
Date: Mon, 11 Jul 2022 12:16:29 -0700
Message-Id: <20220711191633.80826-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
References: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The in-kernel PM has a bit of duplicate code related to ack
generation. Create a new helper factoring out the PM-specific
needs and use it in a couple of places.

As a bonus, mptcp_subflow_send_ack() is not used anymore
outside its own compilation unit and can become static.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 56 +++++++++++++++++++++++++-----------------
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   |  1 -
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5bdb559d5242..8e1d3aec94da 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -463,6 +463,37 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	return i;
 }
 
+static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				bool prio, bool backup)
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
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
@@ -729,7 +752,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
-		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
@@ -741,17 +763,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				continue;
 		}
 
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
index 2caad4a3adea..6cf5fa191b12 100644
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
index 07871e10e510..e38b861263ce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -607,7 +607,6 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
 void __mptcp_subflow_send_ack(struct sock *ssk);
-void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-- 
2.37.0

