Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9431E2312
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685566; cv=none; b=glSGUsrnsqv2Fvfsk950grHilpKkL+dJXzdRB8yQhaii81M+pD4INSPFsc2s6MsjUxxIWJgPc3EXlg0IU6IzaVJO43hNRcSx73XQSXPyj1UYNloMgb4RH53NkI7Dpeso0XuD2HGjDbB7BxXtvxhWy1LpqMUhrnbXnRU2jOecQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685566; c=relaxed/simple;
	bh=8mEMRWk+voaAriV8guiXWOtPmFqwC/130wN3tkIinkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4iFfifltSBHOB0Zix1Nj+tAowmuTgDBWECf2P67HCQBd6NCTuDZjeirY5ixt+l5+9YsIMM0OGQN/7O4rOkaV8kO99IMcsoStGpSGmRtcmuey4f2qiGmyJENXr0Flp0HuuDQt8PyMkFzpUNMH8SBc/8eefUwvqDjSm8GSoMUoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVG6Z3/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVG6Z3/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0880C4CEE9;
	Tue, 11 Mar 2025 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685566;
	bh=8mEMRWk+voaAriV8guiXWOtPmFqwC/130wN3tkIinkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVG6Z3/Ye9tT87PM4IcXZgb4+S6Jvfglrvn0iMIgd4AulepwzhNR1PiMMppgxkj9H
	 +uYOlRGv2MXQSqsn6IACnPTRubETsGRC4zBVhZxFFsqgiwGuU11QztxXvgO0I66EX2
	 M0/eTy/TW5Hw6ivt4KBoW1a9NYLpUbZLNziLMewiGGpfwq6bfFcQgZQD32AXnV1Pt6
	 UqmnvptVURNORKu5ppBaffnhmMp+Ajm5vthewo3f1Grg9rUbJHcjNYQPRa/Aubi4mc
	 Wf84IevCv8OoLia7cWvLv9T70F+y+9DnC51JJBeeZk2XtuNIzWjbmAWcAb924oGg6v
	 CBKyN70KMBd4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/6] mptcp: pm: add add_addr_echo() interface
Date: Tue, 11 Mar 2025 17:32:28 +0800
Message-ID: <a550107394e989fb5557ce16fbb54050f4a20551.1741685260.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741685260.git.tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
operations from in-kernel PM in mptcp_pm_add_addr_received(). It seems
reasonable to add a mandatory .add_addr_echo interface for struct
mptcp_pm_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  2 ++
 net/mptcp/pm.c           | 36 ++++++++++++++++++------------------
 net/mptcp/pm_kernel.c    |  7 +++++++
 net/mptcp/pm_userspace.c | 12 ++++++++++++
 net/mptcp/protocol.h     |  2 ++
 5 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5f2d94b2f97f..1f4d0d3988c1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -128,6 +128,8 @@ struct mptcp_pm_ops {
 	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 	void (*subflow_check_next)(struct mptcp_sock *msk,
 				   const struct mptcp_subflow_context *subflow);
+	void (*add_addr_echo)(struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *addr);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8a5c2c06500..dc7ab696c24b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -529,6 +529,22 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	msk->pm.ops->subflow_check_next(msk, subflow);
 }
 
+void mptcp_pm_add_addr_echo(struct mptcp_sock *msk,
+			    const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
+	    (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		mptcp_pm_announce_addr(msk, addr, true);
+		mptcp_pm_add_addr_send_ack(msk);
+	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
+		pm->remote = *addr;
+	} else {
+		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+	}
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
@@ -543,23 +559,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			mptcp_pm_announce_addr(msk, addr, true);
-			mptcp_pm_add_addr_send_ack(msk);
-		} else {
-			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
-		}
-	/* id0 should not have a different address */
-	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
-		mptcp_pm_announce_addr(msk, addr, true);
-		mptcp_pm_add_addr_send_ack(msk);
-	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->remote = *addr;
-	} else {
-		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
-	}
+	pm->ops->add_addr_echo(msk, addr);
 
 	spin_unlock_bh(&pm->lock);
 }
@@ -992,7 +992,7 @@ int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
 	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow ||
-	    !pm_ops->subflow_check_next) {
+	    !pm_ops->subflow_check_next || !pm_ops->add_addr_echo) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index b40d39232f70..d5002236fe6e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1449,6 +1449,12 @@ static void mptcp_pm_kernel_subflow_check_next(struct mptcp_sock *msk,
 	mptcp_pm_subflow_established(msk);
 }
 
+static void mptcp_pm_kernel_add_addr_echo(struct mptcp_sock *msk,
+					  const struct mptcp_addr_info *addr)
+{
+	mptcp_pm_add_addr_echo(msk, addr);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1475,6 +1481,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.subflow_check_next	= mptcp_pm_kernel_subflow_check_next,
+	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 68247ec4cdaa..848102bd0f4b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -715,6 +715,17 @@ static void mptcp_pm_userspace_subflow_check_next(struct mptcp_sock *msk,
 	}
 }
 
+static void mptcp_pm_userspace_add_addr_echo(struct mptcp_sock *msk,
+					     const struct mptcp_addr_info *addr)
+{
+	if (mptcp_userspace_pm_active(msk)) {
+		mptcp_pm_announce_addr(msk, addr, true);
+		mptcp_pm_add_addr_send_ack(msk);
+	} else {
+		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+	}
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -726,6 +737,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.allow_new_subflow	= mptcp_pm_userspace_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
 	.subflow_check_next	= mptcp_pm_userspace_subflow_check_next,
+	.add_addr_echo		= mptcp_pm_userspace_add_addr_echo,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d9ca3a19a218..8ca8eea1795b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1013,6 +1013,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+void mptcp_pm_add_addr_echo(struct mptcp_sock *msk,
+			    const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-- 
2.43.0

