Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193832209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588534; cv=none; b=AyuGlwm7eV/hMX3LTFN5SoQJ5nwpoLnZRHaFnPsXmKM4tTgGdzTq2DbKEN/ussDkpW05DHgNJPlAuST8Z2iy06HTKxaLECYU6JE7ZQaokHiN6/d28vMYlrsQQPwsufBi/7bHtKTRGad02nOZYEB9mx83bzFrv1CIckBuezI6JCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588534; c=relaxed/simple;
	bh=FPwd7UXo3fDKqXT+5f1edh8gyruJk0FsVISABcBPBI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgm5PaQ+Azks3T0V8mUyk5sV3+m2waWnlHwnQ9hnXJRMfrNL/Ax+dK069qXxreH068Txooc8uejuHG8nTA2XfHkQTutvN0JQzaPCHmjNVxexz8oZvKJKPahs+OwfLhdJbiTdZYnNru9wMaS9sZQiG+6/79q+IUwv8qu1NgN39eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpV1TkYe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpV1TkYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40E4C4CEE3;
	Tue, 22 Oct 2024 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588534;
	bh=FPwd7UXo3fDKqXT+5f1edh8gyruJk0FsVISABcBPBI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpV1TkYeR15GDQ8KdYIO7rxhFBxE4hO7wI6GUUEv6+yB+wmw+MEde0jMqE5Ixv80m
	 zorG7r4+tbRjvq+e5acOXRmYu1l9YwQl0ALulFGTGD25MwcR31dVNeaNyTsKH3Cs+F
	 XVfEYkX7sktC3pb8D7ToboKvzzBZ2tH3x7sdCDbU+RD+1WCfYe7xmniEy5fjpOEkC/
	 +ZGs7pitZblss1L1oO6r17HDXt6iM30HHqHz3EcIsnCoG59n+svqljr2OTBgFnfaMh
	 RAvZMntO4rKSERqk/jWH0Pls3oVQanZbZmvhuTDlppajQclUmbXv6N0hVmY4rwbRD6
	 XDmEIkGSzmJAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 25/36] mptcp: change local type of subflow_destroy
Date: Tue, 22 Oct 2024 17:14:33 +0800
Message-ID: <3fafc5c7aa6328e3df2870439a6c2ad5e4345bb6.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c1bc668cce1e..7c23f6f27626 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -453,7 +453,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info addr_l;
+	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
@@ -470,7 +470,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
@@ -483,35 +483,34 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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
2.45.2

