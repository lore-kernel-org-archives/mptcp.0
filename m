Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADA1D86F1
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151403; cv=none; b=j7J2dClT+Hiuy3J0S/82POPBcfTPnwm7kjuoUCUqv6KMfhbWG9Ij/hVvhFxsAu+THABj/jk+rRNV5m9GzaVIcxJXHHCowNMq8Uniq02ZEcM0QuVdTCHouzAZFxtBJrI6/Edcj0Rqgfa1iVop8gnkzS7sJuxweiRM2UwsUqzCag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151403; c=relaxed/simple;
	bh=oZD1fClnFf/1kfrUw9Di63AWWA7Gv4PjDqDsDnCjAPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wak79ezUQz7mxIuyoqVscwYSLl/jNx+4gMeJziiMK/R877ghsyxwIjhJcxA4fdNnlrN+PIFEJtzKLiIiLgewAq7TT9FLqoJG33FAItRJzFvNkt2hDYBK0CmdWadQoZtj0LRsgCHLByQljoD7yxcxKC+LZvLN+JeL0sAsgGt3tAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlZXoRvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlZXoRvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB3C4CEDF;
	Mon,  6 Jan 2025 08:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151402;
	bh=oZD1fClnFf/1kfrUw9Di63AWWA7Gv4PjDqDsDnCjAPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlZXoRvnfcv3DAkzhQaynDov83283Vimm1pVtxfo1ed3z6sB/spoAEpDsgm8dBsZT
	 SeK67bu6HGSLj/O1dw6BnejzpneJo42wDACF0ZkM7ZlXtZyfAt71rjru7XpMVlTk7S
	 Wd6iyRT6n3Byg4Rq/etWMqOe8EBzgF/qccUHie4XN6WalypCvcD0vgptO5KsqBBCw6
	 IAYeKdFkfspAYNyBI2nlgGYBosrLESkmVFPm402qFZIU4/bHeypHWLXtX9gV/VVv4m
	 xvIDZC0kn6TYIicd0eGkcnXJ+nXQI11sHHiU8yqxr6wkmeEJhVurC4zU5BN9ajHPx2
	 OUF8JclchECrQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v7 10/11] mptcp: pm: remove duplicated error messages
Date: Mon,  6 Jan 2025 16:16:15 +0800
Message-ID: <df1ca389e914146a25c35296c5be0bf61e52d7f4.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

mptcp_pm_parse_entry() and mptcp_pm_parse_addr() will already set a
error message in case of parsing issue.

Then, no need to override this error message with another less precise
one: "error parsing address".

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 201595f9ebf9..dc9ebfb06d96 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -217,10 +217,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "error parsing local address");
+	if (err < 0)
 		goto announce_err;
-	}
 
 	if (addr_val.addr.id == 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
@@ -388,10 +386,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid addr flags");
@@ -402,10 +398,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
@@ -511,17 +505,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-- 
2.45.2

