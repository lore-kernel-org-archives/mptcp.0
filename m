Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090F360
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675597; cv=none; b=nSVWQc8k0OnI0NguYKA5WoZhHtSk8aBpQkYf0t/KX+gOYBcxcyA4+6TsxUPYcNDR27Q9MdEK9udL/RW8d55baWVSWt1cj/jnPuGLJXFvDhQ8yzGCUyEfHGjiE5ZXaAfKmMRor//ekhO6OvQAHkD108WUl95qV1bODRO+4e56vXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675597; c=relaxed/simple;
	bh=oNWnP3dFUGf54fFAbPaMRgKKSKm2ROkfP3OqKveubjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9A9Dexeg3+BVq18VpfCDrajWwJKEm32KQoJdQ/M+h2mbCl1FRPUupKCAQk5R+TStnEpAGH+anx/DDD4f7fvqLBJeKu6tbwxVreMMfqrM6aZ0oBo16wr77I00szfwA3qkMS+tSsvw6xayoK7caW2sNZxSA6NERssEA+458KlAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uddc+HKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uddc+HKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F809C4CEE9;
	Tue, 11 Mar 2025 06:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741675597;
	bh=oNWnP3dFUGf54fFAbPaMRgKKSKm2ROkfP3OqKveubjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uddc+HKDc6I0LphX6UpRfr3TqC0t4MIfRrciBfqF/PD13/JA2K65LhJ0k6AjOHtoC
	 jfYpf5SYA6LLGiZW6qcwGUWD7USsHHvZmuUyGSIIIysyCQxK2B9l86bNDsQH/q9gQ+
	 6H1WgQiQ5qgVjZVC7a+xynvgYEW2cgiTbnBig6AWlDbkETdPHi06jDfyQ0+icptSLm
	 K/bSk9xm06ku+HSFbtHzhGsYf6qrZROQ4ZJiUX4QjwcdtqlwMc+kX2spXIyRYcIwpY
	 ETBWgUMCaQvTqvRvwzscId11pNlAawC4zLwsY3FLgt1WZDsypHKSdf2KjGsJSJ3A9q
	 MJAMhW6zFBANw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH RESEND mptcp-next v11 02/10] mptcp: pm: register in-kernel and userspace PM
Date: Tue, 11 Mar 2025 14:46:19 +0800
Message-ID: <2928be52eee7f083a74c71eeb70c6c046cf5450c.1741674285.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250311064619.aWiEXVBbk5B29PeElHl2sxc9TiNJneaw7h1FiO7Km8c@z>

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a
new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
mptcp_pm_kernel_register(). And define the userspace path manager as
a new struct mptcp_pm_ops named "mptcp_pm_userspace", and register it
in mptcp_pm_init().

To ensure that there's always a valid path manager available, the default
path manager "mptcp_pm_kernel" will be skipped in mptcp_pm_unregister().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  5 +++++
 net/mptcp/pm_kernel.c    |  7 +++++++
 net/mptcp/pm_userspace.c | 10 ++++++++++
 net/mptcp/protocol.h     |  4 ++++
 4 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f4948a2cf9be..3896f21a46bd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1018,6 +1018,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_kernel_register();
+	mptcp_pm_userspace_register();
 	mptcp_pm_nl_init();
 }
 
@@ -1061,6 +1062,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
 {
+	/* skip unregistering the default path manager */
+	if (WARN_ON_ONCE(pm_ops == &mptcp_pm_kernel))
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm_ops->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 806a9b5b3c07..d39e7c178460 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1398,8 +1398,15 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+struct mptcp_pm_ops mptcp_pm_kernel = {
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
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 13856df22673..2cb62f026b1f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -682,3 +682,13 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_pm_userspace_register(void)
+{
+	mptcp_pm_register(&mptcp_pm_userspace);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2307f2fcbe9d..f87c71550394 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1052,6 +1052,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+/* the default path manager, used in mptcp_pm_unregister */
+extern struct mptcp_pm_ops mptcp_pm_kernel;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
@@ -1160,6 +1163,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_kernel_register(void);
+void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-- 
2.43.0

