Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F74C68
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 23:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647558300; x=1679094300;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6Ivn5DBhc8ufoCfp/qAn+r+EZkOYATBS0JTMy3CoLU0=;
  b=TE0nEnK/pJzOt9G9VptnOxZgoGy6aDBSYzE6/d9JJq7EzVmsnQSlIRqP
   rih1IwvxX0PJJh+5x+4jaUa3+WhZEWLIvT9zgyguXhqnSgWVacw3blAS2
   g2jMYsTjKogidBIdN8/30TTJsmohaxf7qG3scBc7Q0fROL4VCItsDbkQB
   T3NbtSvouX3eBUbZXo7EB2iFuQpm/2g+NF1ik7dRTviDCdgN2LO7dfF1/
   gCxaULCBQlGuO1tvQ9+rlcmzzrXpG3RK4qBOeE4DiEh7n6prwa9qWH/MV
   Jlo17StvxyzNZw450yVx2FL2dw1r/JrhlJOS2YaNcCWpgsaMBkwpRVp7S
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257189957"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="257189957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="499015065"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:55 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 6/6] mptcp: expose server_side attribute in MPTCP netlink events
Date: Thu, 17 Mar 2022 19:04:49 -0400
Message-Id: <20220317230449.763778-7-kishen.maloor@intel.com>
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

This change records the 'server_side' attribute of MPTCP_EVENT_CREATED
and MPTCP_EVENT_ESTABLISHED events to inform their recipient about the
Client/Server role of the running MPTCP application.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/246
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 9690efedb5fa..e41ea01a94bb 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -188,6 +188,7 @@ enum mptcp_event_attr {
 	MPTCP_ATTR_IF_IDX,	/* s32 */
 	MPTCP_ATTR_RESET_REASON,/* u32 */
 	MPTCP_ATTR_RESET_FLAGS, /* u32 */
+	MPTCP_ATTR_SERVER_SIDE,	/* u8 */
 
 	__MPTCP_ATTR_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8676aecc52a6..c2a0588f8c85 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1976,6 +1976,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.31.1

