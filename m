Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF6139D1B
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300660; cv=none; b=g7h55WHCJaeak9+XWfNZ60f8hKSgkESOjFiCVGfR26N4CD5oVFmlWRqsOk9X7bQdCvuO/xrYmno0m6iL7GRajx8GTCCcpRPb1Cyd+U6tzYplL+J9020k6pxYuH2TGf7zr9gw8AZSQL6XbQ5S0xWJOTUY1j88ICjemi+3+ihQYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300660; c=relaxed/simple;
	bh=5ZwuEaCyrh7/4JVc+sYIO1AdjSTMJWmfCVu+Im7GrHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al6RyotYSZEHpsLALeoNkXuaOy5Hx+kpFQ3NmsgVjLqwqvZFMupJRfQDB6kD7MPMeFRpAS4gQeBkQ4QZxcqQ+XInr2I+xoPC4kNgvgm/XJtyaNsj/2qsyZeHMWkZDlR3WmnliKlPuMPIxHScIuFLMo6BDLSwoGYJmOlt+rAyvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWaN2f/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWaN2f/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E5C4CED6;
	Wed,  8 Jan 2025 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300659;
	bh=5ZwuEaCyrh7/4JVc+sYIO1AdjSTMJWmfCVu+Im7GrHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWaN2f/Phx7IYST52WGUHWIrzLqa83OUyDbAVd4Pn4wiOzNkIuDL0RP6MWp5vkGYD
	 9wdpT8/cvBylJCHxuyt8XpLyHJ/qSM5lavovGmkotz1VAnoG1PQ7hflBmwgHepZTLm
	 wnf6OAYAosdmI43siy+dG3iHluG6Davp9CELGYSo9bos5zmNHaj2bIdcxzOaZmuPgp
	 vFeUAp6OUkm2JqdwPLIcSx50Be/jDOl71Y+4YDeWikVi6fHsMhGCp4UY/8XU8fRWjI
	 Z56LiFpYWylTnGMZN8ysTyGceAogbhiOPHRL/0WQJce70fT1RG2C3WeyDHxfJfdeU0
	 KTR2SDeDX22ow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/8] mptcp: drop info of userspace_pm_remove_id_zero_address
Date: Wed,  8 Jan 2025 09:44:02 +0800
Message-ID: <8eb1ce6b0fc86ce30746bdd0e309806494615ac6.1736299989.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
is to set an error message into it.

Plus, this helper will only fail when it cannot find any subflows with a
local address ID 0.

This patch drops this parameter and sets the error message where this
function is called in mptcp_pm_nl_remove_doit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3d477059b11..4de38bc03ab8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -253,8 +253,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
-						     struct genl_info *info)
+static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
@@ -269,10 +268,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 			break;
 		}
 	}
-	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+	if (!has_id_0)
 		goto remove_err;
-	}
 
 	list.ids[list.nr++] = 0;
 
@@ -330,7 +327,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
+		err = mptcp_userspace_pm_remove_id_zero_address(msk);
 		goto out;
 	}
 
@@ -339,7 +336,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
@@ -356,6 +352,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = 0;
 out:
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info,
+				     "address with id %u not found",
+				     id_val);
+
 	sock_put(sk);
 	return err;
 }
-- 
2.45.2

