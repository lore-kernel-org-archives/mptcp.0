Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27426D00
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:54:37 +0000 (UTC)
IronPort-SDR: AEMh9d3z+LPbgdlaLVlGO7QWZM1NJtMHzVG3/opXVR25r1iX1OCo0UyphRzdn1nVEAfMPv3xoX
 twBoeHjC7l3g==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288450519"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="288450519"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:36 -0700
IronPort-SDR: REzDS1hbYzJYnjh3Dv7PZz7AlOEU2/F9TmkYJrBQDz8rdnw+ZyvqHxZzFw9f4AI9HRI0sN21dZ
 lgb1Vp7Fv+lQ==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443774250"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:36 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Jianguo Wu <wujianguo@chinatelecom.cn>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/7] mptcp: fix pr_debug in mptcp_token_new_connect
Date: Thu, 27 May 2021 16:54:24 -0700
Message-Id: <20210527235430.183465-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
References: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianguo Wu <wujianguo@chinatelecom.cn>

After commit 2c5ebd001d4f ("mptcp: refactor token container"),
pr_debug() is called before mptcp_crypto_key_gen_sha() in
mptcp_token_new_connect(), so the output local_key, token and
idsn are 0, like:

  MPTCP: ssk=00000000f6b3c4a2, local_key=0, token=0, idsn=0

Move pr_debug() after mptcp_crypto_key_gen_sha().

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/token.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8f0270a780ce..72a24e63b131 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -156,9 +156,6 @@ int mptcp_token_new_connect(struct sock *sk)
 	int retries = TOKEN_MAX_RETRIES;
 	struct token_bucket *bucket;
 
-	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
-		 sk, subflow->local_key, subflow->token, subflow->idsn);
-
 again:
 	mptcp_crypto_key_gen_sha(&subflow->local_key, &subflow->token,
 				 &subflow->idsn);
@@ -172,6 +169,9 @@ int mptcp_token_new_connect(struct sock *sk)
 		goto again;
 	}
 
+	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
+		 sk, subflow->local_key, subflow->token, subflow->idsn);
+
 	WRITE_ONCE(msk->token, subflow->token);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	bucket->chain_len++;
-- 
2.31.1

