Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31281EEA31
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935184; cv=none; b=V28OJf2dsrweTtrQuaSAI9odcNj9BPL1Gd4+NwSRofapDpbDs2Npm8cSyw3aascWthqfI3sBB/9FzOvjf6hkIcDzRCz7uF2O9cjveR7wujbXp+1k0+ZpFIsVlwyryjWKmZKf85OKBch5hADJafhKV7DZu1AoUg2m6oEPMhUryIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935184; c=relaxed/simple;
	bh=mReufQBMfhEAFgVxSJjYHyXTepa6JXN6QhJtShKUhQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9O9tkOkYEVLo7pdelAYyRSvxAy4tYbTk5OKe/PyFym7U8xdJYOjSUquUvMUJRMDQG/e4TKft9GgCQJjyCPWXA6jpP/eOEfxVoG0q70Gc49i00ls6yotOy7nwj+NHzfT07nqTHnKZFgnVXjpCxl5JWot0zX5Gw/D/PoLJFi1LkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTTiJn4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTTiJn4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AE6C4AF09;
	Wed, 15 Jan 2025 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935183;
	bh=mReufQBMfhEAFgVxSJjYHyXTepa6JXN6QhJtShKUhQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTTiJn4S/N16+1QG/As+HwZNnXwVKAe9F7yay6TWarGy/wt+MS/fvMLHi60r9sMc8
	 ujRZbEXt32wFQF5dijy/3GMAF3vdoAf6m5HlS28dxYKPzMUDdAvNgjdvMam2RdcFE8
	 +6A33o8hSM4ztflkDEKE/VwgxHsP9q/Ur9ZHG6rWom0JBcmb4QNBaNp034RBm//Iqs
	 Koq13LQBP4sXD6utMmOhLv9Anb806Z6RcKPC8JwWYMgfILferQWbG1d3MM+oUgVk/y
	 1XCFn51RSAlYab57CsM+2TYY/4NUB5QYw/SM3T5fru6oeNm9jVjPdwOUeN4ZgxP3F4
	 bjcpZxzM2WutQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/6] mptcp: add mptcp_pm_genl_fill_addr helper
Date: Wed, 15 Jan 2025 17:59:27 +0800
Message-ID: <b7d1f9586daa954681f5c4ecac44145382fd97dd.1736935086.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736935086.git.tanggeliang@kylinos.cn>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To save some redundant code in dump_addr() interfaces of both the
netlink PM and userspace PM, the code that calls netlink message
helpers (genlmsg_put/cancel/end) and mptcp_nl_fill_addr() is wrapped
into a new helper mptcp_pm_genl_fill_addr().

This helper will also be used in BPF path managers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 12 +-----------
 net/mptcp/pm_userspace.c | 12 +-----------
 net/mptcp/protocol.h     |  3 +++
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b1f36dc1a091..16cacce6c10f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -489,6 +489,27 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
+		return -EINVAL;
+
+	if (mptcp_nl_fill_addr(msg, entry) < 0) {
+		genlmsg_cancel(msg, hdr);
+		return -EINVAL;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fef01692eaed..afd517ff260c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1798,7 +1798,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
-	void *hdr;
 	int i;
 
 	pernet = pm_nl_get_pernet(net);
@@ -1813,19 +1812,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			if (entry->addr.id <= id)
 				continue;
 
-			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-			if (!hdr)
+			if (mptcp_pm_genl_fill_addr(msg, cb, entry))
 				break;
 
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
-				genlmsg_cancel(msg, hdr);
-				break;
-			}
-
 			id = entry->addr.id;
-			genlmsg_end(msg, hdr);
 		}
 	}
 	rcu_read_unlock();
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 277cf092a870..b50462b527bd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -641,7 +641,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
 
 	bitmap = (struct id_bitmap *)cb->ctx;
 
@@ -657,19 +656,10 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
+		if (mptcp_pm_genl_fill_addr(msg, cb, entry))
 			break;
 
-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
-		}
-
 		__set_bit(entry->addr.id, bitmap->map);
-		genlmsg_end(msg, hdr);
 	}
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6fb536de9981..20941405a1ea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1060,6 +1060,9 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 					      struct request_sock *req);
 int mptcp_nl_fill_addr(struct sk_buff *skb,
 		       struct mptcp_pm_addr_entry *entry);
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.43.0

