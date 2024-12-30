Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA831A3031
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565070; cv=none; b=LVw2SnO7xyfuwh5ok0Tpl1+kfoEfiprubPJDwVIgkr7d5cTybqtZl2Mnp2iukqS0k9TJe7GLn+oW/gL0Zdy4cJWIemOONxikhOPqqBTJ+uZssOq3e3oGTpndtCXOTZMt4jyAFc3/zooMRYeqN+73n6XF/lmshjp8e9a6UQTTZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565070; c=relaxed/simple;
	bh=NP3CqdrzwEvGrN1QuKO2/2KU9MSDxh8HE3q6m8scA80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvsCqlyK2ohjUvh14pK3AxKsk07OYon3JJQsdN84jrjST2Ljpl+UlPtcIDRH0DVsxFDUuA5e5K0s2E+JRC+ssgvMDFptFrHg8HbwhvRPEJ2fo+bu48MSsJeoaR7QHtGwH2ghz1O5bOxH7f8qEcEXwBnSQNXOQyCQ8aP/g1Mb1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCYQ74AG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCYQ74AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0804BC4CED2;
	Mon, 30 Dec 2024 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565070;
	bh=NP3CqdrzwEvGrN1QuKO2/2KU9MSDxh8HE3q6m8scA80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TCYQ74AGTkeCyymLUECq4fp/nnt7xvNaxLsxpnliWQDT4s12MSepZJq4LZ3KCzDhZ
	 LidpfPvdVo9laTfBxw49kbXvBkUxzonKuDU/ve5LAKOhflV3FaE9C6fR4+2Ab9G5kq
	 ccB/NyIVgiFbF7FMZ1nmz1UhaMYDsyL4dJe/s479QmExpMokTwvD/zUA1WuZ8tZdXY
	 QD69/4UHIEVbuvwoNQjejgkWhx/x6+ddPgzZ5qAamrOi8VaLKElVeN8Ho2GwYjI2G2
	 x7bVtCc3CXDPOi/HmzA+SRQkcxJkFLn8r3m0hQoLyH3UVyWaeYr0Bg0XMu6s43ukV+
	 //1I1dp3q8cfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:12 +0100
Subject: [PATCH mptcp-next v6 5/7] mptcp: pm: userspace: use
 GENL_REQ_ATTR_CHECK
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-5-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5959; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rraPATvWMQ2H2oGt+iR2mS/awMhG76R6xhIwVn1noaw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8KHkZX2HmjvkvSfVcCRKBEp3FBrdm3nludZ
 oIe3H3flamJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCgAKCRD2t4JPQmmg
 c8UGD/9lFHuI4RQl7F1XBoHNtXW5cpvVqfi/4oV6cd0Jfc2MQO9PEtNfLHfy1Kg2rbCS8RJCkyC
 kI5fOO3bYxmk+Cg4hld0cr0d7yXx5ftiwO63f+C2RRK6VeKD+Lmefuh9UXGCM3vs4Q/+XQ0rMct
 LyhtLfWZflT8/RXe5/Fj/rgWjQF45q9bFpP8hlZ5/tIPDRC/sSt31w3k8lU6030p6fp+GZsHPs/
 ay+n5W00T04Jk+/IoH6pr67LVvQgZHBxVCqPf5SCfUyZtrPVfAPRD2Mi3zfrHoZT07xBzm8Svpc
 SNRKRLDjt484FC4NwbA9c+BjOBpmFB0zAWy/f0Kso08qA7B9cktzxyNRp71uxaEpVsIBylY42Vn
 rUHmD3Kvc/Hy9Wo0gxY/+yWBSrBfv1c80V4NwpnE54ZSIVlE0aDQ1gtsoKWL+1sjimuxaE4GaTO
 NAIxsEWikVUFPTNOrRbC2PxRqOzsitsH9l1oe+ryoul8C6/ShaeqslI09NAZZD/jXqtN1LFfEc4
 9oc2+i02+gOZ9mDxyKc7Ic3L57JYVtjeheHT3F8bFrRDnicDN3s7ZrS6gUXx8ISKBEmjBGE6IGR
 B8XeM6Rg8R0AEIsBZKqIIqLqaHHm44KFrK09jy0yAgnpA5ggafO50bjaC+SLbhaOiguavy7i7D8
 Zsfsde8Sr0/95Mg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
if it's NULL.

So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
and mptcp_userspace_pm_get_sock().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2f82ac49db35ec34dcc0b9208f4ac12edc6ab254..d6595cf3d8f8f9d4e2fd51505032ed2dc894738c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,13 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
-		GENL_SET_ERR_MSG(info, "missing required token");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
 		return NULL;
-	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
@@ -201,16 +200,14 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	struct nlattr *addr;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!addr) {
-		GENL_SET_ERR_MSG(info, "missing required address");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -218,6 +215,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -319,18 +317,17 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
+	struct nlattr *id;
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
 
-	if (!id) {
-		GENL_SET_ERR_MSG(info, "missing required ID");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
 		return err;
-	}
 
+	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	id_val = nla_get_u8(id);
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -373,19 +370,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -393,6 +388,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -406,6 +402,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -498,18 +495,16 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -517,12 +512,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
 	}
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");

-- 
2.47.1

