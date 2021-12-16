Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1742CA7
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693454; x=1671229454;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=aEwIQ8vPLJ/R6VD0AWYzWBRGIQKZiSeVS5swWA/ksAU=;
  b=RuqrBTzbcCfbtgqu9e9kqsxUmdaMlXstq/st4+f7UsaF2kQZbVna4a6l
   +arzRzJ1JJt6lMEbRmQFU1POYh5Eetdlcyll0bBNn+yhfueMZY3Q/0HeO
   2omq4/uGijDHqZFGMR/Hg+k6zBcn+b9fZtBFeOCMhzhtZuWAg5b/+Z/Zd
   MTkdF/Z23NaJxgtk41PFxKQFwXi17RiMpQieOnRzTKKX6jeDkwtMKTdmk
   0EjLbgEsQoFshct5nP3rYLT1Ckiwu3PBZ0rEUdaujwn11RarKaUiszgx+
   i/iW09sNXlqIfO70tqJdASl88u/Sm0gAGuqvx7l1nVebzZw2GsNIRy/rg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393159"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393159"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461232"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 04/21] mptcp: establish subflows from either end of connection
Date: Thu, 16 Dec 2021 17:22:57 -0500
Message-Id: <20211216222314.1244708-5-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
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
 net/mptcp/options.c  | 3 +--
 net/mptcp/protocol.c | 5 +----
 net/mptcp/protocol.h | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cceba8c7806d..ee13bb46dc38 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -920,8 +920,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		 */
 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
-		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
-		    READ_ONCE(msk->pm.server_side))
+		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ))
 			tcp_send_ack(ssk);
 		goto fully_established;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4012f844eec1..408a05bff633 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
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
index e2a67d3469f6..c50247673c7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct sock *parent = subflow->conn;
 
 	return sk->sk_state == TCP_ESTABLISHED &&
-	       !mptcp_sk(parent)->pm.server_side &&
 	       !subflow->conn_finished;
 }
 
-- 
2.31.1

