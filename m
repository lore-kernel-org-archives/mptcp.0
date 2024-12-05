Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576122391B5
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382920; cv=none; b=ZWQqqCrW+65yNfPxwlQxIt+IVDi43rmnFwYkYpxcPCOB/LuhiGdiLlLwZ9AbqF8peKC5jkXvVfqAGuJAvZseYfWs5l9DQRUc8jMfQvErEyfgxksE5VT9KIVC5yPyXbACN4tEFAVxDc4tDM/QTP7J0hOPEh2wDpWDF0CamZ2WDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382920; c=relaxed/simple;
	bh=O8LXp49ej8kiS4ermKW2DrXtwSTlJwQCQYGeF/IjCkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY1PMwr/X7hRpm4VF/h0vp5rb1aGd+RzuYoupoi0XLxjlIi3JRCrfEfCp+M6v+9tSix+MhNLd5DKjP3cI+t/ortAnmaiBQEmS09QUa6gmBP/mrfJNBMTOq8ABtZ/Ea/GIoAzVZAMil7ofMe5/LrcGqSZAxPC6G0bAzkk7V3DHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBf6zyR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBf6zyR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBF4C4CED6;
	Thu,  5 Dec 2024 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382919;
	bh=O8LXp49ej8kiS4ermKW2DrXtwSTlJwQCQYGeF/IjCkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBf6zyR2SS52kxyBF3+a1Wed4Z00VAKgnJeCwZvU/rCkzeCgf6gemJeVO1buwGSxz
	 1B75gHcX02MHqv1Qkjcad7/z0T01J2TvMX4781rKqfd9XVD3EmLEwp1wOjdwPlQ58y
	 IdNjDO862FGKIRN9j3vYUIn9waxZ1wVUm2NK6HTfr2aaatEXkwipY7fXndDxoSMNBg
	 /TKcdHRVQkfQY4uZjTn1vCBzkByodLrARreW1aOn2YqwYx1Oygkq/D7dMAakTFDNfY
	 Cgd2gqB5acceHSpyyO9+BKnuNHsivPDxO6oMhE7pkbzHxccDsW/9ojmfQHyXdEWbFo
	 lAO4ljSAnz1XA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/7] mptcp: change local addr type of subflow_destroy
Date: Thu,  5 Dec 2024 15:14:58 +0800
Message-ID: <660f017d048bbd563e748cf7169e7a09811fb20c.1733382223.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733382222.git.tanggeliang@kylinos.cn>
References: <cover.1733382222.git.tanggeliang@kylinos.cn>
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
index ca302465fecc..f6ac4cd3b6c3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -484,7 +484,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info addr_l;
+	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
@@ -501,7 +501,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
@@ -514,35 +514,34 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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

