Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8A257453
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804400; cv=none; b=qTI9l9PICMgLyw3CoA01p+83gqUdpqyxhbUnnep1PceH/tAFBZs4kApLiG0X+nSrV6j5wcSlIqXs3tDY6SZE8Z1oCYAp9gLvVIykFWXxcGLmTZW1W72ADRU9e4vIhzbst9JizEGk3nvG83OPq8XIExMFzGjv1G66PtToBdrOZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804400; c=relaxed/simple;
	bh=DL4+csqHUjsaftRsTM0cQCMB7RSYstoo7sRijzVk2yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGAbxiYIfehqXNiIWScL3WrwL0kVBLKbTyKT5c0OUK06BQlNQE1y3JWPRez9i0MF3ygVf8WHHGaOFCvDXMeOrrYkelzWkgBFIpbM7r1XkxGvFSulsThfUj7tHbgDD9dQjhMul/GMj3HMuCIsEjulozLcyQUq/tgHhalThQyw5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHGoYqEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHGoYqEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B6C4CEDD;
	Mon, 24 Mar 2025 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804400;
	bh=DL4+csqHUjsaftRsTM0cQCMB7RSYstoo7sRijzVk2yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHGoYqEEC9TFp1AiDYd2lcAEG0B3PBva4jqcDzclTU60qzKr1ryLiJvu/l49MyLVE
	 VQslTilOpIOezBJ5q4/l2MFZmNPMxVAxF4DEc3EaJIc9v6Uui2dGhVMB3mPA2jRrsV
	 y0ApGowa97TN6fjWyLQ1Lids6oujaT3Ixc9Nb/4VhaDtYPagoZXNAPCtSyfnR9iFaw
	 RMNxxnQKipRqP8ywUpHJHI+WHeJILJBt8fgnDQKSQ3axHGqJyiMdMhrqj3yL3Zvi/L
	 VCSGN0yTAgb33wWuE7rL9JxWRRRBqA9mIG1POgCdLhxMwbMWvAn94WZRKgY4cKqwwB
	 ZCHSDCUBgotfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/9] mptcp: pm: add add_addr_received() interface
Date: Mon, 24 Mar 2025 16:19:39 +0800
Message-ID: <0b18abccee51f68bb1e0016426159df0b2ca1e36.1742804266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
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

This interface is only implemented in the in-kernel PM as a wrapper
of mptcp_pm_nl_add_addr_received().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  1 +
 net/mptcp/pm.c        | 18 +++++++++++-------
 net/mptcp/pm_kernel.c | 24 +++++++++++-------------
 net/mptcp/protocol.h  |  1 -
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4ac936e4ce0d..5118d11d2ee9 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -127,6 +127,7 @@ struct mptcp_pm_ops {
 	/* optional */
 	void (*established)(struct mptcp_sock *msk);
 	void (*subflow_established)(struct mptcp_sock *msk);
+	void (*add_addr_received)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8efb47331f79..71589cd5dee7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -607,10 +607,11 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
-	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->remote = *addr;
-	} else {
-		ret = -EINVAL;
+	} else if (pm->ops->add_addr_received) {
+		if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
+			pm->remote = *addr;
+		else
+			ret = -EINVAL;
 	}
 
 	if (ret)
@@ -948,6 +949,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		return;
 
 	pr_debug("msk=%p status=%x\n", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
+		spin_lock_bh(&pm->lock);
+		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->add_addr_received(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
 		spin_lock_bh(&pm->lock);
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
@@ -972,9 +979,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		spin_unlock_bh(&pm->lock);
 		pm->ops->subflow_established(msk);
 	}
-	spin_lock_bh(&pm->lock);
-	__mptcp_pm_kernel_worker(msk);
-	spin_unlock_bh(&pm->lock);
 }
 
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 2e181224bccb..4f4791620072 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -461,12 +461,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
+	spin_lock_bh(&msk->pm.lock);
 	remote = msk->pm.remote;
 	mptcp_pm_announce_addr(msk, &remote, true);
 	mptcp_pm_addr_send_ack(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
-		return;
+		goto out;
 
 	/* pick id 0 port, if none is provided the remote address */
 	if (!remote.port)
@@ -477,7 +478,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	 */
 	nr = fill_local_addresses_vec(msk, &remote, locals);
 	if (nr == 0)
-		return;
+		goto out;
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
@@ -493,6 +494,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
+out:
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
@@ -1342,17 +1345,6 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
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
@@ -1394,6 +1386,11 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static void mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk)
+{
+	mptcp_pm_nl_add_addr_received(msk);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1419,6 +1416,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.established		= mptcp_pm_kernel_established,
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
+	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 64aa091cb685..7fa26c49fbed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1164,7 +1164,6 @@ void __init mptcp_pm_kernel_register(void);
 void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
-void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.43.0

