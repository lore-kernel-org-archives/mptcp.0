Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378FF3A8EE
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759489; cv=none; b=YNZXrb3h/izzIGpAcS+Ap8/YPRK80ZUaMDJz8dnuxKAE+nQy2UvPkkMWpgyqndiznjkmGClo5pQZSoh5fsZbPoXPjmpeka0CCuNiMnDaT82yWfJWvrKBcF66SfKynsOlBj1EYC24ze16RelCSfn4jrkJTm0g3swqX53zBSNHQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759489; c=relaxed/simple;
	bh=7OESp6ArYJsjUqUxtis2O8e5RzqLd2DDEiDxUFvDbQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7g6jdwff2LliP5x1pjKexzkmPOC8Ttv5/4uugXiGuB0/unoyx2h4WDbT8M/EnD7UrztjrCOgw1TuN1QCv6Uk6xC3REolOAw69f0nxy+cd4E9mMq+yl/nUAIh17uiBny/TBDlfZ5qS9w+spuYzk7cuf38Am+3n4b4UuEpCebTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdNnBgXF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdNnBgXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC68C43390;
	Thu,  1 Feb 2024 03:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706759488;
	bh=7OESp6ArYJsjUqUxtis2O8e5RzqLd2DDEiDxUFvDbQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdNnBgXF9s0D4dEzpZbjkYs9OfvIHjWlhwGb5Ua9iyUM+DD+5lSjKD/ojl70Xy6Jb
	 EgaDDCJLNxe/ZtldgnZyzUnPYbjNofvwYh1DLuQEzHGVJ59X3UYs+VhouzYDI7vinG
	 kkFXEX9xgyxNPnKatAmcxLWoO4s2GzOHp43ZHgNkZ+8QKOoneSEfhY/qn3h77M4KeE
	 /rs9ofejtUn7sKCFyfySbBtNBSjc00dif+jYgGI5Aw690aaMEhxhE1N+X2dUYjiYct
	 dvvh+gV5Eq5mqC1vbgZJ3bwdIlzJo91hWZYHlukY1HzwXRcuX5M0ABkeWD/ChF/bUN
	 youwgNinNEG3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 2/4] mptcp: add needs_id for netlink appending addr
Date: Thu,  1 Feb 2024 11:51:16 +0800
Message-Id: <1d1970ac75aa9b924f1da17c3c89dcba96e5bb46.1706759413.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706759413.git.tanggeliang@kylinos.cn>
References: <cover.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just the same as userspace PM, a new parameter needs_id is added for
in-kernel PM mptcp_pm_nl_append_new_local_addr() too.

Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
ID is set from PM or not. It will be used in the next two commits.

In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
needs_it.

Fixes: fd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d9ad45959219..9367ab506908 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -901,7 +901,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -949,7 +950,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -960,7 +961,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1092,7 +1093,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1285,6 +1286,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
+static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+				      struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_address_nl_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
@@ -1326,7 +1339,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
-- 
2.40.1

