Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70720EA
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520052; x=1680056052;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=d/xDT6btLh0ZvnslagoXCmEcD+Xgida3BERey+wbCB8=;
  b=AQuU7PONG3kSvKsXAF8MTTbEt6Uh+OTyao/sHgQ3B3/iHD7N8hPC7PRY
   PfsfQd54c3IBirZjRua/zuf1SfEu9yoaYB8uPmmJVzDCkVgnFeu7XZFli
   08mBVeMi6rtT53/s7mVq8r+EyZ+zh801UW40R01EPhpigow9RV9filCUS
   8c7ZDlRK8VkQX3wvFKC1maa2vtLB2nyxkQWA/mwzuR3mW4oVktYRHK9/c
   F78/A38gMpAIlrh+R21ELR3IDVpe7J/4F60wm2gQtzBL3lsWQ27YCWqdq
   8BAxIkcDhYSZhp51iNPLbEbwB8UXM2SlU7wyhqktgkUF02E3lAGtBrMPf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345578746"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="345578746"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202551"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 5/6] mptcp: establish subflows from either end of connection
Date: Mon, 28 Mar 2022 22:14:00 -0400
Message-Id: <20220329021401.1196466-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
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
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 5 +----
 net/mptcp/protocol.h | 8 ++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9625fea3ef9..e05d9458a025 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -931,7 +931,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
-		    READ_ONCE(msk->pm.server_side))
+		    !subflow->request_join)
 			tcp_send_ack(ssk);
 		goto fully_established;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d3887f628b54..b2c654992de0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3327,15 +3327,12 @@ bool mptcp_finish_join(struct sock *ssk)
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
index a762b789f5ab..187c932deef0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -911,13 +911,17 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
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

