Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534A77F00
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198224; cv=none; b=UdMQu9/xFGhzbJ7GIFXR/7k8BPWiBV0fSLDSFVWb9zyVBp8B2fKpvVILd+kO/PG1QzVMkNctzkC4rUmg1a5jCGfRhb60Gqcd5Pt0GXHRH1KxH1noPrMXiGPqdcERu5igDYyZh9MLw+0oRSsFT6+ckS706SpmCACAHUU3J7wNW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198224; c=relaxed/simple;
	bh=hnYBjXXQwPOjX21cOo/GguoDq08ls1+BTYVpns+F5aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCoYU50I/nVjWp0votAR/ielzlBEkO/st/bmrnDYWGmb8/QfWlSb1yyJjoCxpyMU60hvJOGGntqwyY4uFyuUHw+c4rVcrCqRIdCwGWeNqbRsaCtC7ZWgS4gFkSEluIWkh7sUgAJ+RrMZNt66S7NvmSCJoBs4mFWF1EP+YqkBCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVZLObp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVZLObp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EC7C43390;
	Tue,  6 Feb 2024 05:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707198223;
	bh=hnYBjXXQwPOjX21cOo/GguoDq08ls1+BTYVpns+F5aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVZLObp0Pc32D50sE/TV+yRZukU3fF0HRmmuXfeFFJAvFDuNqk5N2U4Tk/v9dRzxD
	 1lQ4IUBtQ9er/RQTUmYAUdlHgNcTFhcwiWlUyuQNBbFYUe0cBifqg5yd8KFNy7uxg6
	 zGZAJmjsQI5IPS9tr+6gkCtR7ME6YcU1Ndl2SYKwThv4hRdSRjILNWnSIOLm7siqGe
	 KVd8z+dFhVwBZvdc51eCHerC2S609aN1B8geDmK+iJNRmNPqHPg2qRD9DUuJ8BVYMT
	 T3c4m1ddoYyuJSDgkGmsV8+VJwZreHb4ikyBJ/8Y0BNdXpTljFxpJ05nyfhg/ifbRl
	 m1V9/MPBnBalg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] mptcp: map v4 address to v6 when destroying subflow
Date: Tue,  6 Feb 2024 13:43:34 +0800
Message-Id: <7e03f615d7c0c40305b77195c50f8966388b5722.1707198093.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707198093.git.tanggeliang@kylinos.cn>
References: <cover.1707198093.git.tanggeliang@kylinos.cn>
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

