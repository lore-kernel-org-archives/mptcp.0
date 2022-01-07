Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C52CA3
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641583556; x=1673119556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKzjUf+5IIZ8MDyCvXc+81rmE6lK1eAM7jrYT8awB10=;
  b=LRBrNEbYyphBQAJUBWtxPqXAhPP/0JBZFBXO7mMnlNVCJJhIpp7NwxH3
   cvpURqMxdmmpkVB+E7ywZcquWqEbj53tzHGIA9nyAwk0mfLKOKGF6/vuN
   tpeRmpfjFa9G12I0lc9UHy0OE8FN+1ZaelCznQXwWqjet0rvLLNOJf25V
   Dj0CAAm6gBQZD9PrOFvZZmmjU4PPoqb5TdesHn3X5TNM1AkbylwTnISHp
   XmesgE1popnxUzLwxREpx9yHUx7rg/OkimLyAKd+FWs9iTXzBiaqlaVW1
   +2wwo+N1NRab383eo0YZqNE/qqgT0+INVAn3kqdFanWo+8eMZYwGRVuhe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="240478012"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="240478012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527478588"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/3] mptcp: change the parameter of __mptcp_make_csum
Date: Fri,  7 Jan 2022 11:25:23 -0800
Message-Id: <20220107192524.445137-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107192524.445137-1-mathew.j.martineau@linux.intel.com>
References: <20220107192524.445137-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch changed the type of the last parameter of __mptcp_make_csum()
from __sum16 to __wsum. And export this function in protocol.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 8 ++++----
 net/mptcp/protocol.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 38e34a1fb2dd..8ed2d9f4a84d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1233,7 +1233,7 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
 
-static u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __sum16 sum)
+u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
 	__wsum csum;
@@ -1248,14 +1248,14 @@ static u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __sum1
 	header.data_len = htons(data_len);
 	header.csum = 0;
 
-	csum = csum_partial(&header, sizeof(header), ~csum_unfold(sum));
+	csum = csum_partial(&header, sizeof(header), sum);
 	return (__force u16)csum_fold(csum);
 }
 
 static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 {
 	return __mptcp_make_csum(mpext->data_seq, mpext->subflow_seq, mpext->data_len,
-				 mpext->csum);
+				 ~csum_unfold(mpext->csum));
 }
 
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
@@ -1376,7 +1376,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 					   __mptcp_make_csum(opts->data_seq,
 							     opts->subflow_seq,
 							     opts->data_len,
-							     opts->csum), ptr);
+							     ~csum_unfold(opts->csum)), ptr);
 		} else {
 			put_unaligned_be32(opts->data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a77f512d5ad7..0e6b42c76ea0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -725,6 +725,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk);
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
+u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
 
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
-- 
2.34.1

