Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096842FB6
	for <mptcp@lists.linux.dev>; Fri, 27 Aug 2021 00:45:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="205007604"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="205007604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 17:45:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="599007140"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.68.199])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 17:45:02 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/5] mptcp: make the locking tx schema more readable
Date: Thu, 26 Aug 2021 17:44:54 -0700
Message-Id: <20210827004455.286754-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827004455.286754-1-mathew.j.martineau@linux.intel.com>
References: <20210827004455.286754-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Florian noted the locking schema used by __mptcp_push_pending()
is hard to follow, let's add some more descriptive comments
and drop an unneeded and confusing check.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a408395e78f..ade648c3512b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1515,15 +1515,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
-			/* try to keep the subflow socket lock across
-			 * consecutive xmit on the same socket
+			/* First check. If the ssk has changed since
+			 * the last round, release prev_ssk
 			 */
 			if (ssk != prev_ssk && prev_ssk)
 				mptcp_push_release(sk, prev_ssk, &info);
 			if (!ssk)
 				goto out;
 
-			if (ssk != prev_ssk || !prev_ssk)
+			/* Need to lock the new subflow only if different
+			 * from the previous one, otherwise we are still
+			 * helding the relevant lock
+			 */
+			if (ssk != prev_ssk)
 				lock_sock(ssk);
 
 			/* keep it simple and always provide a new skb for the
-- 
2.33.0

