Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C184846C
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521551; cv=none; b=Z9jyteid9iVr6pI4YbxXwo62BTPICJtZoSf5humH/ehX5q0+PC6FQkWG5qB/KBEIPW7+as/38wS9fpjdBe2k2z7Rm5ltfcDxtVT59vSdCBznS0a5TxzSBKtIFB08e1Hbv1Yf3p9IG0O50wT4E9uIC8sho/Bnq96DSKMNympIca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521551; c=relaxed/simple;
	bh=2DBIuUqvmYi/fQb5PiPsCLnmpslQP1MsqlQvZ4gn+cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnsYj4qZOxwutO6/dZh0hNws3OL233p5X0jDtUqPrIecw9wh0PKoQ51QUA2/RNmtc2gREjnN26WfCtff4MBjCpEHG0YltMLpXQoPiHHUt8cN5iP60wqKXqWNVn1ilJXY6mMSN6CojyC9qXcGYIeNzrKn2PR/a6wSVv7i4lhIF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV23F5LL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV23F5LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE62C4CEDD;
	Fri, 21 Mar 2025 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521551;
	bh=2DBIuUqvmYi/fQb5PiPsCLnmpslQP1MsqlQvZ4gn+cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV23F5LLA14dQ6g98E9XX3AdVtlH1wfwStJpCRsif5LIiDt13x8lcKjxSgO8W7suu
	 XNV7S/VdyUBZ6VQdXa0fPBHfxW1pJfkxczydgQWUMa2QKPwQdc0TIxGBR62kxGy0MY
	 7OHr3K03Fd1Ro0ysrC5S0bsu2oDH2Qw6iNWAxKt8zLs+FkELTolXHbVk6/A1JZd0mw
	 Rx6OaL5beOr0Ttm2e7myUoJwyn87aUXZbPJMNlSt6iQj3sTKaz5tCClnkK29xhPeDh
	 eAQHo6gXsiF09lDKPhrRoCdw/iROzi3TKH9G2WUCokTqG5W8H6g/X27GkhxOe8TfVP
	 PBhAhM9yaHogQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 07/10] mptcp: pm: add add_addr_received() interface
Date: Fri, 21 Mar 2025 09:45:01 +0800
Message-ID: <2d7bb2ff8960c244aee00ec314f23edd0f5577df.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds an optional .add_addr_received interface for struct
mptcp_pm_ops and invokes it in mptcp_pm_add_addr_received(). A new helper
mptcp_pm_add_addr_recv() is added to allow the MPTCP_PM_ADD_ADDR_RECEIVED
worker can be invoke from the in-kernel PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  4 ++++
 net/mptcp/pm.c        |  9 +++++++--
 net/mptcp/pm_kernel.c | 13 +++++++++++++
 net/mptcp/protocol.h  |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index de9838ea37c4..37a84b4c661e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,10 @@ struct mptcp_pm_ops {
 	bool (*allow_new_subflow)(struct mptcp_sock *msk);
 	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 
+	/* optional */
+	int (*add_addr_received)(struct mptcp_sock *msk,
+				 const struct mptcp_addr_info *addr);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d2e72e36d80e..28bd91819ec1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -559,6 +559,11 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk)
+{
+	return mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
@@ -586,10 +591,10 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
-	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->remote = *addr;
 	} else {
 		ret = -EINVAL;
+		if (pm->ops->add_addr_received)
+			ret = pm->ops->add_addr_received(msk, addr);
 	}
 
 	if (ret)
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index c89a8524e70e..314e62da84c4 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1426,6 +1426,18 @@ static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.accept_subflow);
 }
 
+static int mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk,
+					     const struct mptcp_addr_info *addr)
+{
+	int ret = 0;
+
+	if (mptcp_pm_add_addr_recv(msk))
+		msk->pm.remote = *addr;
+	else
+		ret = -EINVAL;
+	return ret;
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1453,6 +1465,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 64aa091cb685..ea44f552b3a4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1014,6 +1014,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-- 
2.43.0

