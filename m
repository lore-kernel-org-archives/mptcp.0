Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19062CA6
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858025; x=1675394025;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GWC00DGcOIXpenWBtT7VMMPLeYZ8SNQrpkt8jAQUe5k=;
  b=c60xaXqVJ7aOJZ4PBDO9IBu17bs/zOHjAfzqLMMfLcUrnXquPOVpANgo
   Hwsld/uZwI2zPQO8Ckr6yL+RL4HfjmgB+nT/YL+mVPeKM2GLF8llPcnaI
   DK1JABQtAuQCLzljpVIAxBrkmk19hmoTWSYC3ch5s5o9ldbb5iC8vI9AR
   oMrQcQi1y1gzT7D7Bt1lg9uBNtNRaSiWhV+j30HuJPewuQxI6QXZNmznc
   YqTyONZKmpOpVkNjrQR32KTHs1m7H2CK/VFKKLiZYmBT5mWzabdshhCus
   ggebu1DMHdc/ablJAk9CPM94bJy+lO0W0WNpRSD+VzxwD1UEQKiJL7BQi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308795486"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="308795486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="771658274"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 8/8] mptcp: expose server_side attribute in MPTCP netlink events
Date: Wed,  2 Feb 2022 22:13:31 -0500
Message-Id: <20220203031331.2996457-9-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031331.2996457-1-kishen.maloor@intel.com>
References: <20220203031331.2996457-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change records the server_side attribute in MPTCP_EVENT_CREATED
and MPTCP_EVENT_ESTABLISHED events to inform the recipient of the role
of the associated MPTCP application (Client/Server) that is handling
it's end of the MPTCP connection.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/246
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 265cabc0d7aa..0df44a116a31 100644
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
index 9b3d871d3712..eaa1a5a21192 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2097,6 +2097,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.31.1

