Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B91F0E31
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047836; cv=none; b=h5P3wpubmYnhe63duQAPRWqV52ycZnUhgShtNMCaC96fJN1KeROSBBpWSYsMGEHwLr/HhjRAwam9Q46iuHkZZJw09s9H8NGAI0JrIPkLidHk1vdpLCS35v/LJbp6BYClg4EbMwe22DWel3queG53sUk8TTiDv1NgpjwmoggCwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047836; c=relaxed/simple;
	bh=o4qthuCsK8ZCry973EgmPqhYZV1sKjE5yOz6H+N0IN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NklcbIcPUEDGFckCwvUtiRTKHh49U0IxkQ6hySZPdBVWTf3QT3IfZYPayf7vnywawHeOpka86+sofkxIYOk4l+Aiws+b0qKyzJABG7oh6l6B/ZMm5NDD4YAT+Lx4CG25aqrx4OzpxWW0wCF74a46VlUmfUsZ60cZHy4IpC1gVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFPWDxm0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFPWDxm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F4C4CEE4;
	Thu, 20 Feb 2025 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047836;
	bh=o4qthuCsK8ZCry973EgmPqhYZV1sKjE5yOz6H+N0IN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFPWDxm0HT6GUmVsNgBdRSww4fARcweRy0FYhH7ThbHBRMuwRv99UgQ4MLnLDSjTh
	 yZsLBWAmOfvJxVahhArcunT1i8oFAvc8RGBVTxJ9tycoS7LvxYUB4yT2MlIfz2n3b2
	 txhy21mvRtxMhrx9vDtcoR35NEiIVMFPKKv3WUy+F76LVF1i4GcvnOihH7zH2Oh9pE
	 +UYQuCcTDbGjgYOGsQwIiMbCCIeG2P+zSP76cEYkIXPXK8NA+fSGWu6IXMId9QL0VA
	 pd1phzg1i0mqXmXm+nN0WbOD5hv1NgJ/AzDrC1AwI1Wip0s5k/Du1qIExDI4HIuYXL
	 /2Lk69Ec9XvKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 9/9] mptcp: pm: userspace: subflow_closed interface
Date: Thu, 20 Feb 2025 18:36:58 +0800
Message-ID: <2bf0f00efec0394db5b33d5cd6fc74178ea9c736.1740047738.git.tanggeliang@kylinos.cn>
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

Extract subflow_closed() interface of the userspace PM from the handler of
netlink command MPTCP_PM_CMD_SUBFLOW_DESTROY

	mptcp_pm_nl_subflow_destroy_doit(),

only leave the code for obtaining msk through "info", parsing local address
entry and parsing remote address info in the handler.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 45 ++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bd497893c927..9fd93acad38a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -501,14 +501,36 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
+static int mptcp_userspace_pm_subflow_closed(struct mptcp_sock *msk,
+					     struct mptcp_pm_param *param)
+{
+	struct mptcp_pm_addr_entry *local = &param->entry;
+	struct mptcp_addr_info *remote = &param->addr;
+	struct sock *ssk, *sk = (struct sock *)msk;
+
+	ssk = mptcp_nl_find_ssk(msk, &local->addr, remote);
+	if (!ssk)
+		return -ESRCH;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, local);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+
+	return 0;
+}
+
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
 	struct nlattr *raddr, *laddr;
+	struct mptcp_pm_param param;
 	struct mptcp_sock *msk;
-	struct sock *sk, *ssk;
 	int err = -EINVAL;
+	struct sock *sk;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
 	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
@@ -559,21 +581,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
-	if (!ssk) {
-		GENL_SET_ERR_MSG(info, "subflow not found");
-		err = -ESRCH;
-		goto release_sock;
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-	spin_unlock_bh(&msk->pm.lock);
-	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-release_sock:
+	mptcp_pm_param_set_contexts(&param, &addr_l, &addr_r);
+	err = msk->pm.ops && msk->pm.ops->subflow_closed ?
+	      msk->pm.ops->subflow_closed(msk, &param) :
+	      mptcp_userspace_pm_subflow_closed(msk, &param);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "subflow not found");
 
 destroy_err:
 	sock_put(sk);
@@ -719,6 +733,7 @@ static struct mptcp_pm_ops mptcp_userspace_pm = {
 	.address_announced	= mptcp_userspace_pm_address_announced,
 	.address_removed	= mptcp_userspace_pm_address_removed,
 	.subflow_established	= mptcp_userspace_pm_subflow_established,
+	.subflow_closed		= mptcp_userspace_pm_subflow_closed,
 	.get_local_id		= mptcp_userspace_pm_get_local_id,
 	.get_priority		= mptcp_userspace_pm_get_priority,
 	.type			= MPTCP_PM_TYPE_USERSPACE,
-- 
2.43.0

