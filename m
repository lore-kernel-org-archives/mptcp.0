Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8FF510
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920351; cv=none; b=f3OBqrAZMqlmTtbcYK2BRJ906KicScg7+l40+F+ZG87+4Kkd+9TmQGmQjRnJcQdEH/NGB2Z6AoMOz72MLccaKqs2/jcOXYnTv/fi6rVuOY+MNRL1AYA1690INZSuPV7rSFzhOhVfZFWmZTEx669K+EW1SRRI4JdC/b5+3gQz5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920351; c=relaxed/simple;
	bh=/LNGkYJzR2zeuvw9HwZoU4iTrqekQ2ciCtreeh80hQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqH4ELAOHPREpctcNP+93Dtb0r0NZ6ZAktjIqgyjGs6HIuFGzUH62VUY7L5xPz4t8ZfMKrUxw/lir3WA/xrvSDA0/j27JPXR0Uri1RQkKNPeMHTCpsIjrNdxoPMIoM8ySXxMZtJ08KQ2UmwzZKgGxrirbICOeTN82ThDsWZMNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaJNMXKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaJNMXKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE96C4AF09;
	Fri, 14 Mar 2025 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920351;
	bh=/LNGkYJzR2zeuvw9HwZoU4iTrqekQ2ciCtreeh80hQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaJNMXKR3RD8aQHENMs3Lw+LsGZK/nXshtbzepPUmiZY64qnVnbKDPyQATwJfESOQ
	 bf5v6mLUg5w4jAA69ejhTmIHtJmkoC/RgljP6/0kecKpVm07wjqg/D3PELuY5tHRAM
	 KKTUFMKmbT5N0uT4p7nObYlvt4dNKGp+b2AKTghBI5edgGFw49+yE+1mu74fuY421T
	 6pL/TRmTwOnIEtfRN/38p1LZekBSIugRqVFbJcIlPyHo56dGFRmV2T03AV7Y1zv8lb
	 S5KbGmpIDElRhX2WWcHBRtV6L7H60HCv5IGOkBofcuah6BM1R5jlyzk0QRByIuhbUY
	 zZjMvpxdMQHJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 04/10] mptcp: pm: add subflow_established() interface
Date: Fri, 14 Mar 2025 10:45:25 +0800
Message-ID: <f74a7bdd20558201456aafd9bcbb0d7fd67e33f6.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a .subflow_established interface for struct mptcp_pm_ops,
and calls pm->ops->subflow_established in from mptcp_pm_worker(). Then
get rid of the corresponding code from __mptcp_pm_kernel_worker().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  1 +
 net/mptcp/pm.c        | 11 +++++++++--
 net/mptcp/pm_kernel.c |  7 ++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d7410f08399e..4ac936e4ce0d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -126,6 +126,7 @@ struct mptcp_pm_ops {
 
 	/* optional */
 	void (*established)(struct mptcp_sock *msk);
+	void (*subflow_established)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3dcece1c6fef..b90134152b92 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -544,7 +544,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -571,6 +571,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 	}
 
+	if (!pm->ops->subflow_established)
+		return;
+
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
@@ -633,7 +636,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -969,6 +972,10 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
 		pm->ops->established(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		pm->ops->subflow_established(msk);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1234066b5bcc..e21fefc0aca9 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -372,7 +372,7 @@ static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
@@ -1348,10 +1348,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1419,6 +1415,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.45.2

