Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD0C2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494595; cv=none; b=sIyvF5dgdUV7Wtls3/jhmNfxDL6M30lCDvf3hvPuGTIxjHMWw0OWF3trdzVrSs7SuXg8YfWWgTAOKjaGG4hwvmUKNxVu2WJ5k0iUV5ObqzCHgItN+cpdUIUG4ON3xE0BDU7lCTIoUut6Raew/SNeUgZmkB8vLFHg/2e5p4NZaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494595; c=relaxed/simple;
	bh=bTi/AVjc70mAsAvJ4C5NzT/h43K972ZsGTSR78YgYdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+A5eMGOIm91CU6D/iudxcayQvW/1V5/q3mCeQJ2f+EpmOy+IeentyXG9N/IcB4mFZDQEXd4YSmLMPGsVj0lXy0Aa5UVLnl0clZa6C21wOmWY5XD0lQ8cN6nZ5lM1nsi4Yuq1Te4dJLlJkNw5XDWf0IbY4yBHrokzpxF4DQZ/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1YWaXbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1YWaXbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69384C4CEDF;
	Fri, 10 Jan 2025 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494594;
	bh=bTi/AVjc70mAsAvJ4C5NzT/h43K972ZsGTSR78YgYdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1YWaXbxuGHAltc659qfls31oLRXOm2K8BVOphtInCM0AcKigQeS094+BLEoExf+V
	 LMSBp73Xcgn5nFr/DMWGRxHW7CJX6r0gwZVw1oBbOrv1qWTMjAvpFJwVV9qnh/KMnR
	 sc52DeTSOydcZy0vwR07qs8z0Su9vead0Xiji1SvkRfNwggc2p7lNCQzgUMXdlrlzW
	 TtXaxx8w6GGU5MdDoyyamCXRsPVL9cfzvXGXyxXEx1xRQJ1RuIf235FVXyUse6qPXR
	 06ic4QPkiuwgsuGJj33v1l6si70LDDlsOUiCKPVwAT2k/1zZB6rZ/Oo5T0/agt+eDL
	 718D+SOJPBdFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/7] mptcp: drop skb parameter of set_flags
Date: Fri, 10 Jan 2025 15:36:18 +0800
Message-ID: <5632831c6e9e2845ab70c4fd690c39446404a8ce.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameter 'skb' in mptcp_pm_nl_set_flags() is only used to
obtained the network namespace, which can also be obtained through the
second parameters 'info' by using genl_info_net() helper. This patch
drops these useless parameters 'skb' in all three set_flags() interfaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 8 ++++----
 net/mptcp/pm_netlink.c   | 4 ++--
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba22d17c1451..c213f06bc702 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -504,16 +504,16 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return mptcp_pm_dump_addr(msg, cb);
 }
 
-static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_set_flags(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(skb, info);
-	return mptcp_pm_nl_set_flags(skb, info);
+		return mptcp_userspace_pm_set_flags(info);
+	return mptcp_pm_nl_set_flags(info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(skb, info);
+	return mptcp_pm_set_flags(info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 181d3b87eb25..52fd9830b685 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,12 +1951,12 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	struct nlattr *attr;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index eaa02879de43..008c6367a75c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -564,7 +564,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a43481c40577..aa014f514af3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,8 +1028,8 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.45.2

