Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0963FCE
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330328; x=1674866328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/t67gieiBvLRcblnAhWvhjv9l3aZqSdXP4PciHn5Fc=;
  b=eJa2bD/svaweKr+7bjaYjbkQ4fL/5/gjAJitMOod0LLisQgReE04ZWER
   a28xdL5oERE/ERhBjBl5MNYTNtsfEHagwUO02B0kXR8+R7q2Qwo3tDzvD
   RlL/55J6PZfNFWeL+jPWTRwbtrzv4mZXAuYaDS0sbk4Byvm3gUBfw/EmY
   99P2ZnPBd2iathCBUFLrBKDUi6lXuDIjoBhkeYAKwqUPrQKlS3Y0ZPkMk
   eUuUeNr3rDpBwATLIlQAUjQwCCmPuVjy0a/5GlxfgDw7wEncTAQiSdfBO
   JEhbg2vKi8qEl6fhVve9In5G2rrruD51QjLuWiisoDL7J+wrUS9the40R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358338"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527121"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 05/14] mptcp: netlink: split mptcp_pm_parse_addr into two functions
Date: Thu, 27 Jan 2022 19:38:27 -0500
Message-Id: <20220128003836.2732694-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003836.2732694-1-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Next patch will need to parse MPTCP_PM_ATTR_ADDR attributes and
fill an mptcp_addr_info structure from a different genl command
callback.

To avoid copy-paste, split the existing function to a helper
that does the common part and then call the helper from the
(renamed)mptcp_pm_parse_entry function.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/pm_netlink.c | 60 +++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ead218a20de..829e20a6d0dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1360,11 +1360,12 @@ static int mptcp_pm_family_to_addr(int family)
 	return MPTCP_PM_ADDR_ATTR_ADDR4;
 }
 
-static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
-			       bool require_family,
-			       struct mptcp_pm_addr_entry *entry)
+static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
+				       const struct nlattr *attr,
+				       struct genl_info *info,
+				       struct mptcp_addr_info *addr,
+				       bool require_family)
 {
-	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
 	int err, addr_addr;
 
 	if (!attr) {
@@ -1378,27 +1379,29 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 	if (err)
 		return err;
 
-	memset(entry, 0, sizeof(*entry));
+	if (tb[MPTCP_PM_ADDR_ATTR_ID])
+		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
+
 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
 		if (!require_family)
-			goto skip_family;
+			return err;
 
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "missing family");
 		return -EINVAL;
 	}
 
-	entry->addr.family = nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
-	if (entry->addr.family != AF_INET
+	addr->family = nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
+	if (addr->family != AF_INET
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	    && entry->addr.family != AF_INET6
+	    && addr->family != AF_INET6
 #endif
 	    ) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "unknown address family");
 		return -EINVAL;
 	}
-	addr_addr = mptcp_pm_family_to_addr(entry->addr.family);
+	addr_addr = mptcp_pm_family_to_addr(addr->family);
 	if (!tb[addr_addr]) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "missing address data");
@@ -1406,22 +1409,37 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (entry->addr.family == AF_INET6)
-		entry->addr.addr6 = nla_get_in6_addr(tb[addr_addr]);
+	if (addr->family == AF_INET6)
+		addr->addr6 = nla_get_in6_addr(tb[addr_addr]);
 	else
 #endif
-		entry->addr.addr.s_addr = nla_get_in_addr(tb[addr_addr]);
+		addr->addr.s_addr = nla_get_in_addr(tb[addr_addr]);
+
+	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
+		addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
+
+	return err;
+}
+
+static int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
+				bool require_family,
+				struct mptcp_pm_addr_entry *entry)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+	int err;
+
+	memset(entry, 0, sizeof(*entry));
+
+	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
+	if (err)
+		return err;
 
-skip_family:
 	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
 		u32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
 
 		entry->ifindex = val;
 	}
 
-	if (tb[MPTCP_PM_ADDR_ATTR_ID])
-		entry->addr.id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
-
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
 		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
 
@@ -1469,7 +1487,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr, *entry;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, true, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1678,7 +1696,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	unsigned int addr_max;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1854,7 +1872,7 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -2065,7 +2083,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	u8 bkup = 0, lookup_by_id = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
-- 
2.31.1

