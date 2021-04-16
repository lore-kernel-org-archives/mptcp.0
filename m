Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81C2F85
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 22:38:20 +0000 (UTC)
IronPort-SDR: r8VwgWuFYaKa20V4FEKdQlt9Lc0ceUO+yHsjfZvOCmZMz87U0M69fskvP/yvhy92UzqXJkk8rC
 3rgPUJ9JW82g==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175231659"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175231659"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:18 -0700
IronPort-SDR: wiHOuiVVm4EDvhcWXlRSNhWmi3k0wgjs0D46I/bPXiQ35MiKXI+dQLZVALs2FvZ8z4QR1JC16m
 MW7Wmuf0kCvA==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="462107390"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.43.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/8] mptcp: export mptcp_subflow_active
Date: Fri, 16 Apr 2021 15:38:03 -0700
Message-Id: <20210416223808.298842-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
References: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch moved the static function mptcp_subflow_active to protocol.h
as an inline one.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 12 ------------
 net/mptcp/protocol.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d0b9f76ab3c..5a05c6ca943c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -399,18 +399,6 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
-{
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
-	if (subflow->request_join && !subflow->fully_established)
-		return false;
-
-	/* only send if our side has not closed yet */
-	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
-}
-
 static bool tcp_can_send_ack(const struct sock *ssk)
 {
 	return !((1 << inet_sk_state_load(ssk)) &
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index df269c26f145..edc0128730df 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -544,6 +544,18 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
+static inline bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
+	if (subflow->request_join && !subflow->fully_established)
+		return false;
+
+	/* only send if our side has not closed yet */
+	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+}
+
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
-- 
2.31.1

