Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A680139D1B
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300663; cv=none; b=CNSqoVihseQ4CAYGbwfGvwQxd6scfC7OpepBYbRXeqisteXofzFafrrAxa+AnbNLZQdttoLMyPB4v2q1xyLsyB+B/TZ+DPoUr+XwlNXjM1OHv3nTG9gRNhzQx0xaqgktAPTF/e8I9zV7IIi3LX7NX8rTJkDdlXyAbjo62AXOb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300663; c=relaxed/simple;
	bh=g+PDOpELuumD0L2THzgQhquEm3ukHOmoPKjaFUob+No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAmZpV4AC8XPOH0q2QbWKU4LXjiZJqLdzx/gjTK5dXTjSUqrLEliieqQnWcwMI+UoAeN45vBjofy0zO1kQHjXXR/EUBtCcOUztiESRejGlDc2UPgvJyVAX6NVPLG8iT6372Wo9uAVNF5gUicSGBYbg/xXHgSpk4okRRrs1QM1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdunhB17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdunhB17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF755C4CEDF;
	Wed,  8 Jan 2025 01:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300663;
	bh=g+PDOpELuumD0L2THzgQhquEm3ukHOmoPKjaFUob+No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdunhB17LsVmZjmdsm/aEx9iPtdry9gIVckogKszxfQCX1D+P1Ltka2Q4dGKDssHa
	 bTggqsp5CZnkDqhIHirTMZ/5f36pMFgE2bdq5n+QXmpSL0M6bUtTkJafc2ITPI2cYA
	 YsuPKyL9xtk3qZ+Lqts4ei7Bjg8yCi/VPzGFZpRQq/BXJIQUwQsKgV5JDta+Q5JA+Q
	 hHXL3hM9ngA6IQbWG7JPVOWYfFUFs92NiCaF+g4GNxCguPOhQ2wv5DNxc34VbWPMij
	 DKHSD4VR6vmM9M/9K1FQS/q7VuKyhzkVuZwiCzBtsDANAGESLcQAYRa4uRRCsiURrt
	 MfkB47yYR620Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v8 3/8] mptcp: pm: more precise error messages
Date: Wed,  8 Jan 2025 09:44:04 +0800
Message-ID: <fcefd80ced3aec8994c3007aa041780171c96bfa.1736299989.git.tanggeliang@kylinos.cn>
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

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Some errors reported by the userspace PM were vague: "this or that is
invalid".

It is easier for the userspace to know which part is wrong, instead of
having to guess that.

By splitting some error messages, NL_SET_ERR_MSG_ATTR() can be used
instead of GENL_SET_ERR_MSG() in order to give an additional hint to the
userspace developers about which attribute is wrong.

While at it, in mptcp_userspace_pm_set_flags() move the parsing after
the check linked to the local attribute.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b6cf8ea1161d..2cb42091bd08 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -223,8 +223,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+	if (addr_val.addr.id == 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
+		err = -EINVAL;
+		goto announce_err;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
@@ -531,8 +537,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	if (!addr_l.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
+	if (!addr_l.addr.port) {
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local port");
+		err = -EINVAL;
+		goto destroy_err;
+	}
+
+	if (!addr_r.port) {
+		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -580,13 +592,20 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
+	if (loc.addr.family == AF_UNSPEC) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
+	if (rem.addr.family == AF_UNSPEC) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+				    "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.45.2

