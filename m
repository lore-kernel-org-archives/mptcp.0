Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C72C9C
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 00:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019424; x=1675555424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+myu+kqVEbCshCjSRLhWyKSxrNCK7EbwezO18pNPxo=;
  b=JW4a99/9v0NKQQYhM8dcbLno7MyIjIVn7TKvyKFbO7PC+MFlR9/Xa6uM
   UlWVvocbSPNIbbhQ6b5ESde3N0/p9+eO9h/nG77qvvM6ictW0EQyvMXTp
   4H7m4h3hQ87SaMpGgr7U3Ar3ySqRXltA52xeTQjJK+PPZ36xGXKSkNlyX
   cXus8GqgXtcb7Ck2fcTYIZ3WEDNz091B+4UlCgSBRdOw+9ALGe1EDykDn
   0R4Hb5Ok8aUqb2L6y1/m6Ah+q/nEabQJZdkWDDPtUtFZB7yrEXSQ5nrnM
   qm4gDbZ/D9tjL/pyxupYhCMAfI4vtL0xaSHgpHePQa7Crz0yXUy+gybJs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248678279"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248678279"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="770097513"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/9] mptcp: allow to use port and non-signal in set_flags
Date: Fri,  4 Feb 2022 16:03:29 -0800
Message-Id: <20220205000337.187292-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
References: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

It's illegal to use both port and non-signal flags for adding address.
But it's legal to use both of them for setting flags, which always uses
non-signal flags, backup or fullmesh.

This patch moves this non-signal flag with port check from
mptcp_pm_parse_addr() to mptcp_nl_cmd_add_addr(). Do the check only when
adding addresses, not setting flags or deleting addresses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d47795748ad7..5464c2d268bd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1174,14 +1174,8 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
 		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
 
-	if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-			NL_SET_ERR_MSG_ATTR(info->extack, attr,
-					    "flags must have signal when using port");
-			return -EINVAL;
-		}
+	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
-	}
 
 	return 0;
 }
@@ -1227,6 +1221,11 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
+	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+		return -EINVAL;
+	}
+
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
-- 
2.35.1

