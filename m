Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285470
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 18:27:36 +0000 (UTC)
IronPort-SDR: Hi7rjnk2D3Q728Dxl9sT7sM2+fGvZlQU6O/uT8XRNagiITGVtJz8vcKC/cFpBcsZ7RufQgQAfL
 AZCfrKIOf8gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="276342995"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="276342995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:34 -0700
IronPort-SDR: E6FAfHfYGz2V3bPHBhMwTNB5FHUfl2GnUaAk0Em4QVvprIMLEkvVgg5oLp0xXTBVVeGvjoLypY
 QkOeEfL6LqrA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443456547"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.24.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:34 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 04/13] mptcp: drop unused subflow in mptcp_pm_subflow_established
Date: Fri, 26 Mar 2021 11:26:33 -0700
Message-Id: <20210326182642.136419-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
References: <20210326182307.136256-1-mathew.j.martineau@linux.intel.com>
 <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch drops the unused parameter subflow in
mptcp_pm_subflow_established().

Fixes: 926bdeab5535 ("mptcp: Implement path manager interface commands")
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 3 +--
 net/mptcp/protocol.h | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2b7eec93c9f5..2d2340b22f61 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -882,7 +882,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	subflow->pm_notified = 1;
 	if (subflow->mp_join) {
 		clear_3rdack_retransmission(ssk);
-		mptcp_pm_subflow_established(msk, subflow);
+		mptcp_pm_subflow_established(msk);
 	} else {
 		mptcp_pm_fully_established(msk, ssk, GFP_ATOMIC);
 	}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 51e60582b408..0a06d5947a73 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -152,8 +152,7 @@ void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 	pr_debug("msk=%p", msk);
 }
 
-void mptcp_pm_subflow_established(struct mptcp_sock *msk,
-				  struct mptcp_subflow_context *subflow)
+void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2bcd6897ea7d..d04161ec1cb2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,8 +643,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
-void mptcp_pm_subflow_established(struct mptcp_sock *msk,
-				  struct mptcp_subflow_context *subflow);
+void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-- 
2.31.0

