Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B11A9B32
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565072; cv=none; b=UZaqMX2BO/aBFtCiQf6EEwgoxz/muKPpf8khy/U67AfdtY7Q/I+eU3NSX4lDsSinFl2KrRjbYfe3vUyqz9gtVYhSysYbeRJYQdd57bIOAtZBXcsgLwCnhXG2zK4p/xSoWNa7TpV8xHlEkf65Sm9i89t4hqIP6Dpx8BQKHvCQqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565072; c=relaxed/simple;
	bh=qG9KX7q0Egfe+Y0A5OUlue3yr+URZ6TAi5q24fBvYbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXr9C9FK9031qhlWFDkQkaptQZ4wxFHZ2xNQ1a8Ga0MPQPsoIsm9YRqjhcNolDF5NS+mcAtoBa2Ys2ylYeb+QK5AzsV2Fm+eKoMNqjBwBJD6eYjnieFnbpKX7jCi/bXLG6v8PFP41D8vfr/Ez1ZlSNlhwYaUsKbL1cOCoBDaAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJRf+AEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJRf+AEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A9BC4CED0;
	Mon, 30 Dec 2024 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565072;
	bh=qG9KX7q0Egfe+Y0A5OUlue3yr+URZ6TAi5q24fBvYbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJRf+AEFFvvcIPAUE/p0yogDJxr92YHUDOgDwwcckW1877LQwTQdFVnhHkaGIy/8w
	 DXDulcazU6cNSHIb454eXe/Lb9OG0jdjHcL2fMzSc8uccgSjlWMYN4qeC+fz6WBy7D
	 6moFVt+HkyTIsMsL4IIXb87b7w1oaCxnWcLePxj/uril6zZHtdtYfIe+7ddCS+W35Y
	 Nv3qYtGZNABmltkSUy7vaA9zS4Fw5nfYUnDRQVTh3t64OFbh0ppwX6wtPoSQzWQ3sy
	 uOkpSCCLDlskBk1a//vL2rSePb5urxrllqR4djNakKbLorktgmGVSiLjBCXkAkhKa/
	 AEE9Soj6hmAvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:14 +0100
Subject: [PATCH mptcp-next v6 7/7] mptcp: pm: mark missing address
 attributes
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-7-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6102; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qG9KX7q0Egfe+Y0A5OUlue3yr+URZ6TAi5q24fBvYbg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8KTQv5s7mFJWefiKEWzQiqlScPe2E8ui/le
 DxiW8M+AMSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCgAKCRD2t4JPQmmg
 c1hTEAC2fifDJYjrpQlHzNmwKeC849244UQMr5SAhcpkTKaUr785I7fQT54DMIqMB9Vc0zvUaul
 xnwfW9FA7ndrFc8WRnCd9Xo986CPhuxwCdJVuTpW7t/ETCxMBcP5D23a62FWFMqxLZrV5RWJtHU
 frtSvlbxN6n0u/YAxXjSe2WtAwUuYDospyIUW8OqUKoqE0Vm1kweD1Sq48qqw4XqZZAGiu4JT2p
 ksmpHPwrlYD8MgamMSWLjbrFMXBdPJsc6S94JrbdVSdugz2TIbArjIBFy0jYWQ0Lx+yEfETHcVY
 Dk+jkqiUL5VS+XKNDRkGkUoEPMi7DDyt+tT491W9Lxy4bvUL1EJprjqShzXzqxvrJmg0/jjDjnR
 F+rBsUova3BurDL77OQRAA1HbL7S3z2fFa6Kn2rMK2+WptKv1oiguaNhFJSenpLN0/qdyd9jtIw
 RZKNJlEOp921JEHGRxBWYVEd3XVqPtE9sGr5jfY2kDoHb7dnKBS/YzD4T41pTpF/fa3BWOlbkYt
 lbi9lcJyhzM3IlybeDetkG3DjyE0zdQqvL81USepKt0amJxODdFmbM7VXd72689KFnKlQ4vJ0dK
 w1b0zjBuPJRy0os6AkfAqlDrUgwNCcGIvPFS/t7VHha9cB85dft9XT6dkroNYdLfQR3YMIrR5dL
 S7gudptMFq67joQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
 net/mptcp/pm_netlink.c   | 26 +++++++++++++++++++++-----
 net/mptcp/pm_userspace.c | 15 ++++++++++++---
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3bb213e2a967e87d4244dc0f1ba58d3ba21fb371..1eaaf91eb978b5e85dd5fc11d616ba48809e2915 100644
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
@@ -1590,12 +1594,16 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
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
@@ -1767,13 +1775,17 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 
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
@@ -1989,18 +2001,20 @@ static int mptcp_nl_set_flags(struct net *net,
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
 
-	pernet = pm_nl_get_pernet(net);
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return -EINVAL;
 
+	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
@@ -2017,6 +2031,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
+	pernet = pm_nl_get_pernet(net);
+
 	spin_lock_bh(&pernet->lock);
 	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
 			       __lookup_addr(pernet, &addr.addr);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 51943ca6ddb607e1dfea393525cccf5cbed7cfac..f5515b2305f41fafa7ef0627ed838b9d0db14aa9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -570,20 +570,24 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
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
@@ -595,6 +599,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 	}
 
+	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
@@ -683,20 +688,24 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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
2.47.1

