Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354DCA64
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270988; cv=none; b=VpORVxbtIGGoZ7svSXkbkqHbqOPWtWNYSXPA1moLeXw2sHAg8t7HxYgJq56GctCuaJcrdVDmGFXDwyYKCoznXXsegmCczH4RTVGzsQuEqYPjyB2ZkCkTJNJXd72Xd8seCroJrNqrX3xthCHUoilY8it3frPVLWe8hvidsiJvrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270988; c=relaxed/simple;
	bh=hnYBjXXQwPOjX21cOo/GguoDq08ls1+BTYVpns+F5aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJRSy4AVNe43Nhe2XlL5f8dlDaW1gsln3tmeaqZ6/eLySf7Qxam6GsqI28ZuON/ise/nbRFHH8TpBShZcCJtcxAEbCxZEi7pMC85CR3xwARYr7f9M9b1o37SQ0FrkIPKB+dQcw61D1uuDW4Bb/KH76axHo/ByB7WgcITIaHeyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHEthR2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHEthR2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D5C433F1;
	Wed,  7 Feb 2024 01:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707270987;
	bh=hnYBjXXQwPOjX21cOo/GguoDq08ls1+BTYVpns+F5aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHEthR2+/ikWy6Lx/+DF92XJ2XJAbOy7z0jZxyrx4/BH2+9JB7bxMQ+HcnJMvyE/+
	 4BKM4mLb71z02496BUE4S7H0/An7B0Dr9SStMgpeoPGVn/nBRBFDmv0ezCS6+c2qCo
	 mregEHBrVtN3QCuoNzxeEMo6H/p/K7Ns1AI/eOlrJLCfuMUTYh3oWTD0l6As1PBPE8
	 +VWNvhGUNFFf/M6Lih/HoY6HesKUw6yEGQmQEdWXGu6h3l5+VoPiASEQn8RVVf8dQH
	 LW/W7wbocGPB/uF02ZkAtO6aYw55O4cwj3CBiePvQcL5/0pRkjKRFPsdVuBvETFe+S
	 8Jv3JaBIH35zQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] mptcp: map v4 address to v6 when destroying subflow
Date: Wed,  7 Feb 2024 09:55:13 +0800
Message-Id: <1edc0fcbde128bb1b82892c0a335903c05a6f0ec.1707270765.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707270765.git.tanggeliang@kylinos.cn>
References: <cover.1707270765.git.tanggeliang@kylinos.cn>
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

