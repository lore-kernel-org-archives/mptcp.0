Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9926AF3
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320457; cv=none; b=d9P7oURlzXL8QZ+7GfganBJE45f2wje9eMZiZXjD2aOSsiitmqXr1p/Rmk3nM0iomGh6cUBMYX0V2q2+bojiQgeDtx5SVo6JfQD74qbc1uiCOisZJBYq5oyflY6+1+ltsaSlg4CFoCnq00B5dYj3YBrZa5B/6cdeofbf7CWoerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320457; c=relaxed/simple;
	bh=5Sn0zIAVm9N4vMd5hNctTQH/4eEQPRs8hY+rvaSfGvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faxd59HcgdC338+Bc51SfbtLTTN4PPUK89/XgMegzMnwS0g3v0e32df/RgBULbpbyRa6CTMPGv1Ha0z95BVGAShwVrMagRdDS0OCgCUneZDvVnmpLPhXO6LUcl/fqdups6KlZ8OH4yQ8dTrZj+CEgVtHnundDvwalC4AatRNYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLxmr8AS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLxmr8AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E90FC4CEE7;
	Sun, 23 Feb 2025 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320457;
	bh=5Sn0zIAVm9N4vMd5hNctTQH/4eEQPRs8hY+rvaSfGvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLxmr8ASq7xpT+JUP5o31AoPW85Ri5JxUVmPJos/jn8IaoS8nDrCpHgrQF1/Ecuwl
	 QIep96nmKLLfpP758/9xueJt7Fsv0dkA/BHpIi+so1TYVPXdbz0KPmXrCA87Y92z+E
	 XB/ilOSLTgKzoWJz3kgC3HfQ3ajAHwCAUOs3j518P2jMIeWkiLL1gSfnoE+CjCI0yt
	 2unwquQp7cpPU6gmKQdB6ELRZRsBy1MZu3njZr/KwcCBqCdnxs8Gz1uktickXc9FX7
	 Wlzc11OcFMIGT1ygtR2NQvLecZNvN3oEKf42xUq2wqVvQ5FqiaBWgGrPJx5Cyn1DPK
	 gmXga+UfnB8BQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 06/13] mptcp: pm: userspace: register mptcp_userspace_pm
Date: Sun, 23 Feb 2025 22:19:54 +0800
Message-ID: <98a4bc2ad44a9152fc60af934cca874e235f6b01.1740320007.git.tanggeliang@kylinos.cn>
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

This patch defines the original userspace path manager as a new struct
mptcp_pm_ops named "mptcp_userspace_pm", and register it in
mptcp_pm_data_init().

Only get_local_id() and get_priority() interfaces are implemented here.
mptcp_userspace_pm_is_backup() becomes a wrapper of get_priority().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  1 +
 net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++--
 net/mptcp/protocol.h     |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 07789526eecc..9e1a2e6d9c03 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -651,6 +651,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
 
 /* Must be called with rcu read lock held */
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5b3ee43130be..17450cf8f920 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -149,8 +149,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool mptcp_userspace_pm_get_priority(struct mptcp_sock *msk,
+					    struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
@@ -163,6 +163,12 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	return backup;
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	return mptcp_userspace_pm_get_priority(msk, skc);
+}
+
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct mptcp_sock *msk;
@@ -686,3 +692,16 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.get_local_id		= mptcp_userspace_pm_get_local_id,
+	.get_priority		= mptcp_userspace_pm_get_priority,
+	.type			= MPTCP_PM_TYPE_USERSPACE,
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_userspace_pm_init(void)
+{
+	mptcp_pm_register(&mptcp_userspace_pm);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2b1fd10b4b7e..301a0f192305 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1160,6 +1160,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-- 
2.43.0

