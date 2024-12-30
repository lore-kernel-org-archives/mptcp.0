Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3D81A9B27
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565072; cv=none; b=VQhSl9MLziUZoWVeWbb0leULVfd5EBCxI7erdfxS8huQssYrpji4Ig5A/eUKT0lJAaFdIk+BVVn+CukzcfQFlRPW8nsYs/2NMWE8iqgXZND1Okv9Y3Ex/9a4frmbe58GBh7aPzFiYNMu7N7eySO027axI1GYcc9BsYh8y5JtIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565072; c=relaxed/simple;
	bh=hrvA2kH30fANO2NkkdujBKZC6DPYfuVrTB8Zvum9+18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPE+mlPrfL1B4GB0DivOdQQW1HuiPJnNXH1D/Y0s8dD2iSFc0H5CgCgUSMkB2zJ8agTaSlooDeT0cHsJxp7S5kXj1+QSNyBCPR5KMrs3+VmBpXmRTlENK6ggiLVeARXVgSA+LOCg0oGlSjW8VcBj2mYG0yoJ/xjtzRyt3mRDM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9uGE31b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9uGE31b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07639C4CED2;
	Mon, 30 Dec 2024 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565071;
	bh=hrvA2kH30fANO2NkkdujBKZC6DPYfuVrTB8Zvum9+18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a9uGE31behvwM7mp2KoCQnngrzYFMEX+OoV5BXdN/roqgf1VHYw19nbkForwCP6Tc
	 iSSPXuobLqtuhSdfqfr8K8i6QLxZzNz+yYe6ucR5NBVvKCqBxHLhUoeGxbYNKNakzt
	 tvM+KQXWuGBfuWlbQO+bNtQDbbymbHLUUvhtkE1DLOs51iRsBx4y3OjVhKS0VXqVJf
	 jCG3KN4dKLfO1ACDA1xh1LYUm5mLNu4fL+QecbFUEzVLJZFFTNsaEvu+Xg4q32i36+
	 9VkkR2mBeSrYpAj6TSP735pgGYaiSN47bzYKKfwRFvMMIu90BbXNluGFzXJmqvCPiw
	 /R0veBZTaA+9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:13 +0100
Subject: [PATCH mptcp-next v6 6/7] mptcp: pm: remove duplicated error
 messages
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-6-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hrvA2kH30fANO2NkkdujBKZC6DPYfuVrTB8Zvum9+18=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8K0YVqRsoHo/fpQKn6+9DRhoIxqVZQHofZu
 wKVtQfxx5aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCgAKCRD2t4JPQmmg
 c4qZD/4ptvi7XpAPiQ1JJap3wruVHkRr5WBuu7X3Wp37VlV30xRZKju/vWEL/xWDXqXTINPM0VS
 ceLmVj9v+5kPzZ0ZXnpbjrEFBGmBvom+r+Xs6KkzdouVD2T5qGjS0NPvnI8x0bvWqzQt/XihM8I
 5eCRh83swy0TmzOzCqum3eYgK/KS3iEQaHYYOSb6lzhljqYtMvKz2ZVLS8m0CFXm/MawHp4ZBoV
 V6mNceLdjzRWtKvrXpEbFUXr0fOPf4RM9+1t62wiCcKjekgpwGzmlniSXS99w7CaOuUUqJj9uQY
 G+ECso7X+AC9ZC/6akExKHWcLUPkUWyfeIGLobP6JnCOIr6+rx1YMGT6LRlhPKG7hry87rV/U2t
 wwfIUss2GqJi75GUQgVr9TSkxdw1wq2WqO9DFw28thF2gySbEGoZwjn4W4eBJH6GeQkLxswkODe
 164LTRQbsZpCfLvx7OSgynLJEJyl8jViItAvjEQq/MjhtiottEz6UgeySQIqolMztYy8l17xmTI
 dNue8MFY2k8QAluKgl8XqXuK6hP5nFXuWk82t0fy/GhMPuaXZvBsPvjC2HlufrWO4WkZqLZfYBn
 qHhZ/otFL6LqGxSV52Nt0c0MJbRdKWRU5KngfMZfPl7gT2BhOuyxjntSfl2J+BgwnckBPk8wBfJ
 CkTabUzA7zqsUng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_parse_entry() and mptcp_pm_parse_addr() will already set a
error message in case of parsing issue.

Then, no need to override this error message with another less precise
one: "error parsing address".

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d6595cf3d8f8f9d4e2fd51505032ed2dc894738c..51943ca6ddb607e1dfea393525cccf5cbed7cfac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -217,10 +217,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "error parsing local address");
+	if (err < 0)
 		goto announce_err;
-	}
 
 	if (addr_val.addr.id == 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
@@ -390,10 +388,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid addr flags");
@@ -404,10 +400,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
@@ -514,17 +508,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {

-- 
2.47.1

