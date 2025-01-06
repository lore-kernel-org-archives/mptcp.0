Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1D1D5CD9
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151399; cv=none; b=BjZJSkAiSXLx5qU4ktCKpOy0pkMbw6FfXW9JWdFZHZ22MoeD+UpUS3CDkzwD8CtcRqqHGzq4lUl+enHg2QI+/VmBOzWGlpa1C3jkFBVCGs6xOrRsjdrBjabEpcp2RrJTO7Yjgzo2ahizY1JpQ38tpYIfBLUtQ3u4pkCiN3xmJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151399; c=relaxed/simple;
	bh=6uHMBUmfTy3WZL5C6JpXhdK+Qd+5DyOYkxhDvtI02YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThY5CgVqtrcISNA7aMSAGVI/Xw1iTQ5Crh9FK1ni9tDCB930M6R91eIRR7mQAB2dcI2mfRlt6kL4rcx9uN0d6eioo8v6u3XmVS923J8MbvcOmFGTEyLb6If7DZGKBvgfVNY4tAzfFqNCaFbFcre0S16eQMlbXZnGPYy7FPNjWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiSb/2dp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiSb/2dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749EEC4CED2;
	Mon,  6 Jan 2025 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151398;
	bh=6uHMBUmfTy3WZL5C6JpXhdK+Qd+5DyOYkxhDvtI02YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiSb/2dpktly+ikc/XX4tDir9mjPaEecS9wsRwgw0pjSKdt/VtWNxfRsRJPx1IeGe
	 y3dWCcFwCM1ENLO8Q0k/5B60ekXl/q6pXNl94KAqi7pyRfAhzq4OcJfjxnK6qo0ZMd
	 0Bryze5+exf5ss7t8M5vef5Q5i+kOWn+vi5j6IGGMADZDUHqe5y86uuOL5ZlaSqJbp
	 e8coIMUNExjJyufV1LWU5WTJUDyQxXe7Wem3j1LyZW6wHu/eGy2ON5R8Bg4I/4zRvZ
	 jwM1eub3UMRQsEc7XrJKJlay83qa1vWRyubXL+VQRvADQHOfUbqERATXO+iLTGtccI
	 PmixPCmhu+pBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v7 08/11] mptcp: pm: improve error messages
Date: Mon,  6 Jan 2025 16:16:13 +0800
Message-ID: <4078a76f5e18d55532f87e4d8a936876d356222c.1736150983.git.tanggeliang@kylinos.cn>
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

Some error messages were:

 - too generic: "missing input", "invalid request"

 - not precise enough: "limit greater than maximum" but what's the max?

 - missing: subflow not found, or connect error.

This can be easily improved by being more precise, or adding new error
messages.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 5 +++--
 net/mptcp/pm_userspace.c | 7 ++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 46a97a3bf319..528718cb70ec 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1878,8 +1878,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
 		return -EINVAL;
 	}
 	return 0;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 066fd89b1691..341db3bc191b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -191,7 +191,7 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token,
-				    "invalid request; userspace PM not selected");
+				    "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -430,6 +430,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
@@ -555,6 +557,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (!ssk) {
+		GENL_SET_ERR_MSG(info, "subflow not found");
 		err = -ESRCH;
 		goto release_sock;
 	}
@@ -613,6 +616,8 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, remote, bkup);
 	release_sock(sk);
+	if (ret)
+		GENL_SET_ERR_MSG(info, "mp_prio send ack failed");
 
 set_flags_err:
 	sock_put(sk);
-- 
2.45.2

