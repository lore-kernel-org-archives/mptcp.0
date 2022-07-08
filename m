Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5304C75
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657323385; x=1688859385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNc661S3iimevezDyva1ssvcfT/UsrE7h/xgcUHLZHg=;
  b=YF6Jpv2H2EJUym54CaRfsX3uoWL5VZw1KN3fSHi5KjJmjCJNkALohr5K
   uGBpAoYYbdJCGZYU/MrdsDRcJAH8U5fMBWvNhSioEv2QESX4VilHrcDzY
   9jxekxTbyvJtCYDiQMYeJC/llcoEs0i1fd5CLLD9xImS0sSR5axddR46P
   uDp/Qxa6GRFWAXCyyPyA/79EDUqRmwTRtTx+jMcDVAXU8rvLwelt6leCf
   z5Vi7QEIlbZD+Px1tx5h1LEvg9vmWpNqLlFVKUGGw+sKVgcpyEDBTSJet
   mMH9ftZOYkbvPCd0LERik4ebwwO5FqcL6UskdXo6cFAKTJqAFvKh4Jyhr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348372259"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348372259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770933079"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:36:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	kishen.maloor@intel.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	van fantasy <g1042620637@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/2] mptcp: fix subflow traversal at disconnect time
Date: Fri,  8 Jul 2022 16:36:09 -0700
Message-Id: <20220708233610.410786-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708233610.410786-1-mathew.j.martineau@linux.intel.com>
References: <20220708233610.410786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

At disconnect time the MPTCP protocol traverse the subflows
list closing each of them. In some circumstances - MPJ subflow,
passive MPTCP socket, the latter operation can remove the
subflow from the list, invalidating the current iterator.

Address the issue using the safe list traversing helper
variant.

Reported-by: van fantasy <g1042620637@gmail.com>
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cc21fafd9726..21a3ed64226e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2919,12 +2919,12 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_for_each_subflow(msk, subflow) {
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
-- 
2.37.0

