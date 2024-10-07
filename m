Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF811D131D
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298416; cv=none; b=h909w335NNoOF4rzUF5gWQKiXNpadN954yl4bEI3N/x8oToRtI/tk+WujCKzZktfTGxXH/s1Bc1JF/1oDwAGjE/4SDWk9u/k+C0BfPqdufpF2PmrkOkQdBuEk2y8KZEgRSUQMxggm8JSc7wwQKYDQfDwZE+w29Bx/xbG2jcCxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298416; c=relaxed/simple;
	bh=aMpeyZ6/+/H/lGVoFPiGJQnezrT5elltKFPsGt3J5II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2J3w5NLr2nylCfV4+x9fTiWdtmdDAre62mICRlccQurnrMpd/aRnlFiBfbHp+0VSBsX5GN3+JgzzSZPL2prVccwT02s+b1v63kdAElxyaZmBBwZlqfws/bdDGzvKJyeT1evhUsfi7uR+jSQCzfq065sOX2HI7H0s3/mBlwqSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg8KoaLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg8KoaLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D896C4CECC;
	Mon,  7 Oct 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298416;
	bh=aMpeyZ6/+/H/lGVoFPiGJQnezrT5elltKFPsGt3J5II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vg8KoaLd9Ue84hgo+g3pVMLfx0CRlJp1FnyK+RsW1VXGvuc1MksZnkTnCPxZixPCE
	 rOPMXM8mvCvfS/WDAqkMU88KwafxuJA6AH3bPkI6O7Yj8UcYq3xqETG71tGZ5Ks1ef
	 056QjniUPY3vn0DfCwZBhnyjtgMkAAm1ax0wKbsbmo7pMXqi4vCHTRKU4vzD6qQKkN
	 qubIAU14COFrEgS8QuupO0rhZ3wIYTmWycRkDEdD0yg5zTSL9WVhXjHAPCnCcWNS5x
	 AnUabDuS6pW1zAhAnj0l9YavyoOZr+ICoIbUOTpWxIxyx7PIT9tif+w5Mh/ZYNI1wa
	 rvPuSzEdD0tjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/10] mptcp: add lookup_addr for userspace pm
Date: Mon,  7 Oct 2024 18:53:17 +0800
Message-ID: <25c49a66e1228a26a285f3a678200800f5498204.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
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
index b7272289d4c1..58599f32b279 100644
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
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
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
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
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
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
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
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
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

