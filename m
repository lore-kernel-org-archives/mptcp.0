Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C633E5
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010247; x=1682546247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwKVfcYVKSL9hp993Wqqp7bRQBk5WB+jS5GEgL1KZ+g=;
  b=nJTh0ArUUz69ItI/X1K9Z7thOdHLhdAn+XLiFelV76VjH904+64JAV3Q
   +jRoMvQmIWNmDZWEMvwa596Q+bH7llmVmv+P+1MlZBHQ8oH7TjWgftbxs
   F1Stw5LtBLCfnu6dTtigMkUYf6oCnW0ei7qE9gqklJ4UvS7HeoFlHo7MT
   z9YEP5oD/I03/WnEMQ0UobbED4vUEBfqfmfAYy/NAh7y/II8T6ZAe4FDa
   blNHy1vsmUZvTaApQ/VknaF0mlNUpBAC8tFJKAtI+5A2SbYFKyBgMRCWH
   415wFUsqq3EZws9yvl6a4QSS27Wpg0zNvftdD3gd+vyDdZi8WCHxbV3++
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222717"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222717"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878097"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/7] mptcp: add MP_FAIL response support
Date: Tue, 26 Apr 2022 14:57:14 -0700
Message-Id: <20220426215717.129506-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
References: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new struct member mp_fail_response_expect in struct
mptcp_subflow_context to support MP_FAIL response. In the single subflow
with checksum error and contiguous data special case, a MP_FAIL is sent
in response to another MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       | 10 +++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5c36870d3420..971e843a304c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -290,8 +290,16 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu", fail_seq);
 
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback))
+	if (mptcp_has_another_subflow(sk) || !READ_ONCE(msk->allow_infinite_fallback))
+		return;
+
+	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
+		pr_debug("send MP_FAIL response and infinite map");
+
+		subflow->send_mp_fail = 1;
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map = 1;
+	}
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 61d600693ffd..cc66c81a8fab 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1; /* local_id is correctly initialized */
 	enum mptcp_data_avail data_avail;
+	bool	mp_fail_response_expect;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..ca2352ad20d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				WRITE_ONCE(subflow->mp_fail_response_expect, true);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
-- 
2.36.0

