Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC31A83FB
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565067; cv=none; b=QjJEz9DtkDBAlFCtj5+HCsijJIhlUu9uV958LpPI6C+HjJVVzxbJh7DapteuHp9yKFlbPygY4ttgyV/FDd6p7Ausn+Ck/wJvFZqfi0p1r14G++EKWb8LX2Z6pJqopiwgseCOF3XTGwFGAAqzcLH7RpxG4V8K2OZpZdmadAwplSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565067; c=relaxed/simple;
	bh=ME2LpurMH8/i1zBciCwO+JKPkbJaoLsObzAYsTNbxXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUPajKb0ypZSLRhV4MSQtAn7J/+9hy2xLbhaurjjeiL4G//11uqQNIoPCwMHBwgDBfHen7Oq6ICTCOVQtfD4UsN40nkDkIUZKFiVND0IA0yrfNSxNkXWUj6CqeplnhPkmgi5EDEvdAvaB4YkI0udeEkBdsULyl43cUg2jYWEKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7/ZsxYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7/ZsxYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12716C4CED0;
	Mon, 30 Dec 2024 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565066;
	bh=ME2LpurMH8/i1zBciCwO+JKPkbJaoLsObzAYsTNbxXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e7/ZsxYfrKGyIlqPpDdue9ym3ONzb4MDfyVQ9GNhJKGrB4GlR/GzkWLYUNiB+gc3L
	 FR6WtqfH6QyCC/IF8XLVOwTBQgrCyh7GBfLgWJB6dcp4qylEUJINw56npHA82puxf2
	 vWW6GYFXKP4wW5UG/r8ZFUcym+qi2O1HNzOmjmGSzi2q4JRQr0kz2Lu5DAdit0f9a3
	 9SyqWXwFho1V+A/6kWDAfiCBG1LjnIQqWxX/XPGVm6Pbimw0i6tMnY+NB8bM9M0GkI
	 GYyGB7H90GVNUMdt7FcfjU5K0t42wdPEcH8OGuO981/GO7Dw3Gm39H59bjPSiIHHjs
	 86T4yZ2+J4kgQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:08 +0100
Subject: [PATCH mptcp-next v6 1/7] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
 possible
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-1-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7581; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ME2LpurMH8/i1zBciCwO+JKPkbJaoLsObzAYsTNbxXU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8JvQbtCrRzLD3GF3gIUUQPgFljtFVFY6zyI
 1jBjMllqgKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCQAKCRD2t4JPQmmg
 c9uWEADmjXDXZ+7I0JOSfW1arteZmdxGxVTRhsIHLKQ/tOp+Ss6HnvDFpFqVbsIch+CXhREE/a2
 S0FIvfe1US9AOGfSFYSMqgIFiPOLsKBeNV0BK7vrVBs4V0XTZcEV4AYLRrt05uBgS2nL3tdjbPt
 FVk9mCRSwpdKtsn9U4pYNhnXfMwzbKmkiaBhlu1VtAjfqDswRN5zTzcZmcm32OW/g6Vgvcqdrw7
 0MxqnEs8esV8YA72r1OR1Tzcu1uu3yGz5IfpEZJriWoXgvLLss/aKpvwoaBXbBpEgDoC7BjNVLV
 bOYYHAiQtQ9IljsXyBrgzxLHu5hP3Qnv0w9yNpFUyEOirIUXU2aUBr2yYKhftirQo2BksS+e1hG
 njPWwVSRwGWKfx4e5XKZ1wmx0HiH5YyPrH04u8H+feYbo4xb10rt9m4YZEdv17WsTL2nzvyQMBt
 7FZhMuwFFrRkON2MLNbF0ebxvirDUf8PDodsOG1jr52t5lx5trItzYadNn6D5nUcR7CYbDS/vM4
 S4QwKGJEVvcVKLXS2jLnhdIn0UrN49ry/PdMmAnuKEDAJyTJPpxV6zM+GXN8moV9/aNtyCTNKBC
 y5cAXqF4uOqv9pm7fgFZ09z9H8NpAXwbd1N65MtT/eq3294byGfLpctFqLifYQ30vzEki+vUuHQ
 Z1gjbLlo2WR5/Ew==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of only returning a text message with GENL_SET_ERR_MSG(),
NL_SET_ERR_MSG_ATTR() can help the userspace developers by also
reporting which attribute is faulty.

When the error is specific to an attribute, NL_SET_ERR_MSG_ATTR() is now
used. The error messages have not been modified in this commit.

mptcp_userspace_pm_remove_id_zero_address() has been modified to set the
missing attribute.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 23 ++++++++++++++---------
 net/mptcp/pm_userspace.c | 27 +++++++++++++++++----------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8196e196d5ee8c264784ba8d37645..49c34494e156ff6c3277b107c3840ee29dd3afbb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1403,18 +1403,21 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	if (addr.addr.port && !address_use_port(&addr)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
 	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
-		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags mustn't have both signal and fullmesh");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
-		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "can't create IMPLICIT endpoint");
 		return -EINVAL;
 	}
 
@@ -1608,7 +1611,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
@@ -1790,7 +1793,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}
@@ -1875,7 +1878,8 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info, "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "limit greater than maximum");
 		return -EINVAL;
 	}
 	return 0;
@@ -2003,7 +2007,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing required inputs");
+			NL_SET_ERR_MSG_ATTR(info->extack, attr,
+					    "missing required inputs");
 			return -EOPNOTSUPP;
 		}
 	}
@@ -2016,13 +2021,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
 		return -EINVAL;
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3d477059b11c3a5618dbb6256434a8e55845995..72d4861e497eef5a516fc1c3ec1659807ffedd53 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,7 +190,8 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		NL_SET_ERR_MSG_ATTR(info->extack, token,
+				    "invalid request; userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -224,14 +225,16 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "invalid addr id or flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 		goto announce_err;
 	}
 
@@ -254,7 +257,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
-						     struct genl_info *info)
+						     struct genl_info *info,
+						     struct nlattr *attr)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
@@ -270,7 +274,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 		}
 	}
 	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "address with id 0 not found");
 		goto remove_err;
 	}
 
@@ -330,7 +335,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
+		err = mptcp_userspace_pm_remove_id_zero_address(msk, info, id);
 		goto out;
 	}
 
@@ -339,7 +344,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, id,
+				    "address with specified id not found");
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
@@ -389,7 +395,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid addr flags");
 		err = -EINVAL;
 		goto create_err;
 	}
@@ -409,7 +415,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
+				    "did not match address and id");
 		goto create_err;
 	}
 
@@ -702,7 +709,7 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}

-- 
2.47.1

