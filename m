Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB951B7F4
	for <mptcp@lists.linux.dev>; Wed,  2 Apr 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562399; cv=none; b=RmRMk6fd1M3E0LkTM3SpeP7H74Q0akHMfom5Gv9fIdRkpLmnuVKLYQRT9YWGiJA0oGjJgnxIV1c1a0i7Q39vBxRvmAvjzlO+HoXiJd5JJvAP3zErt6LT+6hh1jCVKD8JZ9mXQeQ/Tz2iI6SyqSiTU9ypMEO2QoUSs70qV2Y/pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562399; c=relaxed/simple;
	bh=G5E9/HlwhUJ14XucItH8hBrV6zJAQ4p5TWKjV8Re1I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moCElmW4ZsHA4oKoNmGB4zqpfC6VpmdobHMDDSrUIQqWdVyxaZs78z/VA9dY/TibPy5r16JT9J3osUCfibOumOL7KJbgRVwznf9nukbLRmZ2ivgLSbckiOlG0fCPBAsKfS7tfCzuo5pkMge+bD6it3bT5dXOLFgKT28HJzyGzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHdFTEAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHdFTEAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8849C4CEE4;
	Wed,  2 Apr 2025 02:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743562398;
	bh=G5E9/HlwhUJ14XucItH8hBrV6zJAQ4p5TWKjV8Re1I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHdFTEANVgiIqnbeWAFstzo9lD2kk4n4SeesRvaqr2LxSqFLOhksnsoBggJV69Afp
	 u+80znoX+99t+rpYaGMT9yriGk3cq6E1/SxHVzRZ1ejxYsx4vfOXi565IiAJqFyk+I
	 tnCVK8VYZMKdwKjfnHB7kvoBcZBkRZmw2Da1eCCvST9NCKSpO6yPu0KLiRZcGBzQx+
	 Re8+x4PXYWmU5uSMld4NNfXFIB9HBBSO9pw8Jk+Di1tHdP1AL1RjLO4vREi1lAv3zK
	 jK9gEamDzOB0XmdnW446J6P2PAmljcL/5f0uBalsfuMwh3Can6IKBKzbiFWrkACGJP
	 Tz744VzaIdpgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: pm: userspace: drop delete_local_addr helper
Date: Wed,  2 Apr 2025 10:53:08 +0800
Message-ID: <f03554fea72ef5e89f940767466f88f0af36f88c.1743562290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743562290.git.tanggeliang@kylinos.cn>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address entries should not be removed from local_addr_list when a subflow
is deleted by the userspace PM, should only be removed when sending a
REMOVE_ADDR.

So mptcp_userspace_pm_delete_local_addr() helper shouldn't be called in
mptcp_pm_nl_subflow_create_doit() and mptcp_pm_nl_subflow_destroy_doit().

Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it can be
dropped now.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index db471eb836b3..3824b4165421 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -90,30 +90,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
-/* If the subflow is closed from the other peer (not via a
- * subflow destroy command then), we want to keep the entry
- * not to assign the same ID to another address and to be
- * able to send RM_ADDR after the removal of the subflow.
- */
-static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
-						struct mptcp_pm_addr_entry *addr)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry;
-
-	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
-	if (!entry)
-		return -EINVAL;
-
-	/* TODO: a refcount is needed because the entry can
-	 * be used multiple times (e.g. fullmesh mode).
-	 */
-	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
-	msk->pm.local_addr_used--;
-	return 0;
-}
-
 static struct mptcp_pm_addr_entry *
 mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 {
@@ -409,14 +385,13 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	if (err)
+	if (err) {
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+		goto create_err;
+	}
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
+	msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
@@ -535,9 +510,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto release_sock;
 	}
 
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-	spin_unlock_bh(&msk->pm.lock);
 	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-- 
2.43.0

