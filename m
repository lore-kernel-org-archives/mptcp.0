Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7098F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558334; cv=none; b=KMAsZ95dU2S6uJdM3fKkULeVUsH1iFweNLHlQZHPdoKF3glrEqzSMn5T8RgMulj7Ub7Jq1VT0GzTvV3OZDhfnUaUFFnhHJmYHV2SD5fX9Q9Zaf79Vx68ufE/mjfV35KZaZb5l5EpX+U16AwcOyRj9xTA3mBVUWwC9bBNyOeFw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558334; c=relaxed/simple;
	bh=rD0TpaNkyE0+BpftNU6Yeko+KpNJntQ9/V5qYFGwr+o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=g22knEGDyC4/cEOsS8yV5DtMCPJ2MCQhosUqDVxJtqiuRF0HCFQUN5J/+XuZ5uuCveI4xYB9ineJY4quv10d7TI0uzlxp6I/fTvd6mbQ0cmhXLqn50/iX4o1+UqNLLRo4dKpTRVLKbu2eq/GX+4F+ceUsd6IA326kO0wbEVUij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZStBDTUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZStBDTUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB75C433A6;
	Thu, 18 Jan 2024 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558334;
	bh=rD0TpaNkyE0+BpftNU6Yeko+KpNJntQ9/V5qYFGwr+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZStBDTUJR7NMlctRFO6j78pUJ97YdgYesYsx1X8g0JU8YyNvlBxa4Vli1yaKK3+dL
	 Vj1XAwmL0fbpPnlprga8qQ1imPjzql4YQ9LFGJOIhJILqO1dOER3AZzvY99dKpvrkS
	 yyNNEh50keav1IYcMgT8tQl8PGAw0JL4HGOSGQaSgSQ/EHyZtllUyy73O/z1cYHcNV
	 Stlaw1nXbgxldHipGGIst1+EEbbaciTx44Hf9GSN6I0k+VeSEwEvj50WRAHneDawQP
	 FnJo4KhkFzUnI2s+++NvnOJq+Znpwk6RvwQTTdJrz9ew/xfqyKFZCxFyYbERejfK+z
	 gj0CFfbt10F3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 04/23] mptcp: map v4 address to v6 when destroying subflow
Date: Thu, 18 Jan 2024 14:11:44 +0800
Message-Id: <5b291bca5a8a69217ae9e1090c94fb8e10b0b4ce.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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
index 8ca6e28a121e..7bb3574cc65a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -497,6 +497,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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

