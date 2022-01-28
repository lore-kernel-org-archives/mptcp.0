Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE52CA6
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330320; x=1674866320;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Pv5XPI6mFK1R6TZbJ7SXEaAetvJS1zzj0bO3OELOvCY=;
  b=n/uMz9K1JSOrgklS8MaeeL1z5s7BCUY/iwwXSpYHytAyu+TEdZdtsSlS
   IOwN5oJrzx4UcVhxMzMLNwQrw39VYMC0jgDJtZYZ4lQJKA+rndX6ObFnI
   gmYT5KSeMU064GGV57G1WJ6mzOV7KFJlvRki7jeLSD+z0LuFCnuraHhrb
   HDCeczYrM+X1/EW5v+fpiKgcGLGqKP3uEP4GwxkJSML8RhAlb6hvRwwxv
   V91eSZkJs9Jg6LyrrpmQEuGIRjHZ9Lu2z54i2m5978H7+mOAFII3M40Sc
   jsNBzyFMHTPDl9iiZJNp9sFm8CccJaS15tnFudheO+FIfrIzLMvkQmjTD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846916"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846916"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564001008"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:20 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 8/8] mptcp: expose server_side attribute in MPTCP netlink events
Date: Thu, 27 Jan 2022 19:38:12 -0500
Message-Id: <20220128003812.2732609-9-kishen.maloor@intel.com>
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
index ceb4517a6e2b..126cc961a4fd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2088,6 +2088,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.31.1

