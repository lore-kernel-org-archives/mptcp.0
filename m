Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86927A
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664552; x=1682200552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOJzAzMvWv8BaaPAYDje4+YQa3+dNtjDiatyrVQ4ALI=;
  b=k0xEXIGxASCGdQY5WgH9840zsxyBCY8vR5JOS66bYZLGjzMZ3temG50g
   0g54v3G7bRu5bKGxgnkSjkMVeawDcAHgkAWKE5r/YWMLxS5Q+FFtMQ2Nd
   VUrymyg0Ixdzt1j+P/2U+mOxsZQrAw3tyyJf0LlPKYZ8aOWC3qwae/gp9
   WWAoXnBX42MQ1QIfT3NUIUnBJBvmmcRmsSyu53zT4qsZgOfpOmgVnMaD5
   5FM3eOM15mhrIl5vfGrJifuEjrzY8ptCyDQrIiHg3udHzXw6ZTEP91rVz
   Bqy7J/NEgshvTPPjDFl0+k67tMiz4Or0XjhKzLLRYLiMwMdSlGvwOYHmB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720730"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720730"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119260"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.99.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/8] mptcp: infinite mapping sending
Date: Fri, 22 Apr 2022 14:55:39 -0700
Message-Id: <20220422215543.545732-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
References: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the infinite mapping sending logic.

Add a new flag send_infinite_map in struct mptcp_subflow_context. Set
it true when a single contiguous subflow is in use and the
allow_infinite_fallback flag is true in mptcp_pm_mp_fail_received().

In mptcp_sendmsg_frag(), if this flag is true, call the new function
mptcp_update_infinite_map() to set the infinite mapping.

Add a new flag infinite_map in struct mptcp_ext, set it true in
mptcp_update_infinite_map(), and check this flag in a new helper
mptcp_check_infinite_map().

In mptcp_update_infinite_map(), set data_len to 0, and clear the
send_infinite_map flag, then do fallback.

In mptcp_established_options(), use the helper mptcp_check_infinite_map()
to let the infinite mapping DSS can be sent out in the fallback mode.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  |  8 ++++++--
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 17 +++++++++++++++++
 net/mptcp/protocol.h | 12 ++++++++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0a3b0fb04a3b..8b1afd6f5cc4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -35,7 +35,8 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4,
-			csum_reqd:1;
+			csum_reqd:1,
+			infinite_map:1;
 };
 
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 325383646f5c..88f4ebbd6515 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -825,7 +825,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
-	if (unlikely(__mptcp_check_fallback(msk)))
+	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
 		return false;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
@@ -1340,8 +1340,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr += 1;
 			if (opts->csum_reqd) {
+				/* data_len == 0 is reserved for the infinite mapping,
+				 * the checksum will also be set to 0.
+				 */
 				put_unaligned_be32(mpext->data_len << 16 |
-						   mptcp_make_csum(mpext), ptr);
+						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
+						   ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8aa0cdb7ad46..5c36870d3420 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -285,7 +285,13 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback))
+		subflow->send_infinite_map = 1;
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d653914e9fe..161c07f49db6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1229,6 +1229,21 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_map(struct mptcp_sock *msk,
+				      struct sock *ssk,
+				      struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->infinite_map = 1;
+	mpext->data_len = 0;
+
+	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
+	pr_fallback(msk);
+	__mptcp_do_fallback(msk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1360,6 +1375,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88d292374599..61d600693ffd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -441,6 +441,7 @@ struct mptcp_subflow_context {
 		send_mp_prio : 1,
 		send_mp_fail : 1,
 		send_fastclose : 1,
+		send_infinite_map : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -877,6 +878,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
 
+static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
+{
+	struct mptcp_ext *mpext;
+
+	mpext = skb ? mptcp_get_ext(skb) : NULL;
+	if (mpext && mpext->infinite_map)
+		return true;
+
+	return false;
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-- 
2.36.0

