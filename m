Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EC18D626
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069975; cv=none; b=fGMfqPoF8DgpB6vPre6upXTUjhnj/YZCllctBmbim3UeN4eZ4MUMRIZELPYRCzw3y7DrIcFVI8PnvW6YW/M6QA94RmFnU4ih6UInFZ+Q5Sdz23LSdA8ttapPgZ1JXJcLixlKwmWUZtu0EQahhuG+/x0e2MZSpxhEyIKoKYAEv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069975; c=relaxed/simple;
	bh=B5nYLAXYrkgiPqTT3SqCU8tHkpgoP2QHSdM6l/QyU6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jwa8kNbt7M8f/mGE0urvUp9TfLSst5kiiKPWfR3D9w0KC/wOTWPwzgbDr3m2ZwlHfO7dd/YFxg60J8sEQYy2mjHdcvd1tkHC1tF7B/oSInPmfzPnHZ1pHDwHSbrfk2EI2Jx1Oatr15UflcLud57f2Q4OJvC2zFu9QnndaZMbxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLVm4txY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLVm4txY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85CCC4CED0;
	Wed, 16 Oct 2024 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069974;
	bh=B5nYLAXYrkgiPqTT3SqCU8tHkpgoP2QHSdM6l/QyU6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLVm4txYAFQfLShqOyB/HOF/ychLhBxT2wu29uqpychP4OhCqvZ7+zfGgLvNZtulz
	 tFcuT8c5U4MexzqDXZ19Z/6liRSHbb9pv0syUTAUwmq7AYWyrTsjTT96uPvU1r+O6r
	 TQyp3WGdX+L5uC8UyuKWXtnVec/Hq97J1JoREGlfAJUlfNjsm4zfvtZwlWqtSJRDIY
	 aXxSrdIajdQxdF1AFexsBtQQUNEtQlfEqCH6pnFo+BiXT4SA2HbDHwTQGOCUN6et8G
	 6fHxhhlTKW00uhOzi3pv0ztNqZzFSYHOLjMcQnsH4bhosQX7wKXaxWTcpGtpjDwI8T
	 uiXzTf2T04Jlg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 05/33] mptcp: add lookup_addr for userspace pm
Date: Wed, 16 Oct 2024 17:12:09 +0800
Message-ID: <70ba6915c9d654f691528bf3aa4e47198388d01e.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Like __lookup_addr() helper in pm_netlink.c, a new helper
mptcp_userspace_pm_lookup_addr() is also defined in pm_userspace.c.
It looks up the corresponding mptcp_pm_addr_entry address in
userspace_pm_local_addr_list through the passed "addr" parameter
and returns it.

This helper can be used in mptcp_userspace_pm_delete_local_addr(),
mptcp_userspace_pm_get_local_id() and mptcp_userspace_pm_is_backup()
to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 56 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3fb5713cd988..ce0f7131c701 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,6 +26,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk, const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	mptcp_for_each_address_safe(msk, entry, tmp) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
@@ -90,22 +102,20 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
 
-	mptcp_for_each_address_safe(msk, entry, tmp) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			sock_kfree_s(sk, entry, sizeof(*entry));
-			msk->pm.local_addr_used--;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
+	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
+
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	sock_kfree_s(sk, entry, sizeof(*entry));
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 static struct mptcp_pm_addr_entry *
@@ -123,17 +133,12 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_for_each_address(msk, e) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
-			entry = e;
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
@@ -156,12 +161,9 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	bool backup = false;
 
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_for_each_address(msk, entry) {
-		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	if (entry)
+		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	spin_unlock_bh(&msk->pm.lock);
 
 	return backup;
-- 
2.43.0

