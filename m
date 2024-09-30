Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C30179BD
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662485; cv=none; b=ZFl80DXFElQ3rEN546QBhNHKNOYMgeYRFzxZ1dDpa4DHAAFsUqAc3/cKdyTpjbTATZt/9DIAT65tdnCchYy6l5YUyFozY21F06DQPWGLRYctLDx6UqrfoSEXEol3jOgsbEKdHhkgeiVnhrTvq/kcmX7kU9fZNvzrrz/owkSS44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662485; c=relaxed/simple;
	bh=xtU/+GQkQft4yMaAmXYW3cJQY8BvLPG+gne1eoFkG7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyFfzYuqSO07CB9z4WAa+KKSlM7Uryg/tZeUnVFpPiw67fceth72c2SlOHrxVVRQNBo357aPgRKQ8RIF+Hr3bgj69TFsOLlfTRGBsPxKNMAql57/Q0uI9SM9yG05VrFR4cKZ7+1ONGuOPyPpqCAg/nZe6v5ZEGN0jQs0bhn9onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFQMxyw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFQMxyw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0397BC4CEC6;
	Mon, 30 Sep 2024 02:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662485;
	bh=xtU/+GQkQft4yMaAmXYW3cJQY8BvLPG+gne1eoFkG7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFQMxyw3JcS2Kl/IcwjrMO4TN1Q8s15yHNxHgeny4uDSHvti0uG19l79pcaP4LczM
	 Hx4yx5HaEOAsn/dh/EROkkT+fTLir4xMOakcfcUQ6Hno951FgmMiNJjD7s9udoiSAb
	 zFio5vxaEgv4iEHQFqpdK/qxkEAidvqBmdne39cH1Li/V2U/r8dlc5Ss5LNoe71Kex
	 FLEYuvBkyhEh9tILIJp83MPznjvAjG2Fqik7G9FLT6EEaloJiUjFQMjhnyG36Rm6rT
	 lbFOXOVGS3VlukmYrMgKqdaZcFCbKvQ1dtqrCfygYiHRYOD4+cKMuMJBfFIKSIh7sG
	 QrP6e7ofPoOgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/8] mptcp: add lookup_addr for userspace pm
Date: Mon, 30 Sep 2024 10:14:28 +0800
Message-ID: <399834492f229b47fdd7fe09765226b716755bfd.1727662123.git.tanggeliang@kylinos.cn>
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
index e3f29d8865f4..60cd35942ee5 100644
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
@@ -90,21 +102,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
-
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
-	}
+	struct mptcp_pm_addr_entry *entry;
 
-	return -EINVAL;
+	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
+
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	kfree(entry);
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 static struct mptcp_pm_addr_entry *
@@ -122,17 +132,12 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
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
@@ -155,12 +160,9 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
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

