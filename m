Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502C18FDBC
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961965; cv=none; b=CCW3RUWmPhWyhUAL1fzp1nrSkY2fNHxNeO87NkENNwD+f8bu7gygdD6ndKTIArYbwOvLm7Ok/PDdoWa3ZjOakVENVnqDseaRbnLk2EWeaV4/WWWOHyjpf5oGdlEdgJsY06ec30ihGQ2sUvAjlhW4BdnNY/RryobnEKGrDziRHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961965; c=relaxed/simple;
	bh=dWVsqhcH0va8FW2f1KpI/2MBZhGeQnfXKP4CDUVhL6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njDDVfeDdqYkASHeWoE+XDICQNzMKbHOOlcW5D/dj3jQLM9q45WpCJQMEjrnApkjQLtNOyZhDrStFnMFiSZjElVBFj3X8/RUuq6X4NPptYjSyjKDQ4/tFb1Uz5/FksBqjlpKpzzOfFxShUmxz/qBJi/4JvB5zZw2wu1WaJ31aW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCtQwj2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCtQwj2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FEDC4CECD;
	Thu,  7 Nov 2024 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961965;
	bh=dWVsqhcH0va8FW2f1KpI/2MBZhGeQnfXKP4CDUVhL6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCtQwj2L3BhElD1DofU21TNazyweb4H5v+1dBq4aW0i79aK+CY055rZhW6DMff3ff
	 9uhtoF3OJccbV7u+9WgWDhzK5xJc2M7ie4nOQbM/NMcXpwcJMa/skqWwxLnCbXlQPU
	 TcG9ApNYwMhc1a7rZH+Lkx9awXUUtbS956DeLLoPpmvPwv1BNPi1a0t1KlcBsfklN0
	 Ola09iRElJe0ODmJOLFoWP8nG8c8M+fmIjWv/obCPoKRTzJwxKkX+ABiczXTX9uvSm
	 Odsz2sN/IRZTprdupeQ5zb3b2DJJuRZOsX48hLrJDZQyOLxHRG3EEr+qyCk+bZEETw
	 D5AigqAoD8W5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 8/9] mptcp: change local addr type of subflow_destroy
Date: Thu,  7 Nov 2024 14:45:42 +0800
Message-ID: <633182eea41112b834de2f4229a8c917deca82f3.1730961810.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
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

But subflow_destroy() interface uses two mptcp_addr_info type parameters.
This patch changes the first one to mptcp_pm_addr_entry type and use helper
mptcp_pm_parse_entry() to parse it instead of using mptcp_pm_parse_addr().

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index db09350b5022..07e0c7259494 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -482,7 +482,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info addr_l;
+	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
@@ -499,7 +499,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
@@ -512,35 +512,34 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
-		addr_l.family = AF_INET6;
+	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(addr_l.addr.addr.s_addr, &addr_l.addr.addr6);
+		addr_l.addr.family = AF_INET6;
 	}
-	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_l.addr.addr6);
 		addr_r.family = AF_INET6;
 	}
 #endif
-	if (addr_l.family != addr_r.family) {
+	if (addr_l.addr.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
-	if (!addr_l.port || !addr_r.port) {
+	if (!addr_l.addr.port || !addr_r.port) {
 		GENL_SET_ERR_MSG(info, "missing local or remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
+	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.45.2

