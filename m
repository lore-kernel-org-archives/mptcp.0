Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F1D530
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662489; cv=none; b=rchwwwXPEC6lt1DOMChD3ElAj+QIFxKviYoRSv4A4DUgbngE82mgNd4HvhRo4sN6U+FPzxentiNOTMIS6n02+nsyk21Y/pqNhdYn2j6u9G0aX4TT0UCV72robSGneutIzWcj4ZXL1kX4Bsj6vbxmgjA2lMdPHFLLz9JQNxd5NuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662489; c=relaxed/simple;
	bh=NhnSilVqxr5oSFN5ME29n1VucyrU6H74r8I4d8z05d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACwsqt+F5etnwZd6Q8tXe77LkklqTpQcHfougNVGrLvvpK633adeUmkloua+sC4Asf89hzu7Xc7/iA9SMJ2UEovM9brHTwo4lzYaJlJW+vE3EWUATKURXtFA+xDjxkMMeA3pfGidgY4vnbLxMlgmv19/EaCTkOGsSS82bYTF9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJKj4JiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJKj4JiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7A7C4CEC5;
	Mon, 30 Sep 2024 02:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662488;
	bh=NhnSilVqxr5oSFN5ME29n1VucyrU6H74r8I4d8z05d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJKj4JiInE+7PkLp03LeNtQFe+xnWu0o8OAuXNldrUNWXzI6d7CP4dqD6v2W3BP8r
	 SuLaw+nj6OlYnKbxl2eLzjMPoun0cXVs+H/pndv7lSjBwMPzSJiOCWvdXQJfV8kTfA
	 LWkcpXD9RaVj+fDoRqKKQVUshJgRegth1E4OWHYXUkTICi24cEwoNs9vVsTn8+O2HH
	 qyBSGfhKdLH6+u/CN+cDeXYa143mjm7OgyjGw4fiCFNWKheYbkxAd1PFXUP+sSdl5E
	 oweOD9V2JpL8jA7wDFsKbktt/RQFbYrkPhy0wujjwMuvDeU2BTK0IYguKABFry7HjG
	 2J+0S590QhyMg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/8] mptcp: change local as mptcp_pm_addr_entry
Date: Mon, 30 Sep 2024 10:14:30 +0800
Message-ID: <4b404eef394bcb5ad6b0c6b349270488cd2af5bf.1727662123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727662123.git.tanggeliang@kylinos.cn>
References: <cover.1727662123.git.tanggeliang@kylinos.cn>
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
an mptcp_addr_info one:

        (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the subflow_destroy() interface uses two mptcp_addr_info type parameters.
This patch changes the first one to mptcp_pm_addr_entry type and use helper
mptcp_pm_parse_entry() to parse it instead of using mptcp_pm_parse_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5ae19b96bfd5..ff82ae39d5cf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -469,7 +469,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info addr_l;
+	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
@@ -496,7 +496,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
@@ -509,35 +509,34 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
-		addr_l.family = AF_INET6;
+	if (local.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(local.addr.addr.s_addr, &local.addr.addr6);
+		local.addr.family = AF_INET6;
 	}
-	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&local.addr.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &local.addr.addr6);
 		addr_r.family = AF_INET6;
 	}
 #endif
-	if (addr_l.family != addr_r.family) {
+	if (local.addr.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
-	if (!addr_l.port || !addr_r.port) {
+	if (!local.addr.port || !addr_r.port) {
 		GENL_SET_ERR_MSG(info, "missing local or remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
+	ssk = mptcp_nl_find_ssk(msk, &local.addr, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.43.0

