Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0A1F150D
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047827; cv=none; b=ioKCTqKrc7dBLI9aOtuBDYp+I9DD88WwRmGlfgPw6WtSNmcyvxkM+YDINb3vZFo/C6R2ymvu4mQa4z/Jk9G+c6wLENEy9KpiAsx3UjJ5v2kVje+MeMBwALALnECeHsdDfgxDvEODV5IWPBZknY2htTErVyb+UYSeiGMs3v6mLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047827; c=relaxed/simple;
	bh=aAE+JnEY/XiqaoLlRbxwjgpnvo1/AYjNsdDGI62RhKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GypnVsa57ty9tBDI2WiqJcg70onVIvzslvfBAXGXZlkoPu2LSAYHMwXPJoHVmMN2leW2X1LsvMMmw8HWF4fggi+UGGbIqATHs2rrKFnhQkhEAf/c3qc6rDE0KSi3jLyJNi9RzWvyIemOW/ALAwNDDy6rcln9BPzivwKoMC++Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDXMkCQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDXMkCQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA282C4CEE4;
	Thu, 20 Feb 2025 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047827;
	bh=aAE+JnEY/XiqaoLlRbxwjgpnvo1/AYjNsdDGI62RhKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDXMkCQZ4tBo5OGG/Sb1GL+e5jaeUMy03kr0uAQpyjLkM01CE5yanQNXE9sIzeLKo
	 X7qqkpsEOyVkXQtr+J0KMHLZ+OI+GUxAHCy7Y/yIemHmDeVdCGRmq2UD3o+KiMDSk9
	 1aveOJYVRbhVw4gfZwHkKhy2yd1LReuCXr/5/S4uwRx6os78mKM1I0+8CHyZBnAsdH
	 RgGyT9LSZsad6pD41VYo+4K8kcu83faanj4PYC5h1dkb4FUusKA63hwcTG8oiE0Px7
	 PM8Y7rVPLr81AW8Ao0OVA3H5+k6scUNU04NGzBxp6X9Ce+Ab059u7343NVmolbXsIi
	 fvjLyFmGXb5TA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/9] mptcp: pm: in-kernel: address_announced interface
Date: Thu, 20 Feb 2025 18:36:51 +0800
Message-ID: <5881dc057b4927f30070193bde21703f0079e233.1740047738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740047738.git.tanggeliang@kylinos.cn>
References: <cover.1740047738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract address_announced() interface of the in-kernel netlink PM from
the helper mptcp_nl_add_subflow_or_signal_addr(), only leave the code
for traversing all msk in the helper.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3914b80ed225..107f13560202 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1348,6 +1348,25 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
+static int mptcp_pm_nl_address_announced(struct mptcp_sock *msk,
+					 struct mptcp_pm_param *param)
+{
+	struct mptcp_addr_info *addr = &param->addr;
+	struct mptcp_addr_info mpc_addr;
+
+	/* if the endp linked to the init sf is re-added with a != ID */
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
+	spin_lock_bh(&msk->pm.lock);
+	if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
+		msk->mpc_endpoint_id = addr->id;
+
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
 static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 					       struct mptcp_addr_info *addr)
 {
@@ -1356,21 +1375,17 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
-		struct mptcp_addr_info mpc_addr;
+		struct mptcp_pm_param param;
 
 		if (!READ_ONCE(msk->fully_established) ||
 		    mptcp_pm_is_userspace(msk))
 			goto next;
 
-		/* if the endp linked to the init sf is re-added with a != ID */
-		mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
 		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
-		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
-			msk->mpc_endpoint_id = addr->id;
-		mptcp_pm_create_subflow_or_signal_addr(msk);
-		spin_unlock_bh(&msk->pm.lock);
+		mptcp_pm_param_set_contexts(&param, NULL, addr);
+		msk->pm.ops && msk->pm.ops->address_announced ?
+			msk->pm.ops->address_announced(msk, &param) :
+			mptcp_pm_nl_address_announced(msk, &param);
 		release_sock(sk);
 
 next:
@@ -2394,6 +2409,7 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 };
 
 static struct mptcp_pm_ops mptcp_netlink_pm = {
+	.address_announced	= mptcp_pm_nl_address_announced,
 	.get_local_id		= mptcp_pm_nl_get_local_id,
 	.get_priority		= mptcp_pm_nl_get_priority,
 	.type			= MPTCP_PM_TYPE_KERNEL,
-- 
2.43.0

