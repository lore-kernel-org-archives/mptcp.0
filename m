Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B81F03F1
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047828; cv=none; b=QTjm7MRomvl1hw5TGwC/VSufQtmdrmHG/xjHP4/PIqwUjPNt5n8fE5i3NE4HSBwcxuNyFrOr1yvweE3hU4l5cE/XrBtzdjzyeMCTOXDopLfJKc3AWtmsYJJcrWV6FLqksz5DZfK09d+F45HULYcBQb27CwTijjRGja5KL4Su7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047828; c=relaxed/simple;
	bh=M1doJ8g8LtZ+OwGghIdabIumlqIJmibRcMFYb2IWokI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyZq0JEoNSobWJYYWrE2gGJwLq0TDKicUueTrq6slrqsAnPAEhBB35pjTwYbnRwFTJJQxVuYoPJhzaHJbEN42Vunu6NyKmKnZd9w0hSuxjdXdeSdBj06Np+bweoLJ+UAaQ37Oy7K3E3yAW1500TYXB2eOqtgdnjG1Hr5tg3I0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unpOSd5t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unpOSd5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8539C4CEE3;
	Thu, 20 Feb 2025 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047828;
	bh=M1doJ8g8LtZ+OwGghIdabIumlqIJmibRcMFYb2IWokI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unpOSd5t5/E2JAaLSlC1EXNP4UgM7iOnPO4ymf1MW5Zv6ChNro5jSaFCGlAzb+Ojs
	 3z3ES7RJoGVXdyY1iMy8weIClfLBxn0IMhig66ulZ+pQ62OFfWnIXbYxtE0RivDasM
	 9a9MKKUpUUwabZUdqGjMe6FbIUPD+oyOWlNdDupS7729G4pe1qgoGEK97CvB9Zg8Ix
	 S1NmyWChwLPwixAAOkrfgObyCBqq5hhyZ8u/sHorPRysAJXnS4tuoaTobDjKkuyTV0
	 3Z1ll/wj5Cw/8NbKcgKadNRnYZe6dw8Gy9hF9DqzqNYhDmSsxjvkYvKyOfmReepeXM
	 ZuMkf+YEaOIOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/9] mptcp: pm: in-kernel: address_removed interface
Date: Thu, 20 Feb 2025 18:36:52 +0800
Message-ID: <294f452c959c08593649eacfe77783cff96c0807.1740047738.git.tanggeliang@kylinos.cn>
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

Update the 2nd parameter of mptcp_pm_nl_address_removed(), and define it
as the address_removed() interface of the in-kernel netlink PM.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 107f13560202..53246a3a1b09 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1522,8 +1522,9 @@ static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
 }
 
 static int mptcp_pm_nl_address_removed(struct mptcp_sock *msk,
-				       const struct mptcp_pm_addr_entry *local)
+				       struct mptcp_pm_param *param)
 {
+	struct mptcp_pm_addr_entry *local = &param->entry;
 	bool remove_subflow;
 
 	remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, &local->addr);
@@ -1569,12 +1570,16 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
+		struct mptcp_pm_param param;
 
 		if (mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);
-		mptcp_pm_nl_address_removed(msk, entry);
+		mptcp_pm_param_set_contexts(&param, entry, NULL);
+		msk->pm.ops && msk->pm.ops->address_removed ?
+			msk->pm.ops->address_removed(msk, &param) :
+			mptcp_pm_nl_address_removed(msk, &param);
 		mptcp_pm_nl_subflow_closed(msk, entry);
 		release_sock(sk);
 
@@ -2410,6 +2415,7 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 
 static struct mptcp_pm_ops mptcp_netlink_pm = {
 	.address_announced	= mptcp_pm_nl_address_announced,
+	.address_removed	= mptcp_pm_nl_address_removed,
 	.get_local_id		= mptcp_pm_nl_get_local_id,
 	.get_priority		= mptcp_pm_nl_get_priority,
 	.type			= MPTCP_PM_TYPE_KERNEL,
-- 
2.43.0

