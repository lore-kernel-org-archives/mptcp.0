Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD71BFE00
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743481823; cv=none; b=LXURrugnCMGJFp1ekQ2/XSWF9DT8Pvl0a2kbS+u/7i7OpnRSiv8byeckfsuDzvyfb6/CDRgO89921jzTZDHMeDCKoYVv3Q66We7jPwDCeU/0phZEvecOSIuN2MH2FbasXdWL6ScmMqpe373AxFRnLQlpuONPEUA0hjrkANXLqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743481823; c=relaxed/simple;
	bh=u0kJ6SsfbEqXkn9bPrklhCaVJ3IU1BPK7SABFK0nBOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3Uo6sOmk/e1nvPScPoI4laSFoHWzn/IFExXVg4IYlILs9C28UHb9ajMfbR7yrSYZKwqGAWtPSMsqZt16Au6If0mYwZuR2VdsXfflUykbH7VqvQuQIu6yUkkKltt/7fHKQrBTJunA0wo62iRkahDOJEFHocYeZloE0ZPsMRuI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmpZE5tn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmpZE5tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D6BC4CEEA;
	Tue,  1 Apr 2025 04:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743481822;
	bh=u0kJ6SsfbEqXkn9bPrklhCaVJ3IU1BPK7SABFK0nBOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmpZE5tnqGiOkiVCG+q7bUKMafj3H+GvRhFsre98WryGfYKc40sGdXFVh0t1cvPyT
	 JtVKlGOtKwrBDViyP/O2JsYpWKTkR8cTS/JH3/b+lMtI4l0RSOgNL2nWKcvkw7uY+w
	 AOQGu3IikVjgcEh+PWeUydNmaqdQdbRcev1xGdVU6XaoKfLlobV7NhbgQPfBRUtHfp
	 hq7BxfI59s75rw3HqX1MYTwduP6L/LRccKUri8yohky0gixKUldASdmBdM3CSZchfi
	 14IC9v2ekY38Bx+9TeU/eb2jM1ZxMZc3JaaYFdDz16DbQrOb1rancw8bD9uTOovLjy
	 JLmT2ID/xTGiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] mptcp: pm: add add_addr_received() interface
Date: Tue,  1 Apr 2025 12:30:10 +0800
Message-ID: <d4c73b49701b37d248a3f22785e266303c15d33a.1743481566.git.tanggeliang@kylinos.cn>
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

This patch adds an optional .add_addr_received interface for struct
mptcp_pm_ops and invokes it in mptcp_pm_worker().

__mptcp_pm_kernel_worker() helper can be dropped now.

This interface is only implemented in the in-kernel PM as a wrapper
of mptcp_pm_nl_add_addr_received().

ADD_ADDR echo is moved forward from mptcp_pm_nl_add_addr_received()
to mptcp_pm_add_addr_received().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  3 +++
 net/mptcp/pm.c        | 22 ++++++++++------------
 net/mptcp/pm_kernel.c | 23 +++++++----------------
 net/mptcp/protocol.h  |  1 -
 4 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d6bb030b14c6..d63d251932ac 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -133,6 +133,9 @@ struct mptcp_pm_ops {
 	bool (*accept_new_address)(struct mptcp_sock *msk,
 				   const struct mptcp_addr_info *addr);
 
+	/* optional, call from the msk context */
+	void (*add_addr_received)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 519beb8cadfa..39d0ad715d26 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -596,15 +596,13 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_is_userspace(msk)) {
-		mptcp_pm_announce_addr(msk, addr, true);
-		mptcp_pm_add_addr_send_ack(msk);
-	} else if (!mptcp_pm_accept_address(msk, addr)) {
-		mptcp_pm_announce_addr(msk, addr, true);
-		mptcp_pm_add_addr_send_ack(msk);
-	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
+	mptcp_pm_announce_addr(msk, addr, true);
+	mptcp_pm_add_addr_send_ack(msk);
+
+	if (pm->ops->add_addr_received &&
+	    mptcp_pm_accept_address(msk, addr) &&
+	    mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
 		pm->remote = *addr;
-	}
 
 	spin_unlock_bh(&pm->lock);
 }
@@ -932,7 +930,8 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
-	u8 status, mask = BIT(MPTCP_PM_ADD_ADDR_SEND_ACK) |
+	u8 status, mask = BIT(MPTCP_PM_ADD_ADDR_RECEIVED) |
+			  BIT(MPTCP_PM_ADD_ADDR_SEND_ACK) |
 			  BIT(MPTCP_PM_RM_ADDR_RECEIVED) |
 			  BIT(MPTCP_PM_ESTABLISHED) |
 			  BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
@@ -949,6 +948,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 
 	pr_debug("msk=%p status=%x\n", msk, status);
+	if (status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED))
+		pm->ops->add_addr_received(msk);
 	if (status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK))
 		mptcp_pm_addr_send_ack(msk);
 	if (status & BIT(MPTCP_PM_RM_ADDR_RECEIVED))
@@ -957,9 +958,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->ops->established(msk);
 	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED))
 		pm->ops->subflow_established(msk);
-	spin_lock_bh(&pm->lock);
-	__mptcp_pm_kernel_worker(msk);
-	spin_unlock_bh(&pm->lock);
 }
 
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index defd8312a764..dff880b030d1 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -448,7 +448,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	return i;
 }
 
-static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
@@ -465,12 +465,11 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
+	spin_lock_bh(&msk->pm.lock);
 	remote = msk->pm.remote;
-	mptcp_pm_announce_addr(msk, &remote, true);
-	__mptcp_pm_addr_send_ack(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
-		return;
+		goto out;
 
 	/* pick id 0 port, if none is provided the remote address */
 	if (!remote.port)
@@ -481,7 +480,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	 */
 	nr = fill_local_addresses_vec(msk, &remote, locals);
 	if (nr == 0)
-		return;
+		goto out;
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
@@ -497,6 +496,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
+out:
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
@@ -1346,17 +1347,6 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
-/* Called under PM lock */
-void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_data *pm = &msk->pm;
-
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
-		mptcp_pm_nl_add_addr_received(msk);
-	}
-}
-
 static int __net_init pm_nl_init_net(struct net *net)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
@@ -1447,6 +1437,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.established		= mptcp_pm_kernel_established,
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.accept_new_address	= mptcp_pm_kernel_accept_new_address,
+	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 910d422d64fa..128c081810d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1167,7 +1167,6 @@ void __init mptcp_pm_kernel_register(void);
 void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
-void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.43.0

