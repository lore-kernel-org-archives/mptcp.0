Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFB2CA3
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641583557; x=1673119557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qeEpQkK0Sdp8utChRD6Bzjz2YY8JES0iyVlAhZDub5s=;
  b=ITOSHdLegNbOu35RDm7Fy+DKpioEsIBb0Pgwb/70Q8f3eOTnvoN1fE52
   Wg4AX8MBjLgD6dykuhZMqead8O7s1qTcwCIy9BlTg99pfkgUxrqCxtKyQ
   cfTM7hWlefa8YWcS4JcCewVPCg+ZnKWA0fMTqKViSYtXjR65QHsVC/zij
   L+gV5YtvmZHECO9ADefAPxVgi0/cpIa/DZ4q+XdZUcoKXxgtAnau+K0IF
   AF13JEGnokO4ohBa4IJ6bMUwtWOp+vduYdZDz8HG6d8SmhHUy5rXGl+Nb
   Ne50e2T8xcrbcxqwt5CF9ScawJdc23GXYzbYBYdE+1DkWI//aPXod3SXx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="240478013"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="240478013"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527478590"
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
Subject: [PATCH net-next 3/3] mptcp: reuse __mptcp_make_csum in validate_data_csum
Date: Fri,  7 Jan 2022 11:25:24 -0800
Message-Id: <20220107192524.445137-4-mathew.j.martineau@linux.intel.com>
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

This patch reused __mptcp_make_csum() in validate_data_csum() instead of
open-coding.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5bedc7e88977..bea47a1180dc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -845,9 +845,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 					      bool csum_reqd)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct csum_pseudo_header header;
 	u32 offset, seq, delta;
-	__wsum csum;
+	u16 csum;
 	int len;
 
 	if (!csum_reqd)
@@ -908,13 +907,11 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	 * while the pseudo header requires the original DSS data len,
 	 * including that
 	 */
-	header.data_seq = cpu_to_be64(subflow->map_seq);
-	header.subflow_seq = htonl(subflow->map_subflow_seq);
-	header.data_len = htons(subflow->map_data_len + subflow->map_data_fin);
-	header.csum = 0;
-
-	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
-	if (unlikely(csum_fold(csum))) {
+	csum = __mptcp_make_csum(subflow->map_seq,
+				 subflow->map_subflow_seq,
+				 subflow->map_data_len + subflow->map_data_fin,
+				 subflow->map_data_csum);
+	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
-- 
2.34.1

