Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A014A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494261; cv=none; b=eHzEEnJCs020PoSJ2yLyxkPxi4lB5UuSHE+8C6oyH/8Lt0NCFxk0Dg3nEUYaCr5zVIL1J7itpR2wqKEAqeVIVaLQxiCyzAmTab0iEEQIIGakWbdaPk66rVJt9/fq4lBqWYKyvZkHYizLNRW8aamyEcBzDMt6L4YG0ZIbBYuIkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494261; c=relaxed/simple;
	bh=uhxkRIWXQ7oz9UJ0VUzTpxyDa7ODYZRzDIu/F0VpZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpX1IiCBTU2wHGzkuCtUhsweqc1/1lwQkKfNf6Qewk9LZolYKxCqQN373cuzoh7hz8O5iftnpsiytN4SUYxPMpap9veV+99O6JiOjeizE8OzzFEkYGDLnR8StEc7WtmzfElxo/KlTz7eYweVsIRTesfm0Qd1xXfZH7nn78oVTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTWfXF3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTWfXF3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CFC4CED6;
	Fri, 10 Jan 2025 07:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494261;
	bh=uhxkRIWXQ7oz9UJ0VUzTpxyDa7ODYZRzDIu/F0VpZiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTWfXF3f3dbohsg5URChNXksIGgtAFkWPFBtwE4vYzhiRmlUEj6ytqQap9GeVMYR9
	 vo8S8Hse7Rk5xxZ4LgBunHBtYHM9iBH4gTPyhC0ZVhrHRYsC2LpWoBTWe7etPs2iGt
	 ZVlAxsAmSW96rSKHHJATg4J+Wi9LYS5kWCZF60XM8FkoMGWDsIOX1QimSlmd7/SdDF
	 F3G+iVwF68mFtdrx1Un6YfX0EJYM39ojQ9JtwVofvs94Ij8CC1o5w69Uiz4lrbd9An
	 wqFKyit662WpOqw2bDReGF5BPFlrOxnp34u+k/84DmTtUJCf3AnSXHfulnwgmS3QNm
	 XSgZFooWsnISQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 7/8] mptcp: pm: mark missing address attributes
Date: Fri, 10 Jan 2025 15:30:41 +0800
Message-ID: <e5feaed3502919d6f346d80709a4e1a1baf820f7.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3:
 - adjust the location of "pernet = pm_nl_get_pernet(net);".

v2:
 - keep "pernet = pm_nl_get_pernet(net);" at the beginning of
mptcp_pm_nl_set_flags().
---
 net/mptcp/pm_netlink.c   | 24 ++++++++++++++++++++----
 net/mptcp/pm_userspace.c | 15 ++++++++++++---
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a60217faf95d..ab56630b1d9c 100644
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
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return -EINVAL;
+
 	pernet = pm_nl_get_pernet(net);
 
+	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ab915716ed41..525dcb84353f 100644
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
@@ -589,6 +593,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 	}
 
+	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
@@ -677,20 +682,24 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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

