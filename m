Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DC4ABB
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647558298; x=1679094298;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zoCHlFy6whInm7pnatDbZ4m89OJoHZwGhKN+62mhcPw=;
  b=BuvHUlI9k/H/BvV5erbqCYtzBQfSTcTvb34g/zNySSKQCZ++IB4MAWtn
   3E0lkOjBupNxFJv5TngYxsrkQDeHd70LUB94CZe1Pizk/apmINSmuVOcV
   09PS+MPBXieU9txuY3phGD/TIy7uacvW70rAqMdv/aixo1OECN1s/Pv9+
   6T5eMaYSUw+38GZS3TbABg3EFsz8860SP3pjji/tcYvPn0mDEfPdeLKz3
   Y4x72R4IhYC43TErDoAU/EDl44xvYjLPm9mffJU1y+tt4kvyeXK3tMBrQ
   sPzOIS3nUrdCNSgq/nhYDcjqIZJj6P8t4jaxagDZwQVO8DG6xTvbiOJi9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257189949"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="257189949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="499015051"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:55 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 1/6] Squash-to: mptcp: Bypass kernel PM when userspace PM is enabled
Date: Thu, 17 Mar 2022 19:04:44 -0400
Message-Id: <20220317230449.763778-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317230449.763778-1-kishen.maloor@intel.com>
References: <20220317230449.763778-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..3ef5bee66bcd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -803,9 +803,9 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline bool mptcp_pm_is_userspace(struct mptcp_sock *msk)
+static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL;
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
 }
 
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
-- 
2.31.1

