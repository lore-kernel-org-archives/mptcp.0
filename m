Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B82FB2
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 00:33:17 +0000 (UTC)
IronPort-SDR: RHqImoOsENoLYlHBwLHF+SjSvL3zL/bkjYN+ClVADFEbcoRhEN8Ehp9atMUKw4ss5977TAzgO9
 JbexK33D2I3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292587737"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="292587737"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:33:15 -0700
IronPort-SDR: nlkGC0OIuiZPrDOEFf1UZvr0Ig8EUKliXTqzvTTvEX9cAG9VpShgjqY4Vp4xWs6Cvc0K5MmSZf
 /4FW1FAurf8w==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="417234900"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.74.136])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:33:15 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	fw@strlen.de,
	dcaratti@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/2] mptcp: drop duplicate mptcp_setsockopt() declaration
Date: Mon, 21 Jun 2021 17:33:09 -0700
Message-Id: <20210622003309.71224-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622003309.71224-1-mathew.j.martineau@linux.intel.com>
References: <20210622003309.71224-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 7896248983ef ("mptcp: add skeleton to sync msk socket
options to subflows") introduced a duplicate declaration of
mptcp_setsockopt(), just drop it.

Reported-by: Florian Westphal <fw@strlen.de>
Fixes: 7896248983ef ("mptcp: add skeleton to sync msk socket options to subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7b634568f49c..78ac28902f55 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -762,9 +762,6 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 
-int mptcp_setsockopt(struct sock *sk, int level, int optname,
-		     sockptr_t optval, unsigned int optlen);
-
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
 
-- 
2.32.0

