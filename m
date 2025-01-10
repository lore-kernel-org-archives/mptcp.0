Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C814A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494263; cv=none; b=YI/3NKMV7dH4plOLtg3rQrSH2TFzA8WRH18bLMhBESoCSN6lGdjROI08VakOGuMm/UeP8eFziFgyb6g+tSFVqLlQhqVtmj2tr77ondmCCDQn9MhbB+cDpSnPirhTUDSxCwXLm8Iagq8TrQczv+3XjnrEQ8ebspRdbFVlRnXedf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494263; c=relaxed/simple;
	bh=6tMv2AIrkrsTEWhm5p7v6KQKkWs+IUaSMu4lNIkR1qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2J3hB+vKgq6t+Z524djq/jR06liMuvmgeLA0GgUe750jKTCkYxXhZxtPaEFr4zsd7b2+NGBeHv+2vU1PE3hYkKSIJuNq5YPY0PCChxgsEH5elcxVIVb0Wne5T9yhLVV3qdkYe5qKCsaYU33tu6fIG/gkTjdBvSBYoIqPdyI6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdTuglr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdTuglr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D490C4CEDF;
	Fri, 10 Jan 2025 07:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494263;
	bh=6tMv2AIrkrsTEWhm5p7v6KQKkWs+IUaSMu4lNIkR1qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdTuglr8eP6gDJCcDGXRsOqCS9/tZpUfxwr1X7PK519I98x9xCCDyfo518wpO+Sw7
	 KYk5FP0s8pszG5He7nrjFrvVpnRcXK58WODBBH31y7GDEzeR+RZLI1h8IzpqhzO3sB
	 rcY3xVbrHZtF3j/3qrFsYOCXA3BopYk5AUMFnMNDDXbK7JyW2NFaS1OIaEkGUDxhFb
	 /R9G8IID4YQyuFsRi+oE4e7Xw+NpYdcP0K8FXQB5qsbIGe+TgpnMXJmAoHM2TQQID7
	 OjXLQJ1mRBL7AQCOkB8weQOQdLTcifdSYZFYzTTjR8Ufc40Tq/aTnuqj9MVmYr7ex5
	 NMrP47mvuHaxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 8/8] mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
Date: Fri, 10 Jan 2025 15:30:42 +0800
Message-ID: <0416e719bbf265607b2c8c9065bcf8fbd0bbb685.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Instead of only returning a text message with GENL_SET_ERR_MSG(),
NL_SET_ERR_MSG_ATTR() can help the userspace developers by also
reporting which attribute is faulty.

When the error is specific to an attribute, NL_SET_ERR_MSG_ATTR() is now
used. The error messages have not been modified in this commit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - update the code related mptcp_userspace_pm_remove_id_zero_address()
   since a new patch to drop "info" parameter of this patch is added.

v3:
 - not use NL_SET_ERR_MSG_ATTR in mptcp_pm_nl_set_flags(), since 'attr'
   will be removed in the commit "mptcp: add local & remote parameters for
   set_flags".
---
 net/mptcp/pm_netlink.c   | 13 ++++++++-----
 net/mptcp/pm_userspace.c | 24 ++++++++++++++----------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ab56630b1d9c..c6fd3b1727d7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1407,18 +1407,21 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	if (addr.addr.port && !address_use_port(&addr)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
 	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
-		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags mustn't have both signal and fullmesh");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
-		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "can't create IMPLICIT endpoint");
 		return -EINVAL;
 	}
 
@@ -1616,7 +1619,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
@@ -1802,7 +1805,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 525dcb84353f..4e5511ede7af 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -189,7 +189,8 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "userspace PM not selected");
+		NL_SET_ERR_MSG_ATTR(info->extack, token,
+				    "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -220,20 +221,21 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 
 	if (addr_val.addr.id == 0) {
-		GENL_SET_ERR_MSG(info, "invalid addr id");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
 		err = -EINVAL;
 		goto announce_err;
 	}
 
 	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 		goto announce_err;
 	}
 
@@ -388,7 +390,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid addr flags");
 		err = -EINVAL;
 		goto create_err;
 	}
@@ -407,7 +409,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
+				    "did not match address and id");
 		goto create_err;
 	}
 
@@ -528,13 +531,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	if (!addr_l.addr.port) {
-		GENL_SET_ERR_MSG(info, "missing local port");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
 	if (!addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing remote port");
+		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -599,7 +602,8 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid remote address family");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+				    "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
@@ -722,7 +726,7 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}
-- 
2.45.2

