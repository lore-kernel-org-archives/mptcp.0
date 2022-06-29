Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB886AC0
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656542157; x=1688078157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EvaQjk+5XNMCrHXpibm6WIDqle7blbNVE8maepgy9x8=;
  b=oEdOcSXpVH348Ra4MFkxuQorcrhgGBqJqjaWG94ltDKdxeUbozz/90Aq
   1Fd99XULl/ZSIgW2p/zcej1+6XFBW8ZcVz3PtOX/WFLeSFnbmvwy8U9Tc
   eKaZ3OVqu/RTDY+KdUc1M7WjrgDjwmHUF1+sBNCRxxxX02QOP+7pAb8lD
   8joH2wGETjNAdKPEWPTfJ7w0s/lO5qV/c7/PGo/Yj6qOcv8UeF60LwVpN
   C4avQ59ULgjYFDOjxIc4sHmoiqNf5M3GKScyDMlFvNSKrUxfsd3UMtfMK
   S3hBDfqigS/4efWbCI5WWbD89o2K6+ASoMthvF3eXuf4kUClMC94nPmym
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282214127"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="282214127"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:35:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="718005997"
Received: from divyamar-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.13.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:35:54 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net v2 2/2] mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags
Date: Wed, 29 Jun 2022 15:35:50 -0700
Message-Id: <20220629223550.655928-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629223550.655928-1-mathew.j.martineau@linux.intel.com>
References: <20220629223550.655928-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up a subflow's flags for sending MP_PRIO MPTCP options, the
subflow socket lock was not held while reading and modifying several
struct members that are also read and modified in mptcp_write_options().

Acquire the subflow socket lock earlier and send the MP_PRIO ACK with
that lock already acquired. Add a new variant of the
mptcp_subflow_send_ack() helper to use with the subflow lock held.

v2: Squashed helper function commit

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 5 ++++-
 net/mptcp/protocol.c   | 9 +++++++--
 net/mptcp/protocol.h   | 1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 936d72359c46..04bae2d38b5b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -729,11 +729,13 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
+		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
+		slow = lock_sock_fast(ssk);
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
 		subflow->backup = bkup;
@@ -741,7 +743,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		subflow->request_bkup = bkup;
 
 		pr_debug("send ack for mp_prio");
-		mptcp_subflow_send_ack(ssk);
+		__mptcp_subflow_send_ack(ssk);
+		unlock_sock_fast(ssk, slow);
 
 		return 0;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3efbae948707..b96a80c8e22a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -506,13 +506,18 @@ static inline bool tcp_can_send_ack(const struct sock *ssk)
 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
 }
 
+void __mptcp_subflow_send_ack(struct sock *ssk)
+{
+	if (tcp_can_send_ack(ssk))
+		tcp_send_ack(ssk);
+}
+
 void mptcp_subflow_send_ack(struct sock *ssk)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
-	if (tcp_can_send_ack(ssk))
-		tcp_send_ack(ssk);
+	__mptcp_subflow_send_ack(ssk);
 	unlock_sock_fast(ssk, slow);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c14d70c036d0..033c995772dc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -607,6 +607,7 @@ void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
+void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
-- 
2.36.1

