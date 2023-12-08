Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2412B74
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AqIvitlv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch0GW7CPQBWJTz8hM4TA8X5hiOfZveb0r8onZzXhKOE=;
	b=AqIvitlv4s8JjzEeUHsBgu2SxbdHEYbI1tye/aKa6CoF2jVfdfhn96oN1pnUQ4dxOULO79
	QZYQQyrsS11s7e6w2osS0Nu29GArOKKKGKJppMsPWTDqYDpL8Ej+KfEr0Ml52c3EJ60Jqh
	V1uPtjKk8hq07muO87VRRyGmqIaotlk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 10/25] mptcp: set set_id flag when parsing addr
Date: Fri,  8 Dec 2023 18:07:23 +0800
Message-Id: <cce075b0a261f28f872ed693170a8fab741ee192.1702029538.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702029538.git.geliang.tang@linux.dev>
References: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When userspace PM requires to create an ID 0 subflow in "userspace pm
create id 0 subflow" test like this:

        userspace_pm_add_sf $ns2 10.0.3.2 0

An Id 1 subflow, in fact, is created.

Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
no ID is set by userspace, and will allocate a new ID immediately:

     if (!e->addr.id)
             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                             MPTCP_PM_MAX_ADDR_ID + 1,
                                             1);

To solve this issue, a 'set_id' flag is needed to distinguish between
whether userspace has set an ID 0 or whether userspace has not set any
address.

This patch adds a new parameter 'set_id' for mptcp_pm_parse_entry() and
mptcp_pm_parse_pm_addr_attr(), and pass a 'set_id' flag to them. If an
address id is set from userspace, this flag will be set as true.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c   | 26 ++++++++++++++++----------
 net/mptcp/pm_userspace.c |  6 ++++--
 net/mptcp/protocol.h     |  3 ++-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 489a7723efc4..6cf93ff508c6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1111,7 +1111,8 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 				       const struct nlattr *attr,
 				       struct genl_info *info,
 				       struct mptcp_addr_info *addr,
-				       bool require_family)
+				       bool require_family,
+				       bool *set_id)
 {
 	int err, addr_addr;
 
@@ -1126,8 +1127,11 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (tb[MPTCP_PM_ADDR_ATTR_ID])
+	if (tb[MPTCP_PM_ADDR_ATTR_ID]) {
 		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
+		if (set_id)
+			*set_id = true;
+	}
 
 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
 		if (!require_family)
@@ -1175,19 +1179,20 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 
 	memset(addr, 0, sizeof(*addr));
 
-	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
+	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true, NULL);
 }
 
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
-			 struct mptcp_pm_addr_entry *entry)
+			 struct mptcp_pm_addr_entry *entry,
+			 bool *set_id)
 {
 	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
 	int err;
 
 	memset(entry, 0, sizeof(*entry));
 
-	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
+	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family, set_id);
 	if (err)
 		return err;
 
@@ -1242,9 +1247,10 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	bool set_id = false;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, true, &addr, &set_id);
 	if (ret < 0)
 		return ret;
 
@@ -1426,7 +1432,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	unsigned int addr_max;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -1619,7 +1625,7 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -1869,12 +1875,12 @@ int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 	u8 bkup = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
 	if (ret < 0)
 		return ret;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote, NULL);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de10be21bf26..3d4258d2e269 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -156,6 +156,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	bool set_id = false;
 	int err = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
@@ -180,7 +181,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
+	err = mptcp_pm_parse_entry(addr, info, true, &addr_val, &set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
 		goto announce_err;
@@ -323,6 +324,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
+	bool set_id = false;
 	int err = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
@@ -347,7 +349,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_entry(laddr, info, true, &local);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local, &set_id);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3ab4a4f1bf81..ab125ccab313 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -885,7 +885,8 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
-			 struct mptcp_pm_addr_entry *entry);
+			 struct mptcp_pm_addr_entry *entry,
+			 bool *set_id);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-- 
2.35.3

