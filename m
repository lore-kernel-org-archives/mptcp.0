Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CD19309C
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743481821; cv=none; b=eh3l+LzUBNKSQZeSOPVWFikHurEIhRp+oIx7u8GhNcfBNAHDP77umaVkuOAFdaFlKr4XEBm5HAO+XrEmHMtRfF/TsjK3L/KEqL364lOXvyN/U/P2jiWvMxemoMyrXZ0DchGenbCNyJ4VkyLm5jb7D/fKUBDmloSSkCbXB1DGxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743481821; c=relaxed/simple;
	bh=l38BQoX6CJhk7VAP8TTYDh6GDT4L6IvBrFy/K9nk4SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drPvqKyCxpCimjK1KMLv2SSlqATwuLEpwTpvb0laS9bWBwMgXbHaB5exF2rCYERvJZOoQZdBex/YQ5rfKnwOnjii3dT9HomiFG+IY30p5PmXhCsFOhN4Qc3SAUJN6cjXu0V6dm27sY14PPCAz/4qH0ZADgKNGsu9GKEjQAz1iKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNbyDZwm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNbyDZwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB0C4CEE9;
	Tue,  1 Apr 2025 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743481820;
	bh=l38BQoX6CJhk7VAP8TTYDh6GDT4L6IvBrFy/K9nk4SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNbyDZwmEDCioFW4RPguFkub3ZNteMxQaZhww2DmfmiCbktWU3Qn+iL4A+inhjdF0
	 roPDMkk+lrGF58dLO4SRTTZ8uXxCndCKG9k+137tTNM6zn9LyvH18j0N7wygYolVSp
	 CjzNCyDAdbjrs6Yrsxv5B21lMxdtRpf2Ma4L4Lda1kdme+t1w9J8l8w/gtaWjR3L0l
	 Clt10ihc7Wp3bsPwEopw9KyV3ERge91KVCShEj6Z7tBlnA18833qCYyoUSHK4j3sI5
	 DSEEeOAbBtQ4cbpg/4Go4cy+SW9M4mOt8fm+yfC0GhNjjT9q1+dOQceW+Jh3iWsPe0
	 aA6tQer4hFaew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/4] mptcp: pm: add accept_new_address() interface
Date: Tue,  1 Apr 2025 12:30:09 +0800
Message-ID: <94e82037a2f86ba85bc0f7c5ada46424b785073b.1743481566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743481566.git.tanggeliang@kylinos.cn>
References: <cover.1743481566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to the accept_new_subflow() interface, this patch adds a mandatory
accept_new_address() interface for struct mptcp_pm_ops, which is used to
determine whether an ADD_ADDR address is accepted by PM.

This interface is called in mptcp_pm_add_addr_received(). If the address is
not accepted, increase MPTCP_MIB_ADDADDRDROP counter and return.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  4 ++++
 net/mptcp/pm.c           | 17 ++++++++---------
 net/mptcp/pm_kernel.c    |  8 ++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 1eae68c9e662..d6bb030b14c6 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -129,6 +129,10 @@ struct mptcp_pm_ops {
 	void (*established)(struct mptcp_sock *msk);
 	void (*subflow_established)(struct mptcp_sock *msk);
 
+	/* required */
+	bool (*accept_new_address)(struct mptcp_sock *msk,
+				   const struct mptcp_addr_info *addr);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f37ddd6111de..519beb8cadfa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -589,22 +589,21 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 
 	mptcp_event_addr_announced(ssk, addr);
 
+	if (!pm->ops->accept_new_address(msk, addr)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_ADDADDRDROP);
+		return;
+	}
+
 	spin_lock_bh(&pm->lock);
 
 	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			mptcp_pm_announce_addr(msk, addr, true);
-			mptcp_pm_add_addr_send_ack(msk);
-		} else {
-			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
-		}
+		mptcp_pm_announce_addr(msk, addr, true);
+		mptcp_pm_add_addr_send_ack(msk);
 	} else if (!mptcp_pm_accept_address(msk, addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote = *addr;
-	} else {
-		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 	}
 
 	spin_unlock_bh(&pm->lock);
@@ -1046,7 +1045,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->accept_new_subflow) {
+	    !pm_ops->accept_new_subflow || !pm_ops->accept_new_address) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 000f4f173ad5..defd8312a764 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1413,6 +1413,13 @@ static bool mptcp_pm_kernel_accept_new_subflow(struct mptcp_sock *msk,
 	return ret;
 }
 
+static bool mptcp_pm_kernel_accept_new_address(struct mptcp_sock *msk,
+					       const struct mptcp_addr_info *addr)
+{
+	return !(mptcp_pm_accept_address(msk, addr) &&
+		 msk->pm.status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED));
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1439,6 +1446,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.established		= mptcp_pm_kernel_established,
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
+	.accept_new_address	= mptcp_pm_kernel_accept_new_address,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 31da3b9f4cc8..b09582c0118d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -689,6 +689,12 @@ static bool mptcp_pm_userspace_accept_new_subflow(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_active(msk);
 }
 
+static bool mptcp_pm_userspace_accept_new_address(struct mptcp_sock *msk,
+						  const struct mptcp_addr_info *addr)
+{
+	return mptcp_userspace_pm_active(msk);
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -698,6 +704,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
 	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
+	.accept_new_address	= mptcp_pm_userspace_accept_new_address,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
-- 
2.43.0

