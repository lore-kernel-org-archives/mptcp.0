Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1218D626
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069998; cv=none; b=jy2sEJ3m88c0aPTguf3jRg18F9jVAGGeCQFwfnzfnC6jLCo84mi7kj9wVNGnmi6LtNjP6FuNq+Z2kU0CyGb+FCQDlvfk64fnQw3TYEwpytRBS1Y9cOoRyZEfo4i9CcM9KXuYQOuXdJIcrJZ7x/4qJujs/QR4bR/ufqoqcsbG2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069998; c=relaxed/simple;
	bh=yVXLgDK8B4RuUBdGwxzukvD52DNseQh6Tl+65e+njO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbmphWPLflOIvDv5KIapbFXvcwJaf9MUKY+9WXCDNqqEbG0OjOBcCp/htoFtHoHyrGXG8muXL2ACHuN+EK5dM2hvu5BmtWR9vFrvON0IBrGMVtRt0Q/mqRmFBX29jCQj1JMIYEzn5OChIzmR+ek1DyM1+iSYo/vONXZUmisuEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3pvDENa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3pvDENa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C0FC4CECF;
	Wed, 16 Oct 2024 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069998;
	bh=yVXLgDK8B4RuUBdGwxzukvD52DNseQh6Tl+65e+njO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3pvDENanz4mMTj5SkJ7QrU19VTAoWXT53juBIliJH50X2xF5UbkFeHC2taaW0YB+
	 zcU4GP0oGgRQhb9gvdM+75eKzdL1S7nxrhBJsAvGMsVMNNsUf/bpxO7tykXPunPajW
	 WPXCwjNTOC4U6Ufr89RkaDsibDRL+BX6ZLSIly7DiAvFg60T1MATgVkoF0CAJl6im7
	 dbv96u+36HPegQBzZl1LQxZZMmqvZT7ZSlhba4I8+i0YqUom74aC5C78ut/Yt+8Hir
	 Ok0+I+M/TdTOLcuFOYHjQ3Rze36SuvK0+C1vb9kgIa/m220gLPRgZ+BNMTdbfaGUvj
	 z2kLhhEeTbOxA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 18/33] mptcp: change rem type of set_flags
Date: Wed, 16 Oct 2024 17:12:22 +0800
Message-ID: <133cadea8da99bc6dbb4d1b838c42d1b46a7dd17.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined as
an mptcp_pm_addr_entry type address, while the remote address is defined as
an mptcp_addr_info type one:

	(struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type parameters.
This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ec2ac0f9c8f5..b83f4af632b5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -540,9 +540,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
@@ -560,13 +560,13 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 		if (ret < 0)
 			goto set_flags_err;
 	}
 
 	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
+	    rem.family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
@@ -586,7 +586,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
-- 
2.43.0

