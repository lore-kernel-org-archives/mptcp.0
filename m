Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11448188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075349; cv=none; b=alg4lEC49AgKt3yCXogJ7tbnspNwkbShIlkRfT+AcM8/aYHP9Apb4Jml1kwqWmDRk6igY+tXmNcuVVyRpuUF4X3WwE53RICEHk6b5p+xENroze5jBNB77Y9AjuV3vArmIu0UQxr3wx1SQBDeWNST40hONKTKKFuWcQditOphNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075349; c=relaxed/simple;
	bh=wuRqZaBq6Gt2EISuKHOha2Lra1rccqIq6gAmpG2gKko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6Ae19fzgZoAK5PO/aTZa+8WZ4aDhk+z7+R9kxpt/WA8JZeHMk64ec6qw4C2hw3nze/Bxx111xXcxalxvAxiEme2fYnW4JIdlWwQjRUR5pLaFAniBoJx79OC4ATMr9Qv3HxKg2u0PYlWRO8Y2ht/ZWyC/kkjsfZm5LHPdd/tsP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpfvoT4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpfvoT4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3577C4CED0;
	Fri, 13 Dec 2024 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075348;
	bh=wuRqZaBq6Gt2EISuKHOha2Lra1rccqIq6gAmpG2gKko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpfvoT4N0YqfLQJjWvxxPb8I+WzBpb2nb4vV1hKdmg3YzXWOtq3fuwl2OAHPNfj7y
	 QWEfO6dz3Lq3FboaKiNja9COPd6XXt5yjqq6jWInJogjo6XGD5GGLG9pDqDsM8JTi9
	 /xUqWDxta0AehzG8jIZ8tTImiYdFJoUo7z3OSoVYjsGc4xDNCJT6WHTw4HDlGIXNJd
	 eam7zf8e37NZ/mrGzUSMb3Z0MI7dyUZHJbCuCT9t0/XJ96o0xB2V2cERi/JdIypO0h
	 3BTZ8BPVpuRGz3mv4hI7+ww0CdC7cI+P8Jq4H+JCmCbDWNRlTSuP+Cur7ciEUXKRHU
	 OTXsvJh1bw7Kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/8] mptcp: change info of get_addr as const
Date: Fri, 13 Dec 2024 15:35:26 +0800
Message-ID: <42a61bb9dc5ab239e65723b0d5322e5684565ca5.1734074788.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_addr() interfaces will be invoked by dump_addr(), which using const
parameters 'info', so this patch changes 'info' parameters of get_addr()
as const too.

Some adaptations are also needed. No longer use genl_info_pm_nl() because
it doesn't accept a 'const' variable, but that's OK to get pernet via
genl_info_net().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 2 +-
 net/mptcp/pm_netlink.c   | 7 +++++--
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9f3d82a86746..080c842e9e90 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -435,7 +435,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+			     const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(id, addr, info);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dce6a5b5ea4d..eb5f48e45187 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1763,12 +1763,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 }
 
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			 struct genl_info *info)
+			 const struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
 	int ret = -EINVAL;
 
+	pernet = pm_nl_get_pernet(net);
+
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, id);
 	if (entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6dd5a3f1c0c7..7c5914012947 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -664,7 +664,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a80a0191e2cd..a9fc30f20376 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,9 +1132,9 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			 struct genl_info *info);
+			 const struct genl_info *info);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info);
+				const struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

