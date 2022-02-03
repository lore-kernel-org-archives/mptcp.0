Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D32CA4
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858024; x=1675394024;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OACnXn1oJrS2hLkA30+p19VlWoYRQSzgjIal5iKRlMc=;
  b=X4eWZ8PTHW7Z7N/It3Lcb+UR2ZUbBgMTtPqOOmRGdVqPmsZd5/LTih/M
   1R5qjfo6YrKQPtfPrJND5CW8l9OwGCV1zH2fnF+8hXGlejrb0wflIjX68
   rbF4YI+xCH9PZVLsWSwvZn+otjsgY9JzVH5Vh9K318cQYUZQ6cdHfWPXR
   lTZrEsQOQwDosSJ8sB7Oe/JV1i+N6bBEBuaRbNKFvihiq3dYGP3NpUDcb
   YMf2EKg9VYDGFK7ksDmv87/9CAr8Yoh89b7Q7AnKYvI+p4P5rAZybF8YL
   TBr2D2iTXrCWC7oQrnCwt9SMJGxHGcg/A6AM6mbSO6wBGAwwJTpjut61+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308795480"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="308795480"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="771658260"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 4/8] mptcp: establish subflows from either end of connection
Date: Wed,  2 Feb 2022 22:13:27 -0500
Message-Id: <20220203031331.2996457-5-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031331.2996457-1-kishen.maloor@intel.com>
References: <20220203031331.2996457-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates internal logic to permit subflows to be
established from either the client or server ends of MPTCP
connections. This symmetry and added flexibility may be
harnessed by PM implementations running on either end in
creating new subflows.

The essence of this change lies in not relying on the
"server_side" flag (which continues to be available if needed).

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2: check for 3rd ACK retransmission only on passive side
of the MPJ handshake
v3: check for active subflow socket in subflow_simultaneous_connect
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 5 +----
 net/mptcp/protocol.h | 8 ++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6dfaa8e11331..4f56e874c542 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -929,7 +929,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
-		    READ_ONCE(msk->pm.server_side))
+		    !subflow->request_join)
 			tcp_send_ack(ssk);
 		goto fully_established;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3324e1c61576..6142b4b25769 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3255,15 +3255,12 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	if (!msk->pm.server_side)
+	if (!list_empty(&subflow->node))
 		goto out;
 
 	if (!mptcp_pm_allow_new_subflow(msk))
 		goto err_prohibited;
 
-	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
-		goto err_prohibited;
-
 	/* active connections are already on conn_list.
 	 * If we can't acquire msk socket lock here, let the release callback
 	 * handle it
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4371ac3fbde1..1a8d09796627 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -908,13 +908,17 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 	return false;
 }
 
+static inline bool is_active_ssk(struct mptcp_subflow_context *subflow)
+{
+	return (subflow->request_mptcp || subflow->request_join);
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct sock *parent = subflow->conn;
 
 	return sk->sk_state == TCP_ESTABLISHED &&
-	       !mptcp_sk(parent)->pm.server_side &&
+	       is_active_ssk(subflow) &&
 	       !subflow->conn_finished;
 }
 
-- 
2.31.1

