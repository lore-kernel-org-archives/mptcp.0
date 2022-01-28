Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21E2CAC
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330324; x=1674866324;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sa72yrPBqKXhPZ16dGGP/HtQ1q4TOd82BWQ+bNO9jK4=;
  b=eo7kpJjpiU3y+T1w5/AfZT+DKk1ftlQ6Eqapc07yacrWYSnTGRL+TKjt
   lpir/MHopTCIC31UO88BfYA4jDBwgPdH14nWKins9g31DsewDF+0BStxN
   t9ky0nq7ALoCKGIAAsT1vWhIPLYX7+48f/kvzjFMK3+L4ke0QRajGOiTr
   xap7n7HAx1C7/bVjU6y+ZZjmPIsAOKxzvgxfEaNUVD6NdTbYRSPHaKgs3
   nsVJDFYHh6ehYpNqrg3prq9FGd6YhNrnYMdvtx5WOrY4qM0S+sCzZeu+2
   KCB3+JA4UmVzGH8h9VgJfs3muhV+VpoL11BqDmQrhwJbdEAQvZ8eKGEQy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846912"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846912"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564000993"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:19 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 1/8] mptcp: do not restrict subflows with non-kernel PMs
Date: Thu, 27 Jan 2022 19:38:05 -0500
Message-Id: <20220128003812.2732609-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003812.2732609-1-kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current limits on the # of subflows must apply only to in-kernel
PM managed sockets. Thus this change bypasses such limitations for
connections overseen by non-kernel (e.g. userspace) PMs.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm.c      | 3 +++
 net/mptcp/subflow.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f8878cc29e3..6b6220895929 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,6 +87,9 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
+	if (READ_ONCE(pm->pm_type) != MPTCP_PM_TYPE_KERNEL)
+		return true;
+
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8126986793e..a7b2d6fd1c1e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -62,7 +62,8 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-	       READ_ONCE(msk->pm.accept_subflow);
+	       ((READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL) ||
+		READ_ONCE(msk->pm.accept_subflow));
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.31.1

