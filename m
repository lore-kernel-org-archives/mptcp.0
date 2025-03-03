Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5613C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975929; cv=none; b=rTNSwplk2vN6HbHfDus3sUNtCymzf16DSwdfpatHTfDYDTmW+hBM+yY549a+OkpJ7XmPWGTw2gyutGfmTtjwqcPAZtD7Fd9z9tT2CLSNZ0CH9cEbaAcaSSDo/W2Hkq8ExIfJatUvrd9c52S1D5SuYia9vYjoKD7ES1YcDkdBP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975929; c=relaxed/simple;
	bh=/obAZ/p8txEGMS8nVk5B6uUtHuCtnvFQtryRPmNDRbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVSJez2fT4IF2XkhHqyv4Hbpbk8kyj6UQhMct7nl95pyk+AHhmdxN8iKzx2fvyZUryjMhhvgMHtFejSDSDa1bp6qFORmtsb7BiCzjAT7hQaA1wQr33VfPKgd0ojt5lT5JZXKCemkI9XeKMoNh5vkyMgFP1z3ZG+7rGPIK3noFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL5bvBeM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL5bvBeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1028C4CED6;
	Mon,  3 Mar 2025 04:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975928;
	bh=/obAZ/p8txEGMS8nVk5B6uUtHuCtnvFQtryRPmNDRbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sL5bvBeMA0gmECKtRJJYp/G+su4OkkhcttcpcT71nc/cdbapGkHC//WzBT6Ur+xYt
	 RH/svLOoywUZsU4wtJ9O6ljMd9SkRcYBIFGGKgRbhS91ynHzwv2y6Nk19wcHD5zzTO
	 jqXv8aqgbzxhSwRmyZA1+6hNs/YUxApeu6PaknQ8EWwokMDHHxv7edt6WcnwoufXqg
	 n8+/71cHo1V0CoTXWLRCgHppAx4xqmLHmzkRYkGXFI3Dc25DK7u3iAECl7rrXwjMdu
	 v8ZcGTSsSviE3nQpVROeOQO0YFRyZ1KnE5ZDncPDSx3zxDzGrvUyM30p1X6sZ8bkpm
	 4NtCe7z0II7KQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 05/11] mptcp: pm: in-kernel: register mptcp_kernel_pm
Date: Mon,  3 Mar 2025 12:22:53 +0800
Message-ID: <3296a3aee3aa62e1645ab55f6ffce891cdbcc00d.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a
new struct mptcp_pm_ops named "mptcp_kernel_pm", and register it in
mptcp_pm_nl_init().

This mptcp_pm_ops will be skipped in mptcp_pm_unregister().

Only get_local_id() and get_priority() interfaces are implemented here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        | 3 +++
 net/mptcp/pm_kernel.c | 9 +++++++++
 net/mptcp/protocol.h  | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 88ff136b3786..e648cb522320 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1075,6 +1075,9 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 {
+	if (pm == &mptcp_kernel_pm)
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index daf8f98a3164..8a5966e6e3e3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1400,6 +1400,13 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+struct mptcp_pm_ops mptcp_kernel_pm = {
+	.get_local_id		= mptcp_pm_nl_get_local_id,
+	.get_priority		= mptcp_pm_nl_is_backup,
+	.name			= "kernel",
+	.owner			= THIS_MODULE,
+};
+
 void __init mptcp_pm_nl_init(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
@@ -1407,4 +1414,6 @@ void __init mptcp_pm_nl_init(void)
 
 	if (genl_register_family(&mptcp_genl_family))
 		panic("Failed to register MPTCP PM netlink family\n");
+
+	mptcp_pm_register(&mptcp_kernel_pm);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9dbfde4027b3..56d3a7457f80 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1051,6 +1051,8 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+extern struct mptcp_pm_ops mptcp_kernel_pm;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
-- 
2.43.0

