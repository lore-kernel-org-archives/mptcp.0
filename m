Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFC3D6F
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647472606; x=1679008606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUBZExgln/7TB16A0Uec1YceubwGi+kV3b6xAyTVl94=;
  b=FufJgaT5zqSBF9XbCMKK2atP/0kGVzY5eN0aHRge0kBJFn3QFhJY6IGw
   KjE5T/pTJR0YaDYJdvwcEpDytCe+UD8NAVX+4IFS+UkSpjMDrRZJOwdnI
   bPbTlFJZeoJc4qZXcYrO1glnNDKqbmewZWogD29aJv3CgClfJBdn23vWB
   w11SQKVfbFpVegIRG0CAt0kqFboXG8n/JQ1gooG082mSPRKhRV4NNExHK
   AKhEXkaECy65wCQ9KuSLu5UKfBu2vu9sxnTCAYehvTXKNBd4oSNhlORJr
   5vOFxmY5xaVIb8mrHS5NVIZzhe05QmuM9qFdmGmjMS6f5PWCSBUNH8UDz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317453508"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317453508"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613813304"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v5 04/14] mptcp: netlink: split mptcp_pm_parse_addr into two functions
Date: Wed, 16 Mar 2022 19:16:26 -0400
Message-Id: <20220316231636.645625-5-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316231636.645625-1-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
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
index b597e84affd5..aa1a9ae6b530 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1226,11 +1226,12 @@ static int mptcp_pm_family_to_addr(int family)
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
@@ -1244,27 +1245,29 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
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
@@ -1272,22 +1275,37 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
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
 
@@ -1335,7 +1353,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr, *entry;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, true, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1538,7 +1556,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	unsigned int addr_max;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1712,7 +1730,7 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1923,7 +1941,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	u8 bkup = 0, lookup_by_id = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
-- 
2.31.1

