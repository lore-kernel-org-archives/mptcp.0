Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5B1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088456; cv=none; b=BRCVTRNm5UV6ttMb2lWF3U0/cqsAl/dQhpopQuGK0CgIsRX2ktHF0DagPYejNRbmYKTZgmgF7dfTJvAV6qk/U9bcJojb2NYwh+HEr3HHP+IN9jdIu+DdeVxv2LixY8sXN2x4ko6CMBfyzkIXKTvI29SMY4AjZpdANOGm9sqOr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088456; c=relaxed/simple;
	bh=uXFFIXiuMCSlu42AECY9nVz9kE16q1RrBYXcZyeVnSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBiyrvKv7Aqu8oEHac3MESK/09+ldDiLT5srDqhm3PZy7z0lhrEIMozaGqxumvoJmZ4D81CdBtiYOP1AGUTha+TaefDSbvZoJ0LVIvJ1RmOsXfECycTptPqptTWgoE1GcqRgXnJPUZdTpe/4kpbYjv4bSHb/910eyN1tgPEUmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI10oBgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI10oBgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F21CC4CEE9;
	Tue,  4 Mar 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088456;
	bh=uXFFIXiuMCSlu42AECY9nVz9kE16q1RrBYXcZyeVnSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QI10oBgJ9LvTN3Y81/RKweUoG+UD31nLmLTgRBmWpvJ31qdFY1MCkiAjoX0sAkJJg
	 v5Nv6VMABZ6JXywajAjgc30obNbJy6shM3ltAnyx9yKx4Yhvj/ikpSYxJOUXFQwtl7
	 C3Asz6Mz21xcWCFO1jWUVbnrXeKEbUWS7SeHga+9XXrjoRilBI6TP7B6ri3q4ui8kJ
	 nnFpGN+GTW6gajETG7IToHgAkV2Rl4AQOck99gtmJDhxwzzctzM0dMqvTPsIUJ+2Iw
	 MrgqYHIMv3SrXVXBEnEDM4nqh9vcDwRsyd0FvEPaDgIDXZOIIK4Ppfwh+hZviup5HG
	 Myq6ugaQfzQqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 06/12] mptcp: pm: in-kernel: register mptcp_pm_kernel
Date: Tue,  4 Mar 2025 19:40:33 +0800
Message-ID: <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a
new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
mptcp_pm_kernel_register().

This mptcp_pm_ops will be skipped in mptcp_pm_unregister().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        |  4 ++++
 net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
 net/mptcp/protocol.h  |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a2b210873b23..28ea8bdaa8b0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 {
+	/* skip unregistering the default path manager */
+	if (pm == &mptcp_pm_kernel)
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 806a9b5b3c07..e6a1aef738a8 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1398,8 +1398,34 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static void mptcp_pm_nl_initialize(struct mptcp_sock *msk)
+{
+	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	/* pm->work_pending must be only be set to 'true' when
+	 * pm is the default path manager
+	 */
+	WRITE_ONCE(pm->work_pending,
+		   (!!mptcp_pm_get_local_addr_max(msk) &&
+		    subflows_allowed) ||
+		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->accept_addr,
+		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+		   subflows_allowed);
+	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+}
+
+struct mptcp_pm_ops mptcp_pm_kernel = {
+	.init			= mptcp_pm_nl_initialize,
+	.name			= "kernel",
+	.owner			= THIS_MODULE,
+};
+
 void __init mptcp_pm_kernel_register(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
 		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
+	mptcp_pm_register(&mptcp_pm_kernel);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 246b44db9775..f700cb55bf49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1050,6 +1050,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+/* the default path manager, used in mptcp_pm_unregister */
+extern struct mptcp_pm_ops mptcp_pm_kernel;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
-- 
2.43.0

