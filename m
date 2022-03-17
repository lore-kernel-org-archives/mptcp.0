Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10448A2
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647531306; x=1679067306;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Dfkdg5YKUEuC4T75Wfo2CDAcejWqGn3fTVKkOtLWEjo=;
  b=a4EWz5z7qEHdicx2g8HQaWZDf4EoO2zvvgR7MIncfRqRRJ3/4impAsqy
   UghDxlGUils4zz9ANSlRzxCYy1QSx5Lw3CEiGYsqiPYOt/XsW4ag6Ja2D
   vaqwZ3/YGPcm26P7WP1lwVvZgBlDr8XXHH6XeMhQovvEFj0yjmgVLNu/B
   cBN99VT6H/yiWyCaNpvICafI6GNf91Z8mHmVM4uOa5xhatt8fYQdNtyK0
   UMbGe6rtnLi03MJqlnclJMzEoKm/W37lB/gshdmdnx5YnTvLPg5ogPSaG
   TRf3PtREo07aCJ5sbzAXO25OAauapNuzLY2khcTPIMz4oMqoy3BWEUjb6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237504881"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237504881"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516804212"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:01 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 5/5] mptcp: expose server_side attribute in MPTCP netlink events
Date: Thu, 17 Mar 2022 11:34:53 -0400
Message-Id: <20220317153453.665359-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317153453.665359-1-kishen.maloor@intel.com>
References: <20220317153453.665359-1-kishen.maloor@intel.com>
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
index 905f451ff0f9..6fb84f9c377f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1974,6 +1974,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.31.1

