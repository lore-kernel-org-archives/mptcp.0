Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F21D0BBE
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881333; cv=none; b=nkhnxF8yZz07dqdOQj8fDXLfr2CV+jke2AjUyeD+UdPVWmBKUz2TAy0cMAnn/h0acLKPMVPyNQY4eU/5lF6xQ4q4DQ4uCWDA1MVqdUOWDOdq6jLJmnjkZ3i1MX3lYaJLav03cfDErOeHUb13LK0kzwCfAY7R1cAAXtbFTAJFOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881333; c=relaxed/simple;
	bh=x5ZDptBZP7lvUt5corPdiXuOHk/QPqpKMiJOvNlcDto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6reZt82Wxt/x654WtctG7LGSAEWywylc6oyZIQXzjXEo90n1iqQB9+NbQjDkB4IrdankX6r9zvD8qmmaiHcpG/LRO5qkTQ8l7QASGKBo6UN2T2HS3uoJnlR8W2aY+8btLJHIp6mTqg4fXHUX4VK3uKEA3zglIlSbjOg9QsaD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr6nDfLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr6nDfLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E31C4CECD;
	Wed,  2 Oct 2024 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881333;
	bh=x5ZDptBZP7lvUt5corPdiXuOHk/QPqpKMiJOvNlcDto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rr6nDfLIP5A5jtTPrCiZBzZ0HQayBwSHniQxyqyAPsPw1/+znArHCUefLao2Q65e7
	 DlOxpjtmJh/kU8FEC2NrEvsP4idGntmiPVZVLyIHIaX+2XWWYIps6K4BWnag3e3Vhx
	 QGCb6/Yq33Y0mtlNFPs2/ffqfUovZYoXTGFcdvp4KyNhZ5KFueHnxDPcGxBej2UVzt
	 Hfss8y8P/hQpXrfFF6sPgff+gwH/4L5aN2xcjhhwhi1Vbx5MTBAZMiBHGn3cDzdE/J
	 4EClxQhtXEAP+Dty9ElybDWfql3TFIre2iFQC9y90jzNPaKFvhkCW6SaulM4orT8MS
	 exOs0M/YmYSXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/9] mptcp: change local as mptcp_pm_addr_entry
Date: Wed,  2 Oct 2024 23:01:56 +0800
Message-ID: <e544c26281f43f7d10f58c3aad0eb49e4b86998e.1727881073.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
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
an mptcp_addr_info one:

        (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But subflow_destroy() interface uses two mptcp_addr_info type parameters.
This patch changes the first one to mptcp_pm_addr_entry type and use helper
mptcp_pm_parse_entry() to parse it instead of using mptcp_pm_parse_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f4a4fa465136..9ff441beebe6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -463,7 +463,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info addr_l;
+	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
@@ -480,7 +480,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
@@ -493,35 +493,34 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
-		addr_l.family = AF_INET6;
+	if (local.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(local.addr.addr.s_addr, &local.addr.addr6);
+		local.addr.family = AF_INET6;
 	}
-	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&local.addr.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &local.addr.addr6);
 		addr_r.family = AF_INET6;
 	}
 #endif
-	if (addr_l.family != addr_r.family) {
+	if (local.addr.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
-	if (!addr_l.port || !addr_r.port) {
+	if (!local.addr.port || !addr_r.port) {
 		GENL_SET_ERR_MSG(info, "missing local or remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
+	ssk = mptcp_nl_find_ssk(msk, &local.addr, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.43.0

