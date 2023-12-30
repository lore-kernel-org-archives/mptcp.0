Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034710F7
	for <mptcp@lists.linux.dev>; Sat, 30 Dec 2023 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wG5EV7p6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703904561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wEloxO2vOuiuMPvXZ4ZhJE1zFc5IB7QZq4/N1e0jXM=;
	b=wG5EV7p6GnoP5zSLYXeESJesoJtjkWIqWD+uWipeCMqkXQiMIOFHDzS3lOfBX4IPlt4gTI
	6L1uo8sY40glQe6JRSVIEBy6usH74xAID6jpidgSe+7r3PXvaMGLt2jV5VpDrTwLDypPU1
	pXmOZguYtlfTkVysIViZNJ3+mF9S9K8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v7 05/24] mptcp: map v4 address to v6 when destroying subflow
Date: Sat, 30 Dec 2023 10:48:00 +0800
Message-Id: <d7339002bfb57e08c1192c24e1e4c60c92e2abd3.1703904325.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703904325.git.geliang.tang@linux.dev>
References: <cover.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In mptcp_pm_nl_subflow_destroy_doit(), before checking local address
family with remote address family, map an IPv4 address to an IPv6 address
if the pair is a v4-mapped address.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c592536b9889..9df643373c39 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -499,6 +499,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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
2.39.2

