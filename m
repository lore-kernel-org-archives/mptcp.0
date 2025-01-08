Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453E13BADF
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300672; cv=none; b=LWdOvUB/5OPUi0S3rWHVGYZYJxt/TsFej9WYdpS3KyFPB5rVRZRxTmWbLzDQJeqLafnocFbBg5AqgthBID4VjcRnmpIc/plDUE9esux5Eo9x4qNIDHkm7pw0G6cLRTJ9Al9HPijZJ0BDTBEhcv234u42V3fuJivbOlSXs/SJsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300672; c=relaxed/simple;
	bh=9CxQknm6b5hPwp/6SJpVRmrNspyR6bzDXro/7onkB4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh8W910mZ1SRXKBGeazsZonsqHZWeVaKExglh1vwA44Cfm+u+fQBZZSd98jnuZ20h/BEjCtlmmP05clv+feLnGfQotHEfr6Rb5KjgCYo/AYyI2SPb3EP/lQhO42I8uvwne3+Dp2xO1oa6I98fy4kFaafjkTDrWcEW1z9kvrIeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ9FHQp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ9FHQp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54236C4CED6;
	Wed,  8 Jan 2025 01:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300671;
	bh=9CxQknm6b5hPwp/6SJpVRmrNspyR6bzDXro/7onkB4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZ9FHQp7G+I6GCVyHjE8NVjb75W+HwwSq51v+QowuUj8CcIC7YIHXuQw1UsNbtodA
	 mdNfI1lMf/OXScKOEayDFxIU0yUG+KNkoJx552n1mVY6Npv6hxpPJPkHSE1U/cvXrB
	 ZAy5ZGOetiBPiIR5edk1eGKKEqC95i/hHV4nOyquTFVdxdLUWf5B6AHC+P6pfy3PmR
	 u0iHacdkVhWPjCOmBXzstglhAiPFW8kBoedd9cvcpQ3OJleMsCyKnXGfjeZ1WlkjJg
	 Jcwfki2gugeeJ5wtFqNZjATyXNXtFldb4U1cOQ2IhTsCZByb9YLKvDn5B+/VRu4kv+
	 cDAdIemL126uQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v8 7/8] mptcp: pm: mark missing address attributes
Date: Wed,  8 Jan 2025 09:44:08 +0800
Message-ID: <07fcafc9153f0386b0d7340e193bc73f806e7154.1736299989.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736299989.git.tanggeliang@kylinos.cn>
References: <cover.1736299989.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

mptcp_pm_parse_entry() will check if the given attribute is defined. If
not, it will return a generic error: "missing address info".

It might then not be clear for the userspace developer which attribute
is missing, especially when the command takes multiple addresses.

By using GENL_REQ_ATTR_CHECK(), the userspace will get a hint about
which attribute is missing, making thing clearer. Note that this is what
was already done for most of the other MPTCP NL commands, this patch
simply adds the missing ones.

v2:
 - keep "pernet = pm_nl_get_pernet(net);" at the beginning of
mptcp_pm_nl_set_flags().

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 24 ++++++++++++++++++++----
 net/mptcp/pm_userspace.c | 15 ++++++++++++---
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a60217faf95d..adef7f12914b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1393,11 +1393,15 @@ static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
 
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	struct nlattr *attr;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
 	if (ret < 0)
 		return ret;
@@ -1587,12 +1591,16 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
 int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	unsigned int addr_max;
+	struct nlattr *attr;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
@@ -1764,13 +1772,17 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 
 int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct sk_buff *msg;
+	struct nlattr *attr;
 	void *reply;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
@@ -1986,18 +1998,22 @@ static int mptcp_nl_set_flags(struct net *net,
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = sock_net(skb->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
+	struct nlattr *attr;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
 	int ret;
 
 	pernet = pm_nl_get_pernet(net);
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7c6b1241664a..1876b3b2cb2d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -565,20 +565,24 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry *entry;
+	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
+		return ret;
+
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
+	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
 		goto set_flags_err;
@@ -590,6 +594,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 	}
 
+	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
@@ -679,20 +684,24 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
+	struct nlattr *attr;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *reply;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return ret;
+
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		goto out;
-- 
2.45.2

