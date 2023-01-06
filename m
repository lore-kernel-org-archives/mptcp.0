Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06E27738
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673031460; x=1704567460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReSnxVQ1DJz8unos+JBlWooMIESUVrgKBmg+G6yDpuc=;
  b=NEsCkCPOulEeGPyzt5xTI7ocQrtOZlyTBA+vqoVQ/hLJM7SuLtGf4iN0
   9Nq31rcGdDAGY97WC9KRa/nKRTOObGd14SnvVsTnu2qS4VfZvcNg+X8hz
   1A6yqXzU//vSMEaeu/9g4zKmuA0FgGCIp8419XcCwoSobG9sEPcJNbAOt
   USsNIEDRLzvTeRiYbqejdsKgXDaV3YIJNmJIFsGFiasgYo6Ovo4Szrahz
   eQWttOj6FulXWRiablNU72OQ/cn+3bWqv24yzRsxkidN7C3+7BY+VwY22
   Kwct/zl3HERoHmtJ77j8qSwhM9PK7iF9huAq16g+LkuhpKwPiGp9bGv/7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322611235"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="322611235"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="688383433"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="688383433"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:34 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Menglong Dong <imagedong@tencent.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/9] mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
Date: Fri,  6 Jan 2023 10:57:22 -0800
Message-Id: <20230106185725.299977-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
References: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

'ssk' should be more appropriate to be the name of the first argument
in mptcp_token_new_connect().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/token.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0d1658ce59e..5a8af5657796 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -754,7 +754,7 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(struct request_sock *req);
-int mptcp_token_new_connect(struct sock *sk);
+int mptcp_token_new_connect(struct sock *ssk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 bool mptcp_token_exists(u32 token);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 65430f314a68..3af502a374bc 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -134,7 +134,7 @@ int mptcp_token_new_request(struct request_sock *req)
 
 /**
  * mptcp_token_new_connect - create new key/idsn/token for subflow
- * @sk: the socket that will initiate a connection
+ * @ssk: the socket that will initiate a connection
  *
  * This function is called when a new outgoing mptcp connection is
  * initiated.
@@ -148,9 +148,9 @@ int mptcp_token_new_request(struct request_sock *req)
  *
  * returns 0 on success.
  */
-int mptcp_token_new_connect(struct sock *sk)
+int mptcp_token_new_connect(struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int retries = MPTCP_TOKEN_MAX_RETRIES;
 	struct token_bucket *bucket;
@@ -169,7 +169,7 @@ int mptcp_token_new_connect(struct sock *sk)
 	}
 
 	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
-		 sk, subflow->local_key, subflow->token, subflow->idsn);
+		 ssk, subflow->local_key, subflow->token, subflow->idsn);
 
 	WRITE_ONCE(msk->token, subflow->token);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
-- 
2.39.0

