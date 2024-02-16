Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F917C7F
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069353; cv=none; b=D+qETVli3VKddfwQsxs4y50S0ILhdceNcgr5BH5jezcCscmQSaB3UVbUoG/67KfBPL0HpKLDjVjPdTyApQwajJsJLE+UpK3Xm+AVJhySNXQqeDPg8QkLI4m4F3dDQNtvz8W/awLmVfbwkYMguvzy9wTitvtXJGm79e6WWC9ua5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069353; c=relaxed/simple;
	bh=tibaRUxbzkCdKyaYGOvM9dCcDxCnbZho5PwpmHnS4as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DaC3NVmIWHvuxKDwDTVwQh68nSkwxtDe67Mv9w1zoplLe0S/INKVXaiuEzXTUX6yvMvLTUC0SFdTAJtY1m0c22+CBYm3WEzmkgFlG+feW3/+nqKfoJUY+cldF5zcDAtbFha5OWP9dW+T0xg96Xqxwrh6U3hoWORHo3+LqJnhcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrWJWoGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrWJWoGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC5C43390;
	Fri, 16 Feb 2024 07:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069352;
	bh=tibaRUxbzkCdKyaYGOvM9dCcDxCnbZho5PwpmHnS4as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrWJWoGE07JaVkWYxH/R6bW0Euf2iWQRLIE5WHMhLHp2KrathVxC4jYgvaDwPq/fH
	 cWtjtAiEQQFlcVz74ydM2WUJftPicyXJ5kX1uuhT6//0i7SHXfgolWedRRYMu4UsZe
	 W/dGsL7AAOYZKTaxxPowTx6eCHSqjn7OIbANCEzX2k5EIRlspFkG2b/vN5RqcntWUD
	 sidw3quQVFihvU0hibzQrzLG1/jxd71CVRENKvNHPwDvkjNadWvhQwkQBjxqBGrAoa
	 pdzRiznClDTQcXGUP1c2hWWGkF0k2F9mn59wQi5hWgme855l2EvGO+WidA6AaM//mr
	 6igaOqeMmSf8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 05/14] mptcp: check userspace pm flags
Date: Fri, 16 Feb 2024 15:42:07 +0800
Message-Id: <c600e3c58ad50e778c3357af6b58aa9008b28de6.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), PM flags should be checked in
mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

        id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the PM flags of the entry and check it. MPTCP_PM_ADDR_FLAG_SIGNAL
flag shouldn't be set here, and if MPTCP_PM_ADDR_FLAG_SUBFLOW flag is
missing from the netlink attribute, always set this flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d6b7be3afbe5..73ad286247f1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -360,11 +360,20 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
+	addr_l = local.addr;
+
+	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -378,7 +387,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.40.1

