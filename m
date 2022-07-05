Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064932F34
	for <mptcp@lists.linux.dev>; Tue,  5 Jul 2022 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657056744; x=1688592744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+KwzJcQwLoHt3LVM4fr/J+/A5rhuhTFgU08baoBP4U=;
  b=e6N48Kq4sy3M/jBDjEgzE6x4SxxZRKAAtEOkDVHxf5jb9aEDy81oqBBq
   XXKUdNYoRNtiLZH+SKxR/8G6kZIQyQ7j3pxWoq8CpgDmpP8Ij6rO/Z8uP
   oyb2ieBWToUSWd35OiCa0nJbO/TK//qL2F7a1HlNS8ko4wHrabLMcx2x8
   PxQ5cyJ/g4DZh3IhgWeifye2uint+JzB6zRncSQ7DX/FNMJw6/wQseVGk
   UlaumKFFHJPw6lS84l8PSS41pFuKE5qcn8T1qEp5WGJ/hmBkpe/MjZpLb
   k2kor/2lVy/8JPnlgadGS+L8FycmVSoyUbY23cJBn5mct2Vp5LRnAJi4b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284633922"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284633922"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:32:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="590558741"
Received: from rcenter-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.17.169])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:32:22 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/7] mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
Date: Tue,  5 Jul 2022 14:32:11 -0700
Message-Id: <20220705213217.146898-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The user-space PM subflow removal path uses a couple of helpers
that must be called under the msk socket lock and the current
code lacks such requirement.

Change the existing lock scope so that the relevant code is under
its protection.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/287
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_userspace.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f56378e4f597..26212bebc5ed 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -306,15 +306,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *local,
 				      const struct mptcp_addr_info *remote)
 {
-	struct sock *sk = &msk->sk.icsk_inet.sk;
 	struct mptcp_subflow_context *subflow;
-	struct sock *found = NULL;
 
 	if (local->family != remote->family)
 		return NULL;
 
-	lock_sock(sk);
-
 	mptcp_for_each_subflow(msk, subflow) {
 		const struct inet_sock *issk;
 		struct sock *ssk;
@@ -347,16 +343,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 		}
 
 		if (issk->inet_sport == local->port &&
-		    issk->inet_dport == remote->port) {
-			found = ssk;
-			goto found;
-		}
+		    issk->inet_dport == remote->port)
+			return ssk;
 	}
 
-found:
-	release_sock(sk);
-
-	return found;
+	return NULL;
 }
 
 int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
@@ -412,6 +403,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	sk = &msk->sk.icsk_inet.sk;
+	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -422,8 +414,9 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	} else {
 		err = -ESRCH;
 	}
+	release_sock(sk);
 
- destroy_err:
+destroy_err:
 	sock_put((struct sock *)msk);
 	return err;
 }
-- 
2.37.0

