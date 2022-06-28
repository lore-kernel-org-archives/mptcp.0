Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B384C75
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656443058; x=1687979058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KLD6tyHtFOIl8tUbSzN0mzIm//0DER4c0z5tbUBNWHM=;
  b=KLuT14xgpwo/4wHS5bWW33wGdy+J7nXDpLz76JNWb6FvozsrOx4PkLox
   OUGmk1uCFhyVLPcVHT4Of5zYLhxeYMPcPvzZRKwzMWI8e2fwZ3IBX4hqr
   UoLAPq0Zt1HuMH94qGX3FXKCwg9QxS56WAeLuPNw0KXFwz/BgwsaZtUwD
   7CUherfTbRDROrqiFtkmJS+hLL5F/jwFep4UI8vKWwbCmU4FDXYx+DWmE
   cqckNJOf5Ye09IQzWK2kBuQY1u1rAS8sighfFEiRpT5ohVuBrWiuLNrHx
   pazTkB55ELXV+ftEqeo/qYVoypyezoSxr4REaSQQV+b2C4bkkv9ttF+0x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343514647"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="343514647"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="917294952"
Received: from gwbruss-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.112.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net 2/3] mptcp: Add a variant of mptcp_subflow_send_ack() for locked subflows
Date: Tue, 28 Jun 2022 12:03:55 -0700
Message-Id: <20220628190356.326233-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
References: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing mptcp_subflow_send_ack() function handles subflow locking,
but it's also sometimes necessary to force an ack from a caller that
already holds the subflow socket lock. This is required for the
following commit.

Fixes: 340fa6667a69 ("mptcp: Only send extra TCP acks in eligible socket states")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 9 +++++++--
 net/mptcp/protocol.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

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
2.37.0

