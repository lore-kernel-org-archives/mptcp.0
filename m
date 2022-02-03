Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5E2CA5
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643873120; x=1675409120;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GWC00DGcOIXpenWBtT7VMMPLeYZ8SNQrpkt8jAQUe5k=;
  b=XoXVE9Qxnhj0cT+y+BLfYOaTwFVbg3wyXJWUG1ZVdFOXU0+9fpN4r4Jx
   xrY1IHrPH+6dLPNy96NLpGdMjNpmsUkD2wa/QtQ0v7zgGMJts6d7dI3Bg
   qKLhsJ8KcQiFM57BY6jw9VEaVsCC9YKghexqIMzwrAZEwo3aJ2GtNn3oN
   E9D6plVjFQ+vAJjOUxuTiL1YlxcXNpo0qvvko/Hwh+arwiaQ8Pfz2y0Ch
   JNaSNTm5F+V3Xst3TWYW3MotbYrPHTLoY1D0Wy17DTjkMdufM23zhu04s
   4d6YyPAIb9/IRu3SC7jtj2ufr/b3X8LhVsDlcxPSrDUyZFv4Dlh5/5M79
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272580777"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272580777"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535118736"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:14 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 8/8] mptcp: expose server_side attribute in MPTCP netlink events
Date: Thu,  3 Feb 2022 02:25:08 -0500
Message-Id: <20220203072508.3072309-9-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203072508.3072309-1-kishen.maloor@intel.com>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
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

