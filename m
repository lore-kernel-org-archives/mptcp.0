Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC671DFF3
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759490; cv=none; b=d1YUcq8BB695UmGl88zwOyr45dl/8kJspc/fgqbZIsOof4GEKWSiKZXtvNE8ApCP5R1KZslLKEE63IXaeBuVmkY7hGirTFvVALnexu1+EwbX1rBDtcJQ2jxr5PXAT4fIqyxwGD/cg196veo54THbL4AuCIeYH9bwze6/vLkmJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759490; c=relaxed/simple;
	bh=hnYBjXXQwPOjX21cOo/GguoDq08ls1+BTYVpns+F5aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiwaqksRzEXdQ5Ak1Df2eADm1aVeKNkuo24+FHXHVzkwGEBn5yO/QvW9xtb0CkhkuLlxO8KqhbD0Fv7V7A2LC4ZkiaywlfKHck8F4wjSTZCMyEpGvf1qltGLe1+jVU2jC2UAiQp1wBbAkqbXuYJXoqSxE3lviQBbWk3gk+TDOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9iOYlu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9iOYlu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C2CC433C7;
	Thu,  1 Feb 2024 03:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706759490;
	bh=hnYBjXXQwPOjX21cOo/GguoDq08ls1+BTYVpns+F5aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9iOYlu0iHKZlABSGT9NIpsW8t2sHZS61bfdVMHAoas+iWSNtAHYifl/GsOLjLCkl
	 gS8Aq16f4F11IOGdnK8bzz/ne62UXE5fNOQI2+MrcwKV/CgWFJChActa5vgTCND1sS
	 Kytyz2AXL9KCGG38C5m0SK5dAxjV5csEwXdeGnDm17qQt+6fj8kN8rjW/hiHPJsiG9
	 eriPExwQooIXkQyiIhXQk/bAB6FgeWsXLVnLJOVnO+bTz88XSwxhTKpHCXU5N+hthK
	 AROcyKilmH/hhjWgK+buvq3z86aRCKCeQ9jccGGujdyqzzXOTis5B9Gx7LtcUiyjNI
	 jR9VwRXl3kxHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 3/4] mptcp: map v4 address to v6 when destroying subflow
Date: Thu,  1 Feb 2024 11:51:17 +0800
Message-Id: <978747717376e43b571aa264d31eec15f149ec1e.1706759413.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706759413.git.tanggeliang@kylinos.cn>
References: <cover.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address family of server side mismatches with that of client side, like
in "userspace pm add & remove address" test:

    userspace_pm_add_addr $ns1 10.0.2.1 10
    userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED

That's because on the server side, the family is set to AF_INET6 and the
v4 address is mapped in a v6 one.

This patch fixes this issue. In mptcp_pm_nl_subflow_destroy_doit(), before
checking local address family with remote address family, map an IPv4
address to an IPv6 address if the pair is a v4-mapped address.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e582b3b2d174..b40a69649fe1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -495,6 +495,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
+		addr_l.family = AF_INET6;
+	}
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+		addr_r.family = AF_INET6;
+	}
+#endif
 	if (addr_l.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
-- 
2.40.1

