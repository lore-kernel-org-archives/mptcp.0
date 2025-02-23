Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296D20011D
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320456; cv=none; b=dH+2BVbiDi77fbMNM+FFYx/C5CP5j33fdTxBFST5olOuSgIVsV9U3Q6yaJfiLQQKAgbzBqpb1kbJcqS3+EsRtoeBICZe0JjGsD9eVGITCSWpxHgDH2v4RrKKIlWXC8nnFIvCfbfSri1VgTuby8Kd/e9IxVyj2+IZSrhIslp1n4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320456; c=relaxed/simple;
	bh=Xsc8dui0N0ialzW3PijFlPR13UYv7hzFKefGCv5ILD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=athtSQoue+pUv9R0Vuz24QGpj6CTw5z/YrOSJr9zFKTRdXbwiOC0ZrKLWlMFwNnU3dW16hcHobyXF0qBW/sGJttJif+Ezywi7Q5kqzVAvO/HzLpL7h8QrE7YMrV11HlKI7i6VaISxt9/I1Wex5kf5z4eShbL4wVN55wgwqrdlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfWTMBxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfWTMBxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF3C4CEDD;
	Sun, 23 Feb 2025 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320455;
	bh=Xsc8dui0N0ialzW3PijFlPR13UYv7hzFKefGCv5ILD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfWTMBxovK3uSyoJQAkY2o3Tg1Ny3Uzr4ZVRqLYUebiIg8AiTF7GJis07KCYVbTol
	 /ihdVEo0fRbHnNdOpJqVsnvZ+2ERQBtzy4kRYVlRNimBdzWEgSXrx6tpoRYlVdO9a8
	 jJI68wHH0bKIJZhew1etvgRMtfSkjd3lgAGICvpeWmNCH1q2BYvrKHKjckMsT96Ywm
	 T4L2zbqniDfkLLTesinoGCGFah71Y6u/MagKGTWOOfMSsd4m2In/pzRCfH9iSFjRXb
	 CLrDbW//V2aMRqjuEvyoX4ZjW57q6BfFv4iJNQyIQQ9FgDSgGO/ga0vHR1GuNSgUzv
	 +XVO26FV4Pd7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 05/13] mptcp: pm: in-kernel: register mptcp_in_kernel_pm
Date: Sun, 23 Feb 2025 22:19:53 +0800
Message-ID: <31c3324f479d9a59c579d8cc3434aebf48eff252.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a new
struct mptcp_pm_ops named "mptcp_in_kernel_pm", and register it in
mptcp_pm_nl_init().

This mptcp_pm_ops will be skipped in mptcp_pm_unregister().

Only get_local_id() and get_priority() interfaces are implemented here.
mptcp_pm_nl_is_backup() becomes a wrapper of get_priority().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         |  3 +++
 net/mptcp/pm_netlink.c | 18 +++++++++++++++++-
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 97fccd930cd0..07789526eecc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -698,6 +698,9 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 {
+	if (pm == &mptcp_in_kernel_pm)
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 69a2f7aa1825..aa9be671293d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1169,7 +1169,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+static bool mptcp_pm_nl_get_priority(struct mptcp_sock *msk,
+				     struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1183,6 +1184,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 	return backup;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	return mptcp_pm_nl_get_priority(msk, skc);
+}
+
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
@@ -2370,6 +2376,14 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+struct mptcp_pm_ops mptcp_in_kernel_pm = {
+	.get_local_id		= mptcp_pm_nl_get_local_id,
+	.get_priority		= mptcp_pm_nl_get_priority,
+	.type			= MPTCP_PM_TYPE_KERNEL,
+	.name			= "in-kernel",
+	.owner			= THIS_MODULE,
+};
+
 void __init mptcp_pm_nl_init(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
@@ -2377,4 +2391,6 @@ void __init mptcp_pm_nl_init(void)
 
 	if (genl_register_family(&mptcp_genl_family))
 		panic("Failed to register MPTCP PM netlink family\n");
+
+	mptcp_pm_register(&mptcp_in_kernel_pm);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c24e8e1bc13..2b1fd10b4b7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1048,6 +1048,8 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+extern struct mptcp_pm_ops mptcp_in_kernel_pm;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
-- 
2.43.0

