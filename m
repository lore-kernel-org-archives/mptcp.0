Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1C4A9F
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647555287; x=1679091287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LBH3oVPpZUWhACuFbLsRx6LPCOq5e55Un5nLgYAZFN8=;
  b=kr9UTcwVocAFdBfpOGA6gBFmNOLVNtm7iTMs9pyUKch/r2k7MyizULek
   HrT7rJA2bJaluqTbmKrr4M4P9VKUFpfvX6beSV0MGry1LA8eKR7bz2Mrr
   54ziwPtjPjh5Ok6ZUdSNFEnjB6JAZW6lAUDXPaC/vp20QPN22r2qLcFwR
   8mA5DNCYmsUvxQeGi+ip2xqeML3/WyD92K5qHmHHfLm3RVgOoj2re5dJn
   2Ao/8NaTe5msjUiJ/CVlgJzsUCDuA7YtWd/TZYjXcI120BknwYIqXj8Gd
   6Z95ZB1BbrmVQqtkeVoXr0a9jN0koW6ml4YbwHz8P9pq902kg48Z+TSR7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236939779"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="236939779"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:14:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="499002728"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.9.212])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:14:46 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next] mptcp: send ADD_ADDR echo before create subflows
Date: Thu, 17 Mar 2022 15:14:44 -0700
Message-Id: <20220317221444.426335-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

In some corner cases, the peer handing an incoming ADD_ADDR option, can
receive a retransmitted ADD_ADDR for the same address before the subflow
creation completes.

We can avoid the above issue by generating and sending the ADD_ADDR echo
before starting the MPJ subflow connection.

This slightly changes the behaviour of the packetdrill tests as the
ADD_ADDR echo packet is sent earlier.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 800515fe5e1d..b5e8de6f7507 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -650,7 +650,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
-	bool reset_port = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -661,14 +660,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		 msk->pm.remote.family);
 
 	remote = msk->pm.remote;
+	mptcp_pm_announce_addr(msk, &remote, true);
+	mptcp_pm_nl_addr_send_ack(msk);
+
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
-		goto add_addr_echo;
+		return;
 
 	/* pick id 0 port, if none is provided the remote address */
-	if (!remote.port) {
-		reset_port = true;
+	if (!remote.port)
 		remote.port = sk->sk_dport;
-	}
 
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
@@ -684,14 +684,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	for (i = 0; i < nr; i++)
 		__mptcp_subflow_connect(sk, &addrs[i], &remote);
 	spin_lock_bh(&msk->pm.lock);
-
-	/* be sure to echo exactly the received address */
-	if (reset_port)
-		remote.port = 0;
-
-add_addr_echo:
-	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_nl_addr_send_ack(msk);
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)

base-commit: 1abea24af42c35c6eb537e4402836e2cde2a5b13
-- 
2.35.1

